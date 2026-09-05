
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/model/member_model.dart';
import '../../data/model/member_update_form_data.dart';
import '../../data/model/member_update_form_mapper.dart';
import '../../logic/member_cubit.dart';
import '../../logic/member_state.dart';
import '../controllers/update_step1_controllers.dart';
import '../controllers/update_step2_controllers.dart';
import '../controllers/update_step3_controllers.dart';
import '../widgets/member_update_data_steps/pages/page1_personal_info.dart';
import '../widgets/member_update_data_steps/pages/page2_address_edu_work.dart';
import '../widgets/member_update_data_steps/pages/page3_jobs_attachments.dart';
class MemberUpdateScreen extends StatefulWidget {
  final MemberModel member;
  const MemberUpdateScreen({super.key, required this.member});

  @override
  State<MemberUpdateScreen> createState() => _MemberUpdateScreenState();
}

class _MemberUpdateScreenState extends State<MemberUpdateScreen> {
  late final _formData = MemberUpdateFormData.fromMember(widget.member);
  late final _step1 = UpdateStep1Controllers(_formData);
  late final _step2 = UpdateStep2Controllers(_formData);
  late final _step3 = UpdateStep3Controllers(_formData);
  final _pageController = PageController();

  PlatformFile? _personalPhoto, _idPassportPhoto, _bankStatement,
      _universityDegree, _syndicateCard, _employmentContract, _mediaLicense;

  @override
  void dispose() {
    _pageController.dispose();
    _step1.dispose();
    _step2.dispose();
    _step3.dispose();
    super.dispose();
  }

  void _next() => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  void _prev() => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

  Future<void> _submit() async {
    _step1.saveInto(_formData);
    _step2.saveInto(_formData);
    _step3.saveInto(_formData);

    final cubit = context.read<MemberCubit>();
    final documentsUrls = await cubit.uploadDocuments({
      'personal_photos': _personalPhoto,
      'id_photos': _idPassportPhoto,
      'bank_statements': _bankStatement,
      'degrees': _universityDegree,
      'syndicate_cards': _syndicateCard,
      'contracts': _employmentContract,
      'licenses': _mediaLicense,
    }, widget.member.documentsUrls);

    await cubit.updateProfile(
      memberId: widget.member.id,
      fullNameAr: _formData.fullNameAr!,
      fullNameEn: _formData.fullNameEn!,
      idPassportNumber: _formData.idPassportNumber,
      phoneNumber: _formData.phoneNumber,
      personalInfo: _formData.toPersonalInfo(),
      addressInfo: _formData.toAddressInfo(),
      professionalInfo: _formData.toProfessionalInfo(),
      documentsUrls: documentsUrls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.of(context).pop()),
        title: Text('تحديث البيانات', style: AppTextStyles.headlineMedium),
      ),
      body: BlocConsumer<MemberCubit, MemberState>(
        listener: (context, state) {
          if (state is MemberActionSuccess) {
            context.showSuccessSnackBar(state.message);
            Navigator.of(context).pop();
          } else if (state is MemberError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) => PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UpdateStep1PersonalInfo(
              member: widget.member,
              controllers: _step1,
              gender: _formData.gender!,
              maritalStatus: _formData.maritalStatus!,
              onGenderChanged: (v) => setState(() => _formData.gender = v),
              onMaritalChanged: (v) => setState(() => _formData.maritalStatus = v),
              onNext: _next,
            ),
            UpdateStep2AddressEduWork(
              controllers: _step2,
              qualification: _formData.qualification!,
              workSystem: _formData.workSystem!,
              onQualificationChanged: (v) => setState(() => _formData.qualification = v),
              onWorkSystemChanged: (v) => setState(() => _formData.workSystem = v),
              onPrev: _prev,
              onNext: _next,
            ),
            UpdateStep3JobsAttachments(
              member: widget.member,
              controllers: _step3,
              isLoading: state is MemberLoading,
              onPrev: _prev,
              onSubmit: _submit,
              personalPhoto: _personalPhoto,
              idPassportPhoto: _idPassportPhoto,
              bankStatement: _bankStatement,
              universityDegree: _universityDegree,
              syndicateCard: _syndicateCard,
              employmentContract: _employmentContract,
              mediaLicense: _mediaLicense,
              onPersonalPhoto: (f) => setState(() => _personalPhoto = f),
              onIdPassportPhoto: (f) => setState(() => _idPassportPhoto = f),
              onBankStatement: (f) => setState(() => _bankStatement = f),
              onUniversityDegree: (f) => setState(() => _universityDegree = f),
              onSyndicateCard: (f) => setState(() => _syndicateCard = f),
              onEmploymentContract: (f) => setState(() => _employmentContract = f),
              onMediaLicense: (f) => setState(() => _mediaLicense = f),
            ),
          ],
        ),
      ),
    );
  }
}
