import '../../members/data/model/member_model.dart';

abstract class SettingsState {}
class SettingsInitial extends SettingsState {}
class SettingsLoading extends SettingsState {}
class GetMemberDataLoading extends SettingsState {}
class SettingsLoaded extends SettingsState {
  final MemberModel member;
  SettingsLoaded(this.member);
}
class GetMemberDataSuccess extends SettingsState {
  final MemberModel member;
  GetMemberDataSuccess(this.member);
}
class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}