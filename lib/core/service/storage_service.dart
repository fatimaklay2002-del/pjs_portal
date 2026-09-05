import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class StorageService {
  final SupabaseClient _supabase;
  StorageService(this._supabase);

  Future<String> uploadFile({
    required String bucket,
    required String path,
    required List<int> fileBytes,
  }) async {
    try {
      final data = Uint8List.fromList(fileBytes);
      await _supabase.storage.from(bucket).uploadBinary(
            path,
            data,
            fileOptions: const FileOptions(upsert: true),
          );
      return _supabase.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      debugPrint('❌ Storage Error Detail: $e');
      throw Exception('فشل في رفع الملف');
    }
  }
}
