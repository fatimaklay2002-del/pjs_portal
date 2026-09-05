import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/members/data/model/member_model.dart';
import '../Constants/app_constants.dart';

class UserSession {
  static final UserSession _instance = UserSession._internal();
  static UserSession get instance => _instance;
  UserSession._internal();

  // بيانات العضو المسجل دخوله
  MemberModel? _currentMember;

  // ─── Getters ───────────────────────────────────────

  /// الـ auth user id من Supabase
  String get authId {
    final id = Supabase.instance.client.auth.currentUser?.id;
    if (id == null) throw Exception('No authenticated user');
    return id;
  }

  String get memberId {
    if (_currentMember == null) throw Exception('Member data not loaded');
    return _currentMember!.id;
  }

  /// بيانات العضو الكاملة
  MemberModel get currentMember {
    if (_currentMember == null) throw Exception('Member data not loaded');
    return _currentMember!;
  }

  /// هل هو أدمن؟
  bool get isAdmin => _currentMember?.role == AppConstants.roleAdmin;

  /// هل البيانات محملة؟
  bool get isLoaded => _currentMember != null;

  // ─── Setters ───────────────────────────────────────

  /// احفظ بيانات العضو بعد تسجيل الدخول
  void setMember(MemberModel member) {
    _currentMember = member;
  }

  /// امسح البيانات عند تسجيل الخروج
  void clear() {
    _currentMember = null;
  }
}