import 'package:file_picker/file_picker.dart';

class Step4FilePicker {
  Future<PlatformFile?> pick() async {
    return FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
  }
}