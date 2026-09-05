import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/common_viewers/image_viewer_screen.dart';
import '../widgets/common_viewers/pdf_viewer_screen.dart';

class FileHelper {
  static String getFileName(String url) => url.split('/').last.split('?').first;

  static Future<void> previewFile(BuildContext context, String url) async {
    // 1. تحديد نوع الملف بناءً على الامتداد
    final lowerUrl = url.toLowerCase();

    if (lowerUrl.endsWith('.pdf')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PdfViewerScreen(url: url)),
      );
    } else if (lowerUrl.endsWith('.jpg') ||
        lowerUrl.endsWith('.jpeg') ||
        lowerUrl.endsWith('.png')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageViewerScreen(url: url)),
      );
    } else {
      // 2. إذا كان نوعاً غير معروف (مثل ملفات Doc أو غيرها)، نفتحها خارجياً كخطة بديلة
      _openExternally(context, url);
    }
  }

  static Future<void> _openExternally(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('لا يمكن فتح هذا الملف')));
    }
  }


}
