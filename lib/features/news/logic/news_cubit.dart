import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/error_handler.dart';
import '../../news/data/repositories/news_repository.dart';
import '../data/model/news_model.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;
  String _selectedCategory = 'الكل';

  NewsCubit(this._repository) : super(NewsInitial());

  Future<void> loadNews({String? category}) async {
    _selectedCategory = category ?? _selectedCategory;
    emit(NewsLoading(selectedCategory: _selectedCategory));
    try {
      final news = await _repository.fetchNews(category: _selectedCategory);
      emit(NewsLoaded(news, selectedCategory: _selectedCategory));
    } catch (e) {
      emit(NewsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> filterByCategory(String category) => loadNews(category: category);

  Future<void> addNews(NewsModel news, {File? imageFile}) async {
    emit(NewsLoading());
    try {
      await _repository.addNews(news, imageFile: imageFile);
      emit(NewsActionSuccess('تم نشر الخبر بنجاح'));
      await loadNews();
    } catch (e) {
      emit(NewsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> updateNews(NewsModel news, {File? newImageFile}) async {
    emit(NewsLoading());
    try {
      await _repository.updateNews(news, newImageFile: newImageFile);
      emit(NewsActionSuccess('تم تعديل الخبر بنجاح'));
      await loadNews();
    } catch (e) {
      emit(NewsError(ErrorHandler.getReadableMessage(e)));
    }
  }

  Future<void> deleteNews(String id) async {
    emit(NewsLoading());
    try {
      await _repository.deleteNews(id);
      emit(NewsActionSuccess('تم حذف الخبر بنجاح'));
      await loadNews();
    } catch (e) {
      emit(NewsError(ErrorHandler.getReadableMessage(e)));
    }
  }
}