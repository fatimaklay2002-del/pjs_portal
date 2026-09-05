import 'dart:typed_data';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static const _imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];

  static bool isImageUrl(String url) {
    final cleanUrl = url
        .split('?')
        .first
        .toLowerCase();
    return _imageExtensions.any((ext) => cleanUrl.endsWith('.$ext'));
  }

  static Future<Uint8List?> downloadImageBytes(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 15));
      if (response.statusCode != 200) return null;
      final contentType = response.headers['content-type'] ?? '';
      if (!contentType.startsWith('image/')) return null;
      return response.bodyBytes;
    } catch (_) {
      return null;
    }
  }
}