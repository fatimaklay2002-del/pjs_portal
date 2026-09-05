import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../core/errors/error_handler.dart';
import '../../../core/service/notification_service.dart';
import '../../../core/session/user_session.dart';
import '../data/repositories/auth_repository.dart';
import 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // 1. تسجيل الدخول
      await _repository.login(email: email, password: password);

      // 2. جلب بيانات العضو من members مباشرة
      final member = await _repository.getCurrentMember();
      if (member == null) {
        emit(AuthError('لم يتم العثور على بيانات العضو، تواصل مع المسؤول'));
        return;
      }

      // 3. حفظ في UserSession قبل emit
      UserSession.instance.setMember(member);
      // 4. إطلاق الحالة
      emit(AuthAuthenticated(member));
      await NotificationService.onLogin();
    } catch (e) {
      emit(AuthError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> logout() async {
    try {
      await NotificationService.onLogout();
      await _repository.logout();
      UserSession.instance.clear();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
// auth_cubit.dart — checkAuthState المصحّح
  Future<void> checkAuthState() async {
    try {
      final session = supabase.Supabase.instance.client.auth.currentSession;

      if (session != null && !session.isExpired) {
        final member = await _repository.getCurrentMember();
        if (member != null) {
          UserSession.instance.setMember(member);
          emit(AuthAuthenticated(member));
          return;
        }
      } else if (session != null && session.isExpired) {
        try {
          final response = await supabase.Supabase.instance.client.auth.refreshSession();
          if (response.session != null) {
            final member = await _repository.getCurrentMember();
            if (member != null) {
              UserSession.instance.setMember(member);
              emit(AuthAuthenticated(member));
              return;
            }
          }
        } catch (_) {}
      }

      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }
  void forceSignedOut() {
    emit(AuthUnauthenticated());
  }
}