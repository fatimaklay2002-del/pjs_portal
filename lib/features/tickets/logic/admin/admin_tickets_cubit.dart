import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_handler.dart';

import '../../data/repositores/admin_inquiry_repository.dart';
import 'admin_tickets_state.dart';

class AdminTicketsCubit extends Cubit<AdminInquiryState> {
  final AdminTicketsRepository _repository;
  AdminTicketsCubit(this._repository) : super(AdminInquiryInitial());

  Future<void> loadAll() async {
    emit(AdminInquiryLoading());
    try {
      final results = await Future.wait([
        _repository.fetchAllInquiries(),
        _repository.fetchAllComplaints(),
      ]);
      emit(AdminInquiryLoaded(inquiries: results[0], complaints: results[1]));
    } catch (e) {
      emit(AdminInquiryError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> replyToInquiry({required String inquiryId, required String response}) async {
    try {
      await _repository.replyToInquiry(inquiryId: inquiryId, response: response);
      emit(AdminInquiryActionSuccess('تم إرسال الرد بنجاح'));
      await loadAll();
    } catch (e) {
      emit(AdminInquiryError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> updateComplaintStatus({required String complaintId, required String status}) async {
    try {
      await _repository.updateComplaintStatus(complaintId: complaintId, status: status);
      await loadAll();
    } catch (e) {
      emit(AdminInquiryError(ErrorHandler.getReadableMessage(e)));
    }
  }
}
