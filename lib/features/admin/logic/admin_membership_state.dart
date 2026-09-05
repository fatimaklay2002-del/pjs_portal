import '../../membership/data/model/membership_request_model.dart';

sealed class AdminMembershipState {
  const AdminMembershipState();
}

class AdminMembershipInitial extends AdminMembershipState {
  const AdminMembershipInitial();
}

class AdminMembershipLoading extends AdminMembershipState {
  const AdminMembershipLoading();
}

class AdminMembershipRequestsLoaded extends AdminMembershipState {
  final List<MembershipRequestModel> requests;
  const AdminMembershipRequestsLoaded(this.requests);
}

class AdminMembershipApproved extends AdminMembershipState {
  final String password;
  const AdminMembershipApproved(this.password);
}

class AdminMembershipRejected extends AdminMembershipState {
  const AdminMembershipRejected();
}

class AdminMembershipError extends AdminMembershipState {
  final String message;
  const AdminMembershipError(this.message);
}