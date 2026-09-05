import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/session/user_session.dart';
import '../model/news_model.dart';

class NewsRepository {
  final SupabaseClient _supabase;
  NewsRepository(this._supabase);

  Future<List<NewsModel>> fetchNews({String? category}) async {
    try {
      final response = await _supabase
          .from('news')
          .select()
          .order('created_at', ascending: false);

      final all = (response as List).map((e) => NewsModel.fromJson(e)).toList();
      if (category == null || category == 'الكل') return all;
      return all.where((n) => n.category == category).toList();
    } catch (_) {
      throw Exception('فشل في جلب الأخبار');
    }
  }

  Future<void> addNews(NewsModel news, {File? imageFile}) async {
    try {
      final imageUrl = imageFile != null ? await _uploadImage(imageFile) : null;
      await _supabase.from('news').insert({
        ...news.toJson()..removeWhere((k, _) => ['id', 'image_url'].contains(k)),
        'image_url': imageUrl,
        'created_by': UserSession.instance.authId,
      });
    } catch (_) {
      throw Exception('فشل في إضافة الخبر');
    }
  }

  Future<void> updateNews(NewsModel news, {File? newImageFile}) async {
    try {
      final imageUrl =
      newImageFile != null ? await _uploadImage(newImageFile) : news.imageUrl;
      await _supabase
          .from('news')
          .update({...news.toJson(), 'image_url': imageUrl})
          .eq('id', news.id);
    } catch (_) {
      throw Exception('فشل في تعديل الخبر');
    }
  }

  Future<void> deleteNews(String id) async {
    try {
      await _supabase.from('news').delete().eq('id', id);
    } catch (_) {
      throw Exception('فشل في حذف الخبر');
    }
  }

  Future<String> _uploadImage(File file) async {
    final fileName =
        'news/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    await _supabase.storage.from('news-images').upload(fileName, file);
    return _supabase.storage.from('news-images').getPublicUrl(fileName);
  }
}