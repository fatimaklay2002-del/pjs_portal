import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/membership_request_model.dart';

class MembershipRepository {
  final SupabaseClient _supabase;
  MembershipRepository(this._supabase);

  Future<void> submitRequest(MembershipRequestModel request) async {
    try {
      await _supabase.from('membership_requests').insert(request.toJson());
    } catch (e) {
      throw Exception('فشل في إرسال طلب العضوية');
    }
  }

  Future<bool> checkIfExists(String email, String fullNameAr) async {
    try {
      final byEmail = await _supabase
          .from('membership_requests')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      if (byEmail != null) return true;

      final byName = await _supabase
          .from('membership_requests')
          .select('id')
          .eq('full_name_ar', fullNameAr)
          .maybeSingle();
      return byName != null;
    } catch (e) {
      debugPrint('❌ Search Error: $e');
      return false;
    }
  }

  Future<List<MembershipRequestModel>> getAllRequests() async {
    try {
      final response = await _supabase
          .from('membership_requests')
          .select()
          .order('created_at', ascending: false);
      return (response as List)
          .map((json) => MembershipRequestModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('فشل في جلب الطلبات');
    }
  }

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      await _supabase.from('membership_requests').update({
        'status': status,
        'reviewed_at': DateTime.now().toIso8601String(),
      }).eq('id', requestId);
    } catch (e) {
      throw Exception('فشل في تحديث حالة الطلب');
    }
  }
}
