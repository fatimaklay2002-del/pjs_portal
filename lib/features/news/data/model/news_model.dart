class NewsModel {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final String category; // 'عام', 'تدريبي', 'خدمات', 'اجتماعي'
  final bool isFeatured;
  final String? actionLink;
  final String? actionLinkLabel;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.category,
    this.isFeatured = false,
    this.actionLink,
    this.actionLinkLabel,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });
  bool get hasActionLink => actionLink != null && actionLink!.trim().isNotEmpty;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      category: json['category'] as String,
      isFeatured: json['is_featured'] as bool? ?? false,
      actionLink: json['action_link'] as String?,
      actionLinkLabel: json['action_link_label'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'category': category,
      'is_featured': isFeatured,
      'action_link': actionLink,
      'action_link_label': actionLinkLabel,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Copy with method
  NewsModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? category,
    bool? isFeatured,
    String? actionLink,
    String? actionLinkLabel,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFeatured: isFeatured ?? this.isFeatured,
      actionLink: actionLink ?? this.actionLink,
      actionLinkLabel: actionLinkLabel ?? this.actionLinkLabel,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
