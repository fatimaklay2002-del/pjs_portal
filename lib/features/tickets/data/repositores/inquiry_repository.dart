import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/session/user_session.dart';
import '../model/ticket_model.dart';

class InquiryRepository {
final SupabaseClient _supabase;
InquiryRepository(this._supabase);

static const _complaintSubject = 'شكوى';

Future<List<TicketModel>> fetchMyInquiries() => _fetchMine('inquiry');
Future<List<TicketModel>> fetchMyComplaints() => _fetchMine('complaint');

Future<List<TicketModel>> _fetchMine(String ticketType) async {
  try {
    final userId = UserSession.instance.authId;
    final data = await _supabase
        .from('tickets')
        .select()
        .eq('user_id', userId)
        .eq('ticket_type', ticketType)
        .order('created_at', ascending: false);
    return (data as List).map((e) => TicketModel.fromJson(e)).toList();
  } catch (e) {
    throw Exception('فشل جلب البيانات');
  }
}

Future<void> sendInquiry({required String subject, required String message}) {
  return _create(ticketType: 'inquiry', subject: subject, description: message);
}

Future<void> sendComplaint({required String description}) {
  return _create(ticketType: 'complaint', subject: _complaintSubject, description: description);
}

Future<void> _create({
  required String ticketType,
  required String subject,
  required String description,
}) async {
  try {
    final userId = UserSession.instance.authId;
    await _supabase.from('tickets').insert({
      'user_id': userId,
      'ticket_type': ticketType,
      'subject': subject,
      'description': description,
    });
  } catch (e) {
    throw Exception(ticketType == 'inquiry' ? 'فشل إرسال الاستفسار' : 'فشل إرسال الشكوى');
  }
}
}
