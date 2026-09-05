import '../../data/model/ticket_model.dart';
enum TicketType { inquiry, complaint }
abstract class TicketsState {}
class TicketsInitial extends TicketsState {}
class InquiryLoading extends TicketsState {}
class InquiriesLoaded extends TicketsState {
  final List<TicketModel> inquiries;
  InquiriesLoaded(this.inquiries);
}
class TicketsActionSuccess extends TicketsState {
  final String message;
  final TicketType type;
  TicketsActionSuccess(this.message, this.type);
}
class TicketsError extends TicketsState {
  final String message;
  TicketsError(this.message);
}