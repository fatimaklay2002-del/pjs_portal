import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/error_handler.dart';
import '../../data/repositores/inquiry_repository.dart';
import 'member_tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final InquiryRepository _repository;
  TicketsCubit(this._repository) : super(TicketsInitial());

  Future<void> loadMyInquiries() async {
    emit(InquiryLoading());
    try {
      final list = await _repository.fetchMyInquiries();
      emit(InquiriesLoaded(list));
    } catch (e) {
      emit(TicketsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> sendInquiry({
    required String subject,
    required String message,
  }) async {
    emit(InquiryLoading());
    try {
      await _repository.sendInquiry( subject: subject, message:message);
      emit(TicketsActionSuccess('تم إرسال الاستفسار بنجاح', TicketType.inquiry));

      loadMyInquiries();
    } catch (e) {
      emit(TicketsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> sendComplaint({required String description,}) async {
    emit(InquiryLoading());
    try {
      await _repository.sendComplaint(description: description);
      emit(TicketsActionSuccess('تم إرسال الشكوى بنجاح', TicketType.complaint));

    } catch (e) {
      emit(TicketsError(ErrorHandler.getReadableMessage(e)));
    }
  }
}
