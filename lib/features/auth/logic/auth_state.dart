import 'package:equatable/equatable.dart';

import '../../members/data/model/member_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {}

/// Loading state (during login/logout)
class AuthLoading extends AuthState {}

/// Authenticated state (user logged in)
class AuthAuthenticated extends AuthState {
  final MemberModel user;

  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated state (user logged out)
class AuthUnauthenticated extends AuthState {}

/// Error state
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}