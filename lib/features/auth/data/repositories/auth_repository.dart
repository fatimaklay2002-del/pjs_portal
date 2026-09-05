import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../members/data/model/member_model.dart';
class AuthRepository {
final SupabaseClient _supabase;

AuthRepository(this._supabase);

Future<AuthResponse> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('فشل تسجيل الدخول');
    }

    return response;
  } on AuthException catch (e) {
    throw Exception(_mapAuthError(e.message));
  } catch (e) {
    rethrow;
  }
}

/// جلب بيانات المستخدم الحالية من جدول members
Future<MemberModel?> getCurrentMember() async {
  try {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) return null;

    final data = await _supabase
        .from('members')
        .select()
        .eq('id', authUser.id)
        .maybeSingle();

    if (data == null) return null;
    return MemberModel.fromJson(data);
  } catch (e) {
    return null;
  }
}

Future<void> logout() async {
  await _supabase.auth.signOut();
}

// ── Map Supabase auth errors to Arabic ───────
String _mapAuthError(String message) {
  if (message.contains('Invalid login credentials')) {
    return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
  }
  if (message.contains('Email not confirmed')) {
    return 'يرجى تأكيد بريدك الإلكتروني أولاً';
  }
  if (message.contains('Too many requests')) {
    return 'محاولات كثيرة، يرجى الانتظار قليلاً';
  }
  return 'حدث خطأ، يرجى المحاولة مجدداً';
}
}
