import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String content;
  final bool pinned;
  final bool deleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    this.pinned = false,
    this.deleted = false,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  /// Firestore ve JSON uyumlu parser
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is String) return DateTime.tryParse(value);
      if (value is Timestamp) return value.toDate();
      return null;
    }

    return NoteModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      pinned: json['pinned'] ?? false,
      deleted: json['deleted'] ?? false,
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
      deletedAt: parseDate(json['deletedAt']),
    );
  }

  /// Firestore’a kaydetmek için JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'pinned': pinned,
      'deleted': deleted,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
      if (deletedAt != null) 'deletedAt': Timestamp.fromDate(deletedAt!),
    };
  }

  /// Kopya oluşturma
  NoteModel copyWith({
    String? title,
    String? content,
    bool? pinned,
    bool? deleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      pinned: pinned ?? this.pinned,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
