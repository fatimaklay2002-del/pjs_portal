import '../../news/data/model/news_model.dart';

sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  final String selectedCategory;
  NewsLoading({this.selectedCategory = 'الكل'});
}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  final String selectedCategory;
  NewsLoaded(this.news, {required this.selectedCategory});
}

class NewsActionSuccess extends NewsState {
  final String message;
  NewsActionSuccess(this.message);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}