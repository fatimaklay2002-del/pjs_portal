import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/session/user_session.dart';
import '../data/model/notification_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final SupabaseClient _supabase;
  RealtimeChannel? _channel;

  NotificationsCubit(this._supabase) : super(NotificationsInitial());

  Future<void> loadAndSubscribe() async {
    await loadNotifications();
    _subscribeRealtime();
  }

  Future<void> loadNotifications() async {
    try {
      emit(NotificationsLoading());

      // ✅ استخدم members.id وليس auth.uid مباشرة
      if (!UserSession.instance.isLoaded) {
        emit(NotificationsLoaded([]));
        return;
      }

      final memberId = UserSession.instance.currentMember.id;
      final data = await _supabase
          .from('notifications')
          .select()
          .eq('user_id', memberId)  // ← members.id
          .order('created_at', ascending: false);

      final list = (data as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      emit(NotificationsLoaded(list));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  void _subscribeRealtime() {
    if (!UserSession.instance.isLoaded) return;
    _channel?.unsubscribe();
    final memberId = UserSession.instance.currentMember.id;

    _channel = _supabase
        .channel('notifications:$memberId')
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'notifications',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'user_id',
        value: memberId,
      ),
      callback: (payload) {
        // Prepend new notification to existing list
        final currentState = state;
        if (currentState is NotificationsLoaded) {
          try {
            final newNotification = NotificationModel.fromJson(
              payload.newRecord,
            );
            emit(NotificationsLoaded([
              newNotification,
              ...currentState.notifications,
            ]));
          } catch (_) {
            loadNotifications(); // fallback to full reload only if parsing fails
          }
        }
      },
    )
        .subscribe();
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
      await loadNotifications();
    } catch (_) {}
  }

  Future<void> markAllAsRead() async {
    try {
      if (!UserSession.instance.isLoaded) return;
      final memberId = UserSession.instance.currentMember.id;
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', memberId)
          .eq('is_read', false);
      await loadNotifications();
    } catch (_) {}
  }

  int get unreadCount {
    final state = this.state;
    if (state is NotificationsLoaded) {
      return state.notifications.where((n) => !n.isRead).length;
    }
    return 0;
  }

  @override
  Future<void> close() {
    _channel?.unsubscribe();
    return super.close();
  }
  void clear() {
    _channel?.unsubscribe();
    _channel = null;
    emit(NotificationsInitial());
  }
}