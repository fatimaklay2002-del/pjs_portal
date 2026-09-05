
import 'package:pjs_portal/core/models/address_edu_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/documents_urls.dart';
import '../../../../core/models/personal_info.dart';
import '../../../../core/models/professional_info.dart';
import '../../../../core/session/user_session.dart';
import '../model/member_model.dart';

class MemberRepository {
  final SupabaseClient _supabase;
  MemberRepository(this._supabase);

  static const _selectWithDetails = '*, member_details(*)';

  Future<MemberModel> fetchCurrentMember() async {
    final id = UserSession.instance.currentMember.id;
    final data = await _supabase
        .from('members')
        .select(_selectWithDetails)
        .eq('id', id)
        .single();
    return MemberModel.fromJson(data);
  }

  /// Updates only the flat identity columns that actually live on `members`.
  Future<void> updateMemberCore({
    required String memberId,
    required String fullNameAr,
    required String fullNameEn,
    required String? idPassportNumber,
    required String? phoneNumber,
  }) async {
    try {
      await _supabase.from('members').update({
        'full_name_ar': fullNameAr,
        'full_name_en': fullNameEn,
        'id_passport_number': idPassportNumber,
        'phone_number': phoneNumber,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', memberId);
    } catch (e) {
      throw Exception('فشل تحديث بيانات العضو');
    }
  }

  /// Upserts the jsonb profile blob on `member_details`.
  Future<void> upsertMemberDetails({
    required String memberId,
    required PersonalInfo personalInfo,
    required AddressEduInfo addressInfo,
    required ProfessionalInfo professionalInfo,
    required DocumentsUrls documentsUrls,
  }) async {
    try {
      await _supabase.from('member_details').upsert({
        'user_id': memberId,
        'personal_info': personalInfo.toJson(),
        'address_info': addressInfo.toJson(),
        'professional_info': professionalInfo.toJson(),
        'documents_urls': documentsUrls.toJson(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('فشل تحديث بيانات الملف الشخصي');
    }
  }
}


