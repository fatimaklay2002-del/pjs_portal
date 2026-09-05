import 'package:equatable/equatable.dart';

import '../data/model/notification_model.dart';

abstract class NotificationsState extends Equatable {
  @override List<Object?> get props => [];
}
class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  final int unreadCount;
  NotificationsLoaded(this.notifications)
      : unreadCount = notifications.where((n) => !n.isRead).length;
  @override List<Object?> get props => [notifications];
}
class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
  @override List<Object?> get props => [message];
}
