import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../membership/data/model/membership_request_model.dart';
import '../data/repositories/admin_membership_repository.dart';
import 'admin_membership_state.dart';

class AdminMembershipCubit extends Cubit<AdminMembershipState> {
  final AdminMembershipRepository _repository;

  AdminMembershipCubit(this._repository)
      : super(const AdminMembershipInitial());

  Future<void> loadPendingRequests() async {
    try {
      emit(const AdminMembershipLoading());
      final requests = await _repository.getPendingRequests();
      emit(AdminMembershipRequestsLoaded(requests));
    } catch (e) {
      emit(AdminMembershipError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<MembershipRequestModel> getRequestById(String requestId) =>
      _repository.getRequestById(requestId);

  Future<void> approveRequest({
    required String requestId,
    required MembershipRequestModel request,
    required String membershipType,
  }) async {
    try {
      emit(const AdminMembershipLoading());
      final password = await _repository.approveRequestAndCreateAccount(
        requestId: requestId,
        request: request,
        membershipType: membershipType,
      );
      emit(AdminMembershipApproved(password));
      // Reload only after emitting success — no race condition
      loadPendingRequests();
    } catch (e) {
      emit(AdminMembershipError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> rejectRequest(String requestId) async {
    try {
      emit(const AdminMembershipLoading());
      await _repository.rejectRequest(requestId);
      emit(const AdminMembershipRejected());
      loadPendingRequests();
    } catch (e) {
      emit(AdminMembershipError(ErrorHandler.getReadableMessage(e)));
    }
  }
}