import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../membership/data/model/membership_request_model.dart';

class AdminMembershipRepository {
  final SupabaseClient _supabase;

  AdminMembershipRepository(this._supabase);

  Future<List<MembershipRequestModel>> getPendingRequests() async {
    try {
      final response = await _supabase
          .from('membership_requests')
          .select()
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => MembershipRequestModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('فشل في جلب الطلبات');
    }
  }

  Future<MembershipRequestModel> getRequestById(String requestId) async {
    try {
      final response = await _supabase
          .from('membership_requests')
          .select()
          .eq('id', requestId)
          .single();

      return MembershipRequestModel.fromJson(response);
    } catch (e) {
      throw Exception('فشل في جلب تفاصيل الطلب');
    }
  }

  Future<String> approveRequestAndCreateAccount({
    required String requestId,
    required MembershipRequestModel request,
    required String membershipType,
    String role = 'journalist',
  }) async {
    try {
      // `members` flat columns + `member_details` jsonb groups — mirrors
      // MemberRepository.updateMemberCore/upsertMemberDetails shape.
      final memberData = {
        'email': request.email,
        'full_name_ar': request.fullNameAr,
        'full_name_en': request.fullNameEn,
        'id_passport_number': request.idPassportNumber,
        'phone_number': request.phoneNumber,
        'personal_info': request.personalInfo.toJson(),
        'address_info': request.addressInfo.toJson(),
        'professional_info': request.professionalInfo.toJson(),
        'documents_urls': request.documentsUrls.toJson(),
      };

      final response = await _supabase.functions.invoke(
        'approve-member',
        body: {
          'requestId':      requestId,
          'email':          request.email,
          'fullName':       request.fullNameAr,
          'membershipType': membershipType,
          'role':           role,
          'memberData':     memberData,
        },
      );

      if (response.status != 200) {
        final data = response.data;
        final errorMsg = (data is Map) ? (data['error'] ?? 'فشل في قبول الطلب') : 'فشل في قبول الطلب';
        throw Exception(errorMsg);
      }

      final responseData = response.data;
      if (responseData is Map && responseData.containsKey('password')) {
        return responseData['password'] as String;
      } else {
        throw Exception('لم يتم إرجاع كلمة المرور من السيرفر بشكل صحيح');
      }
    } catch (e) {
      throw Exception('فشل في قبول الطلب');
    }
  }

  Future<void> rejectRequest(String requestId) async {
    try {
      await _supabase.from('membership_requests').delete().eq('id', requestId);
    } catch (e) {
      throw Exception('فشل في رفض الطلب');
    }
  }


  String? getDocumentUrl(String? relativePath) {
    if (relativePath == null || relativePath.isEmpty) return null;
    try {
      return _supabase.storage.from('documents').getPublicUrl(relativePath);
    } catch (e) {
      return null;
    }
  }
}