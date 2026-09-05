import 'package:file_picker/file_picker.dart';
import 'storage_service.dart';

class FileUploadService {
  final StorageService _storage;
  FileUploadService(this._storage);

  Future<Map<String, String?>> uploadAll(
    Map<String, PlatformFile?> files, {
    String bucket = 'documents',
  }) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final entries = files.entries.toList();
    final results = await Future.wait(
      entries.map((e) => _uploadOne(e.value, e.key, ts, bucket)),
    );
    return {
      for (var i = 0; i < entries.length; i++) entries[i].key: results[i],
    };
  }

  Future<String?> _uploadOne(
      PlatformFile? file, String folder, int ts, String bucket) async {
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      throw Exception('ملف $folder فارغ أو تعذّر قراءته، يرجى إعادة اختياره');
    }
    final ext =
        file.name.contains('.') ? file.name.split('.').last.toLowerCase() : 'bin';
    final path = '$folder/${ts}_$folder.$ext';
    return _storage.uploadFile(bucket: bucket, path: path, fileBytes: bytes);
  }
}
