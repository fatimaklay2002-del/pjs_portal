import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/session/user_session.dart';
import '../model/ticket_model.dart';

class AdminTicketsRepository {
  final SupabaseClient _supabase;
  AdminTicketsRepository(this._supabase);

  static const _selectWithUser = '*, members!tickets_user_id_fkey(full_name_ar)';

  Future<List<TicketModel>> fetchAllInquiries() => _fetchAll('inquiry');
  Future<List<TicketModel>> fetchAllComplaints() => _fetchAll('complaint');

  Future<List<TicketModel>> _fetchAll(String ticketType) async {
    try {
      final data = await _supabase
          .from('tickets')
          .select(_selectWithUser)
          .eq('ticket_type', ticketType)
          .order('created_at', ascending: false);
      return (data as List).map((e) => TicketModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(ticketType == 'inquiry' ? 'فشل جلب الاستفسارات' : 'فشل جلب الشكاوى');
    }
  }

  Future<void> replyToInquiry({
    required String inquiryId,
    required String response,
  }) async {
    final admin = UserSession.instance.currentMember;
    await _supabase.from('tickets').update({
      'status': 'resolved',
      'admin_reply': response,
      'replied_by': admin.id,
      'replied_at': DateTime.now().toIso8601String(),
    }).eq('id', inquiryId);
  }

  Future<void> updateComplaintStatus({
    required String complaintId,
    required String status,
  }) async {
    await _supabase.from('tickets').update({'status': status}).eq('id', complaintId);
  }
}
