// core/utils/date_formatter.dart
import 'package:intl/intl.dart';

class DateFormatter {
  // 12 مارس 2026
  static String toArabic(dynamic raw) {
    if (raw == null) return '';
    final date = raw is DateTime ? raw : DateTime.tryParse(raw.toString());
    if (date == null) return '';
    return DateFormat('d MMMM yyyy', 'ar_AE').format(date.toLocal());
  }

  // 12/03/2026
  static String toNumeric(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // منذ 3 أيام / اليوم
  static String toRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'اليوم';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} أيام';
    return toArabic(date);
  }
}