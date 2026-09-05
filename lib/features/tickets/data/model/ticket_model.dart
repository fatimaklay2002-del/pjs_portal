class TicketModel {
  final String id;
  final String userId;
  final String? userName;
  final String ticketType; // 'inquiry' | 'complaint'
  final String subject;
  final String description;
  final String status; // 'pending' | 'under_processing' | 'resolved'
  final String? adminReply;
  final String? repliedBy;
  final DateTime? repliedAt;
  final DateTime createdAt;

  const TicketModel({
    required this.id,
    required this.userId,
    this.userName,
    required this.ticketType,
    required this.subject,
    required this.description,
    this.status = 'pending',
    this.adminReply,
    this.repliedBy,
    this.repliedAt,
    required this.createdAt,
  });

  bool get isInquiry => ticketType == 'inquiry';
  bool get isComplaint => ticketType == 'complaint';
  bool get isReplied => adminReply != null && adminReply!.isNotEmpty;

  String get statusText => switch (status) {
    'under_processing' => 'قيد المعالجة',
    'resolved' => 'تم الحل',
    _ => 'مراجعة',
  };

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    final member = json['members'] as Map<String, dynamic>?;
    return TicketModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userName: member?['full_name_ar'] as String?,
      ticketType: json['ticket_type'] as String,
      subject: json['subject'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      adminReply: json['admin_reply'] as String?,
      repliedBy: json['replied_by'] as String?,
      repliedAt: json['replied_at'] != null
          ? DateTime.parse(json['replied_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
