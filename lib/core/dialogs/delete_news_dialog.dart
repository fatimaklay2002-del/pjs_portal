import 'package:flutter/material.dart';

import '../Constants/app_strings.dart';
import '../theme/app_color.dart';

Future<bool?> showDeleteNewsDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(AppStrings.delete, textAlign: TextAlign.right, textDirection: TextDirection.rtl),
      content: const Text(AppStrings.deleteNewsMessage, textAlign: TextAlign.right, textDirection: TextDirection.rtl),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(AppStrings.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentRed,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
           // context.read<NewsCubit>().deleteNews(id);
            Navigator.of(context).pop(true);},

          child: const Text(AppStrings.delete, style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}