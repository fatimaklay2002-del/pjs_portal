import 'package:equatable/equatable.dart';

import '../data/model/membership_request_model.dart';

abstract class MembershipState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state
class MembershipInitial extends MembershipState {}

/// Loading state
class MembershipLoading extends MembershipState {}

/// Success state (request submitted)
class MembershipSuccess extends MembershipState {
  final String message;

  MembershipSuccess([this.message = 'تم تقديم الطلب بنجاح']);

  @override
  List<Object?> get props => [message];
}

/// Error state
class MembershipError extends MembershipState {
  final String message;

  MembershipError(this.message);

  @override
  List<Object?> get props => [message];
}
class RequestsLoaded extends MembershipState {
  final List<MembershipRequestModel> requests;
  RequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}
class StatusUpdatedSuccess extends MembershipState {}
/// File upload progress state
class FileUploadProgress extends MembershipState {
  final double progress; // 0.0 to 1.0

  FileUploadProgress(this.progress);

  @override
  List<Object?> get props => [progress];
}
