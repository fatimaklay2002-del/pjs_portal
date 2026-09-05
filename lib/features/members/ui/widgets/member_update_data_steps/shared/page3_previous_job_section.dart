import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/Constants/app_strings.dart';
import '../../../../../admin/ui/widgets/request_review_widgets/request_review_widgets.dart';
import 'edit_row.dart';

class Page3PreviousJobSection extends StatelessWidget {
  final TextEditingController titleCtrl;
  final TextEditingController orgCtrl;
  final TextEditingController startCtrl;
  final TextEditingController endCtrl;

  const Page3PreviousJobSection({
    super.key,
    required this.titleCtrl,
    required this.orgCtrl,
    required this.startCtrl,
    required this.endCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      icon: const Icon(Icons.history),
      title: 'الوظائف السابقة',
      child: Column(
        children: [
          EditRow(label: AppStrings.jobTitle, controller: titleCtrl),
          EditRow(label: AppStrings.organization, controller: orgCtrl),
          Row(
            children: [
              Expanded(child: EditRow(label: AppStrings.endDate, controller: endCtrl)),
              SizedBox(width: 8.w),
              Expanded(child: EditRow(label: AppStrings.startDate, controller: startCtrl)),
            ],
          ),
        ],
      ),
    );
  }
}
