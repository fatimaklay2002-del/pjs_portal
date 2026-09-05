import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../../core/models/address_edu_info.dart';
import '../../../core/models/documents_urls.dart';
import '../../../core/models/personal_info.dart';
import '../../../core/models/professional_info.dart';
import '../../../core/service/file_upload_service.dart';
import '../data/repositores/member_repository.dart';
import 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  final MemberRepository _repository;
  final FileUploadService _uploadService;

  MemberCubit(this._repository, this._uploadService) : super(MemberInitial());

  Future<void> loadCurrentMember() async {
    emit(MemberLoading());
    try {
      emit(MemberLoaded(await _repository.fetchCurrentMember()));
    } catch (e) {
      emit(MemberError(ErrorHandler.getReadableMessage(e)));
    }
  }

  /// Uploads whatever attachments were picked and returns the merged
  /// [DocumentsUrls] (existing urls kept for anything not re-uploaded).
  Future<DocumentsUrls> uploadDocuments(
      Map<String, PlatformFile?> files,
      DocumentsUrls existing,
      ) async {
    final uploaded = await _uploadService.uploadAll(files);
    return existing.mergeUploads(uploaded);
  }

  Future<void> updateProfile({
    required String memberId,
    required String fullNameAr,
    required String fullNameEn,
    String? idPassportNumber,
    String? phoneNumber,
    required PersonalInfo personalInfo,
    required AddressEduInfo addressInfo,
    required ProfessionalInfo professionalInfo,
    required DocumentsUrls documentsUrls,
  }) async {
    emit(MemberLoading());
    try {
      await _repository.updateMemberCore(
        memberId: memberId,
        fullNameAr: fullNameAr,
        fullNameEn: fullNameEn,
        idPassportNumber: idPassportNumber,
        phoneNumber: phoneNumber,
      );
      await _repository.upsertMemberDetails(
        memberId: memberId,
        personalInfo: personalInfo,
        addressInfo: addressInfo,
        professionalInfo: professionalInfo,
        documentsUrls: documentsUrls,
      );
      emit(MemberActionSuccess('تم حفظ التعديلات بنجاح'));
    } catch (e) {
      emit(MemberError(ErrorHandler.getReadableMessage(e)));
    }
  }
}
