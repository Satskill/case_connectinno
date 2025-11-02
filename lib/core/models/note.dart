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

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      pinned: json['pinned'] ?? false,
      deleted: json['deleted'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'pinned': pinned,
    'deleted': deleted,
  };

  NoteModel copyWith({
    String? title,
    String? content,
    bool? pinned,
    bool? deleted,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      pinned: pinned ?? this.pinned,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}
