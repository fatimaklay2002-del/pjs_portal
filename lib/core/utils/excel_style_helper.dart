import 'package:excel_plus/excel_plus.dart';

import '../Constants/app_strings.dart';

class ExcelStyleHelper {
  static const int imageWidth = 70;
  static const int imageHeight = 70;
  static const int docsStartCol = 25;

  static List<String> getHeaders() => [
    AppStrings.fullNameArabic, AppStrings.fullNameEnglish, AppStrings.idPassportNumber,
    AppStrings.email, AppStrings.gender, AppStrings.maritalStatus, AppStrings.phoneNumber,
    AppStrings.alternativePhoneNumber, AppStrings.originalCity, AppStrings.originalGovernorate,
    AppStrings.fullAddress, AppStrings.spouseCity, AppStrings.spouseGovernorate,
    AppStrings.spouseAddress, AppStrings.universityName, AppStrings.major,
    AppStrings.qualification, AppStrings.graduationYear, AppStrings.mediaOrganization,
    AppStrings.workStartYear, AppStrings.jobType, AppStrings.workSystem,
    AppStrings.organizationAddress, AppStrings.organizationPhone, AppStrings.membershipType,
    AppStrings.personalPhoto, AppStrings.idPassportPhoto, AppStrings.bankAccountStatement,
    AppStrings.universityDegree, AppStrings.syndicateCard, AppStrings.employmentContract,
    AppStrings.mediaLicense, AppStrings.createdAt,
  ];

  static void setupHeaders(Sheet sheet, List<String> headers) {
    for (var i = docsStartCol; i < docsStartCol + 7; i++) {
      sheet.setColumnWidth(i, 14);
    }

    for (var i = 0; i < headers.length; i++) {
      final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(headers[i]);
      cell.cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.blueGrey,
        fontColorHex: ExcelColor.white,
      );
    }
  }

  static void writeTextCell(Sheet sheet, int col, int row, dynamic value) {
    if (value == null || value.toString().trim().isEmpty || value.toString().trim() == 'null') {
      return;
    }
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row)).value =
        TextCellValue(value.toString());
  }

  static void writeLinkCell(Sheet sheet, int col, int row, String url) {
    final cell = sheet.cell(CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row));
    cell.value = TextCellValue(url);
    cell.cellStyle = CellStyle(
      fontColorHex: ExcelColor.blue,
      underline: Underline.Single,
    );
  }
}