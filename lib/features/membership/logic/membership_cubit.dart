import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/models/documents_urls.dart';
import '../../../core/service/file_upload_service.dart';
import '../data/repositories/membership_repository.dart';
import 'membership_form_data.dart';
import 'membership_form_mapper.dart';
import 'membership_state.dart';

class MembershipCubit extends Cubit<MembershipState> {
  final MembershipRepository _repository;
  final FileUploadService _uploadService;

  MembershipCubit(this._repository, this._uploadService)
      : super(MembershipInitial());

  Future<void> submitMembershipRequest({
    required MembershipFormData formData,
    required Map<String, PlatformFile?> files,
  }) async {
    emit(MembershipLoading());
    try {
      final exists =
      await _repository.checkIfExists(formData.email!, formData.fullNameAr!);
      if (exists) {
        emit(MembershipError('عذراً، هذا البريد الإلكتروني أو الاسم مسجل مسبقاً'));
        return;
      }
      final urls = await _uploadService.uploadAll(files);
      final request = formData.toRequestModel(DocumentsUrls.fromUploadMap(urls));
      await _repository.submitRequest(request);
      emit(MembershipSuccess());
    } catch (e) {
      emit(MembershipError(_clean(e)));
    }
  }

  Future<void> loadRequests() async {
    emit(MembershipLoading());
    try {
      emit(RequestsLoaded(await _repository.getAllRequests()));
    } catch (e) {
      emit(MembershipError(_clean(e)));
    }
  }

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    emit(MembershipLoading());
    try {
      await _repository.updateRequestStatus(requestId: requestId, status: status);
      emit(StatusUpdatedSuccess());
    } catch (e) {
      emit(MembershipError(_clean(e)));
    }
  }

  String _clean(Object e) => ErrorHandler.getReadableMessage(e);
}

