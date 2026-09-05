import 'package:flutter/cupertino.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/widgets/custom_text_field.dart';

class NewsActionLinkFields extends StatelessWidget {
  final TextEditingController linkController;
  final TextEditingController labelController;

  const NewsActionLinkFields({
    super.key,
    required this.linkController,
    required this.labelController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.actionLink, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        CustomTextField(
          controller: linkController,
          hint: 'https://example.com/form',
          keyboardType: TextInputType.url,
          validator: (v) {
            if (v == null || v.trim().isEmpty) return null; // اختياري
            final uri = Uri.tryParse(v.trim());
            if (uri == null || !uri.isAbsolute) return AppStrings.invalidLink;
            return null;
          },
        ),
        const SizedBox(height: 12),
        Text(AppStrings.actionLinkLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        CustomTextField(
          controller: labelController,
          hint: 'مثال: سجل الآن',
        ),
      ],
    );
  }
}