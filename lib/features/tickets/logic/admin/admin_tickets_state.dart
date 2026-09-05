import '../../data/model/ticket_model.dart';

abstract class AdminInquiryState {}

class AdminInquiryInitial extends AdminInquiryState {}

class AdminInquiryLoading extends AdminInquiryState {}

class AdminInquiryLoaded extends AdminInquiryState {
  final List<TicketModel> inquiries;
  final List<TicketModel> complaints;
  AdminInquiryLoaded({required this.inquiries, required this.complaints});
}

class AdminInquiryActionSuccess extends AdminInquiryState {
  final String message;
  AdminInquiryActionSuccess(this.message);
}

class AdminInquiryError extends AdminInquiryState {
  final String message;
  AdminInquiryError(this.message);
}