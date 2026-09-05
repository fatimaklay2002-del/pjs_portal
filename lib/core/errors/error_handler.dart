class ErrorHandler {
  static String getReadableMessage(Object error) {
    final raw = error.toString()
        .replaceAll('Exception: ', '')
        .replaceAll('ClientException: ', '');

    // Supabase / Postgres errors
    if (raw.contains('relation') && raw.contains('does not exist')) {
      return 'تعذّر الاتصال بقاعدة البيانات';
    }
    if (raw.contains('JWT expired') || raw.contains('invalid claim')) {
      return 'انتهت جلستك، يرجى تسجيل الدخول مجدداً';
    }
    if (raw.contains('duplicate key') || raw.contains('unique constraint')) {
      return 'هذه البيانات موجودة مسبقاً';
    }
    if (raw.contains('network') ||
        raw.contains('SocketException') ||
        raw.contains('Connection refused')) {
      return 'تحقق من اتصالك بالإنترنت';
    }
    if (raw.contains('timeout')) {
      return 'انتهت مهلة الاتصال، حاول مجدداً';
    }
    if (raw.contains('permission denied') || raw.contains('row-level security')) {
      return 'ليس لديك صلاحية للوصول';
    }
    if (raw.contains('storage') || raw.contains('bucket')) {
      return 'فشل في رفع الملف، حاول مجدداً';
    }

    // إذا كانت الرسالة عربية (من عندنا)، أظهرها مباشرة
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(raw);
    if (hasArabic) return raw;

    // fallback
    return 'حدث خطأ غير متوقع، حاول مجدداً';
  }
}