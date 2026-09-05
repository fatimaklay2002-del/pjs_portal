
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pjs_portal/core/Constants/app_strings.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/bottom_nav_section.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_page1.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_page2.dart';
import 'package:pjs_portal/features/admin/ui/widgets/request_review_widgets/request_review_page3.dart';

import '../../../core/dialogs/request_success_dialog.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_color.dart';
import '../logic/admin_membership_cubit.dart';
import '../logic/admin_membership_state.dart';
import '../../membership/data/model/membership_request_model.dart';

class MembershipRequestReviewScreen extends StatefulWidget {
  final String requestId;
  const MembershipRequestReviewScreen({super.key, required this.requestId});

  @override
  State<MembershipRequestReviewScreen> createState() =>
      _MembershipRequestReviewScreenState();
}

class _MembershipRequestReviewScreenState
    extends State<MembershipRequestReviewScreen> {
  String _selectedMembershipType = 'temporary'; // 'permanent', 'temporary'

  MembershipRequestModel? _request;
  bool _isInitialLoading = false; // التسمية واضحة للتحميل الأول فقط

  // Pagination
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadRequest();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadRequest() async {
    setState(() => _isInitialLoading = true);
    try {
      final request = await context.read<AdminMembershipCubit>().getRequestById(
        widget.requestId,
      );
      setState(() {
        _request = request;
        _isInitialLoading = false;
      });
    } catch (e) {
      setState(() => _isInitialLoading = false);
      if (mounted) {
        context.showErrorSnackBar(AppStrings.loadRequestFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.reviewOrder),
        centerTitle: false,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryNavy),
          onPressed: () => context.pop(),
        ),
      ),
      // إغلاق الواجهة بمؤشر تحميل كلي إذا كان الحساب يُجلب لأول مرة
      body: _isInitialLoading || _request == null
          ? const Center(child: CircularProgressIndicator())
          : BlocConsumer<AdminMembershipCubit, AdminMembershipState>(
        listener: (context, state) {
          if (state is AdminMembershipApproved) {
            showRequestSuccessDialog(
              context,
              onConfirm: () {
                Navigator.pop(context); // إغلاق الدايلوج
                context.pop(); // العودة للشاشة السابقة (القايمة ستحدث تلقائياً)
              },
            );
          } else if (state is AdminMembershipRejected) {
            context.showSuccessSnackBar(AppStrings.requestRejectedSuccessfully);
            context.pop(); // العودة بعد الرفض
          } else if (state is AdminMembershipError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        ReviewPage1(request: _request!),
                        ReviewPage2(request: _request!),
                        ReviewPage3(
                          request: _request!,
                          onRoleChanged: (String role, String type) {
                            setState(() {
                              _selectedMembershipType = type;
                            });
                          },
                          selectedMembershipType: _selectedMembershipType,
                        ),
                      ],
                    ),
                  ),
                  BottomNavSection(
                    currentPage: _currentPage,
                    pageController: _pageController,
                    onApprove: _approveRequest,
                    onReject: _rejectRequest,
                    isLoading: state is AdminMembershipLoading,
                  ),
                ],
              ),

              // شاشة تحميل شفافة تظهر فقط عندما يكون الـ Cubit في حالة Loading
              if (state is AdminMembershipLoading)
                Container(
                  color: AppColors.black.withValues(alpha: .3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _approveRequest() async {
    await context.read<AdminMembershipCubit>().approveRequest(
      requestId: widget.requestId,
      request: _request!,
      membershipType: _selectedMembershipType,
    );
  }

  Future<void> _rejectRequest() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.confirmReject,
            textAlign: TextAlign.right),
        content: Text(
          AppStrings.confirmRejectMessage,
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppStrings.reject, style: TextStyle(color: AppColors.accentRed)),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (confirmed == true) {
      final cubit = context.read<AdminMembershipCubit>();
      await cubit.rejectRequest(widget.requestId);
    }
  }
}
