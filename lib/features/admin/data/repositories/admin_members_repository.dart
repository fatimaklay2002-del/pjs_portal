import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../members/data/model/member_model.dart';

class AdminMembersRepository {
  final SupabaseClient _supabase;

  AdminMembersRepository(this._supabase);

  /// جلب كافة الأعضاء بشكل خام لترك التصفية الآمنة والسريعة لذاكرة التطبيق (الكاش)
  Future<List<MemberModel>> getAllMembers() async {
    try {
      final response = await _supabase
          .from('members')
          .select()
          .select('*, member_details(*)')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => MemberModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('فشل في جلب الأعضاء');
    }
  }

  Future<void> deleteMember(String memberId, String authUserId) async {
    try {
      final response = await _supabase.functions.invoke(
        'delete-member',
        body: {
          'memberId':   memberId,
          'authUserId': authUserId,
        },
      );

      if (response.status != 200) {
        final errorMsg = response.data?['error'] ?? 'فشل في حذف العضو';
        throw Exception(errorMsg);
      }
    } catch (e) {
      throw Exception('فشل في حذف العضو');
    }
  }

  Future<void> changeMemberRole({
    required String memberId,
    required String newRole,
  }) async {
    try {
      await _supabase
          .from('members')
          .update({
        'role': newRole,
        'updated_at': DateTime.now().toIso8601String(),
      })
          .eq('id', memberId);
    } catch (e) {
      throw Exception('فشل في تغيير الصلاحية');
    }
  }

  Future<void> changeMembershipType({
    required String memberId,
    required String newType,
  }) async {
    try {
      await _supabase
          .from('members')
          .update({
        'membership_type': newType,
        'updated_at': DateTime.now().toIso8601String(),
      })
          .eq('id', memberId);
    } catch (e) {
      throw Exception('فشل في تغيير نوع العضوية');
    }
  }
}