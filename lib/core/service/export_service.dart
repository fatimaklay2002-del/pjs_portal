import 'dart:io';
import 'package:excel_plus/excel_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/members/data/model/member_model.dart';
import '../Constants/app_strings.dart';

import '../utils/excel_style_helper.dart';
import '../utils/network_helper.dart';
class MemberExportService {
  static Future<File> exportMembersToExcel(List<MemberModel> members) async {
    final excel = Excel.createExcel();
    final sheet = excel['الأعضاء'];
    final headers = ExcelStyleHelper.getHeaders();

    ExcelStyleHelper.setupHeaders(sheet, headers);

    for (var rowIdx = 0; rowIdx < members.length; rowIdx++) {
      final member = members[rowIdx];
      final targetRow = rowIdx + 1;

      _writeMemberTextData(sheet, member, targetRow, headers.length);
      final hasImage = await _processMemberDocuments(sheet, member, targetRow);

      if (hasImage) {
        sheet.setRowHeight(targetRow, 55);
      }
    }

    sheet.isRTL = true;
    excel.setDefaultSheet('الأعضاء');
    excel.delete('Sheet1');

    return await _saveExcelFile(excel);
  }

  static void _writeMemberTextData(Sheet sheet, MemberModel m, int row, int totalHeaders) {
    final textData = [
      m.fullNameAr, m.fullNameEn, m.idPassportNumber, m.email,
      m.personalInfo.gender, m.personalInfo.maritalStatus, m.phoneNumber,
      m.personalInfo.alternativePhoneNumber, m.addressInfo.originalCity,
      m.addressInfo.originalGovernorate, m.addressInfo.fullAddress,
      m.addressInfo.spouseCity, m.addressInfo.spouseGovernorate,
      m.addressInfo.spouseAddress, m.addressInfo.universityName,
      m.addressInfo.major, m.addressInfo.qualification,
      m.addressInfo.graduationYear, m.professionalInfo.mediaOrganization,
      m.professionalInfo.workStartYear, m.professionalInfo.jobType,
      m.professionalInfo.workSystem, m.professionalInfo.organizationAddress,
      m.professionalInfo.organizationPhone, _translateMembershipType(m.membershipType),
    ];

    for (var col = 0; col < textData.length; col++) {
      ExcelStyleHelper.writeTextCell(sheet, col, row, textData[col]);
    }

    // كتابة تاريخ الإنشاء في العمود الأخير
    ExcelStyleHelper.writeTextCell(
      sheet,
      totalHeaders - 1,
      row,
      m.createdAt.toIso8601String().split('T')[0],
    );
  }

  static Future<bool> _processMemberDocuments(Sheet sheet, MemberModel m, int row) async {
    final docs = [ /* نفس القائمة */ ];
    final results = await Future.wait(docs.map((url) async {
      if (url == null || url.trim().isEmpty) return null;
      return NetworkHelper.downloadImageBytes(url);
    }));

    var containsImage = false;
    for (var i = 0; i < docs.length; i++) {
      final url = docs[i];
      if (url == null || url.trim().isEmpty) continue;
      final bytes = results[i];
      final col = ExcelStyleHelper.docsStartCol + i;
      if (bytes != null) {
        sheet.insertImage(bytes, anchor: CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row),
            width: ExcelStyleHelper.imageWidth, height: ExcelStyleHelper.imageHeight);
        containsImage = true;
      } else {
        ExcelStyleHelper.writeLinkCell(sheet, col, row, url);
      }
    }
    return containsImage;
  }

  static Future<File> _saveExcelFile(Excel excel) async {
    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/members_$timestamp.xlsx');
    await file.writeAsBytes(excel.encode()!);
    return file;
  }

  static String _translateMembershipType(String? type) {
    switch (type) {
      case 'permanent':
        return AppStrings.memberTypePermanent;
      case 'temporary':
        return AppStrings.memberTypeTemporary;
      default:
        return type ?? '';
    }
  }

  static Future<void> shareExportedFile(File file) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'شارك الملف',
      ),
    );
  }
}

