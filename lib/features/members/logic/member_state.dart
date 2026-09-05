import '../data/model/member_model.dart';

abstract class MemberState {}
class MemberInitial extends MemberState {}
class MemberLoading extends MemberState {}
class MemberLoaded extends MemberState {
  final MemberModel member;
  MemberLoaded(this.member);
}
class MemberActionSuccess extends MemberState {
  final String message;
  MemberActionSuccess(this.message);
}
class MemberError extends MemberState {
  final String message;
  MemberError(this.message);
}