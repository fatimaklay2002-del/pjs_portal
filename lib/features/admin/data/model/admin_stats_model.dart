class AdminStatsModel {
  final int totalMembers;
  final int permanentMembers;
  final int temporaryMembers;
  final int pendingRequests;
  final int totalNews;
  final int pendingInquiries;
  final int pendingComplaints;

  const AdminStatsModel({
    required this.totalMembers,
    required this.permanentMembers,
    required this.temporaryMembers,
    required this.pendingRequests,
    required this.totalNews,
    required this.pendingInquiries,
    required this.pendingComplaints,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      totalMembers: json['total_members'] as int? ?? 0,
      permanentMembers: json['permanent_members'] as int? ?? 0,
      temporaryMembers: json['temporary_members'] as int? ?? 0,
      pendingRequests: json['pending_requests'] as int? ?? 0,
      totalNews: json['total_news'] as int? ?? 0,
      pendingInquiries: json['pending_inquiries'] as int? ?? 0,
      pendingComplaints: json['pending_complaints'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_members': totalMembers,
      'permanent_members': permanentMembers,
      'temporary_members': temporaryMembers,
      'pending_requests': pendingRequests,
      'total_news': totalNews,
      'pending_inquiries': pendingInquiries,
      'pending_complaints': pendingComplaints,
    };
  }

  AdminStatsModel copyWith({
    int? totalMembers,
    int? permanentMembers,
    int? temporaryMembers,
    int? pendingRequests,
    int? totalNews,
    int? pendingInquiries,
    int? pendingComplaints,
  }) {
    return AdminStatsModel(
      totalMembers: totalMembers ?? this.totalMembers,
      permanentMembers: permanentMembers ?? this.permanentMembers,
      temporaryMembers: temporaryMembers ?? this.temporaryMembers,
      pendingRequests: pendingRequests ?? this.pendingRequests,
      totalNews: totalNews ?? this.totalNews,
      pendingInquiries: pendingInquiries ?? this.pendingInquiries,
      pendingComplaints: pendingComplaints ?? this.pendingComplaints,
    );
  }
}