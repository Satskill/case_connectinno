import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import express, { Request, Response, NextFunction } from "express";
import cors from "cors";

admin.initializeApp();
const db = admin.firestore();
const app = express();

app.use(cors({ origin: true }));
app.use(express.json());

// --- Helper types ---
type AuthRequest = Request & { user?: admin.auth.DecodedIdToken };

// --- Auth middleware: bearer token (Firebase ID token) ---
async function authenticate(req: AuthRequest, res: Response, next: NextFunction) {
  try {
    const authHeader = req.header("authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({ error: "Unauthorized: Missing Bearer token." });
    }
    const idToken = authHeader.split("Bearer ")[1];
    if (!idToken) return res.status(401).json({ error: "Unauthorized: Invalid token format." });

    const decoded = await admin.auth().verifyIdToken(idToken);
    req.user = decoded;
    return next();
  } catch (err: any) {
    console.error("Auth error:", err);
    return res.status(401).json({ error: "Unauthorized: Token verification failed." });
  }
}

// --- Validation helpers ---
function validateNotePayload(payload: any) {
  const errors: string[] = [];
  if (!payload) {
    errors.push("Missing request body.");
    return errors;
  }
  if (typeof payload.title !== "undefined" && typeof payload.title !== "string") {
    errors.push("title must be a string.");
  }
  if (typeof payload.content !== "undefined" && typeof payload.content !== "string") {
    errors.push("content must be a string.");
  }
  if (typeof payload.pinned !== "undefined" && typeof payload.pinned !== "boolean") {
    errors.push("pinned must be boolean.");
  }
  return errors;
}

// --- Firestore serialization helper ---
function serializeFirestoreData(data: FirebaseFirestore.DocumentData) {
  return Object.fromEntries(
    Object.entries(data).map(([k, v]) => {
      if (v && typeof (v as any).toDate === "function") {
        return [k, (v as any).toDate().toISOString()];
      }
      return [k, v];
    })
  );
}

// --- Collection ref ---
const NOTES_COLLECTION = "notes";

// --- POST /notes -> create a note ---
app.post("/notes", authenticate, async (req: AuthRequest, res: Response) => {
  try {
    const uid = req.user!.uid;
    const payload = req.body;
    const errors = validateNotePayload(payload);
    if (errors.length) return res.status(400).json({ error: "Validation failed", details: errors });

    if (!payload.title && !payload.content) {
      return res.status(400).json({ error: "At least one of title or content must be provided." });
    }

    const now = admin.firestore.FieldValue.serverTimestamp();
    const note = {
      ownerId: uid,
      title: payload.title ?? "",
      content: payload.content ?? "",
      pinned: !!payload.pinned,
      createdAt: now,
      updatedAt: now,
      deleted: false,
      deletedAt: null,
    };

    const docRef = await db.collection(NOTES_COLLECTION).add(note);
    const created = await docRef.get();

    return res.status(201).json({
      id: docRef.id,
      data: serializeFirestoreData(created.data()!),
    });
  } catch (err) {
    console.error("Create note error:", err);
    return res.status(500).json({ error: "Internal server error while creating note." });
  }
});

// --- GET /notes -> list user's notes with optional search/filter ---
app.get("/notes", authenticate, async (req: AuthRequest, res: Response) => {
  try {
    const uid = req.user!.uid;
    const q = String(req.query.q ?? "").trim();
    const filterPinned = req.query.pinned;
    const includeDeleted = req.query.includeDeleted === "true";
    const limit = Math.min(Number(req.query.limit ?? 100), 500);

    let queryRef: FirebaseFirestore.Query = db
      .collection(NOTES_COLLECTION)
      .where("ownerId", "==", uid);

    if (!includeDeleted) queryRef = queryRef.where("deleted", "==", false);

    if (typeof filterPinned !== "undefined") {
      if (filterPinned === "true" || filterPinned === "false") {
        queryRef = queryRef.where("pinned", "==", filterPinned === "true");
      } else {
        return res.status(400).json({ error: "Invalid pinned filter; allowed: true or false." });
      }
    }

    const snapshot = await queryRef.orderBy("updatedAt", "desc").limit(limit).get();
    let notes = snapshot.docs.map((d) => ({
      id: d.id,
      ...serializeFirestoreData(d.data()),
    }));

    if (q) {
      const lower = q.toLowerCase();
      notes = notes.filter(
        (n: any) =>
          (n.title && n.title.toLowerCase().includes(lower)) ||
          (n.content && n.content.toLowerCase().includes(lower))
      );
    }

    notes.sort((a: any, b: any) => {
      if (a.pinned === b.pinned) {
        const ta = new Date(a.updatedAt ?? 0).getTime();
        const tb = new Date(b.updatedAt ?? 0).getTime();
        return tb - ta;
      }
      return a.pinned ? -1 : 1;
    });

    return res.json({ count: notes.length, notes });
  } catch (err) {
    console.error("List notes error:", err);
    return res.status(500).json({ error: "Internal server error while fetching notes." });
  }
});

// --- PUT /notes/:id -> update a note ---
app.put("/notes/:id", authenticate, async (req: AuthRequest, res: Response) => {
  try {
    const uid = req.user!.uid;
    const id = req.params.id;
    if (!id) return res.status(400).json({ error: "Missing note id in path." });

    const payload = req.body;
    const errors = validateNotePayload(payload);
    if (errors.length) return res.status(400).json({ error: "Validation failed", details: errors });

    const docRef = db.collection(NOTES_COLLECTION).doc(id);
    const doc = await docRef.get();
    if (!doc.exists) return res.status(404).json({ error: "Note not found." });

    const data = doc.data()!;
    if (data.ownerId !== uid) return res.status(403).json({ error: "Forbidden: not the owner." });

    const updateData: any = { updatedAt: admin.firestore.FieldValue.serverTimestamp() };
    if (typeof payload.title !== "undefined") updateData.title = payload.title;
    if (typeof payload.content !== "undefined") updateData.content = payload.content;
    if (typeof payload.pinned !== "undefined") updateData.pinned = payload.pinned;
    if (typeof payload.deleted !== "undefined") {
      updateData.deleted = !!payload.deleted;
      updateData.deletedAt = payload.deleted
        ? admin.firestore.FieldValue.serverTimestamp()
        : null;
    }

    await docRef.update(updateData);
    const updatedDoc = await docRef.get();
    return res.json({ id: updatedDoc.id, data: serializeFirestoreData(updatedDoc.data()!) });
  } catch (err) {
    console.error("Update note error:", err);
    return res.status(500).json({ error: "Internal server error while updating note." });
  }
});

// --- DELETE /notes/:id -> soft delete (supports force=true for hard delete) ---
app.delete("/notes/:id", authenticate, async (req: AuthRequest, res: Response) => {
  try {
    const uid = req.user!.uid;
    const id = req.params.id;
    if (!id) return res.status(400).json({ error: "Missing note id in path." });

    const force = req.query.force === "true";
    const docRef = db.collection(NOTES_COLLECTION).doc(id);
    const doc = await docRef.get();
    if (!doc.exists) return res.status(404).json({ error: "Note not found." });

    const data = doc.data()!;
    if (data.ownerId !== uid) return res.status(403).json({ error: "Forbidden: not the owner." });

    if (force) {
      await docRef.delete();
      return res.json({ id, deleted: true, method: "hard" });
    } else {
      await docRef.update({
        deleted: true,
        deletedAt: admin.firestore.FieldValue.serverTimestamp(),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      const updated = await docRef.get();
      return res.json({
        id: updated.id,
        data: serializeFirestoreData(updated.data()!),
        deleted: true,
        method: "soft",
      });
    }
  } catch (err) {
    console.error("Delete note error:", err);
    return res.status(500).json({ error: "Internal server error while deleting note." });
  }
});

// --- POST /notes/:id/restore -> restore soft-deleted note ---
app.post("/notes/:id/restore", authenticate, async (req: AuthRequest, res: Response) => {
  try {
    const uid = req.user!.uid;
    const id = req.params.id;
    const docRef = db.collection(NOTES_COLLECTION).doc(id);
    const doc = await docRef.get();
    if (!doc.exists) return res.status(404).json({ error: "Note not found." });

    const data = doc.data()!;
    if (data.ownerId !== uid) return res.status(403).json({ error: "Forbidden: not the owner." });

    await docRef.update({
      deleted: false,
      deletedAt: null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    const updated = await docRef.get();
    return res.json({ id: updated.id, data: serializeFirestoreData(updated.data()!) });
  } catch (err) {
    console.error("Restore note error:", err);
    return res.status(500).json({ error: "Internal server error while restoring note." });
  }
});

// --- Expose Express app ---
export const api = functions.https.onRequest(app);
