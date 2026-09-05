import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dialogs/delete_news_dialog.dart';
import '../../../../core/extensions/navigation_extensions.dart';
import '../../data/model/news_model.dart';
import '../../logic/news_cubit.dart';
import '../screens/add_update_news.dart';
import 'news_card.dart';

class NewsListView extends StatelessWidget {
  final List<NewsModel> news;
  final bool isAdmin;
  const NewsListView({super.key, required this.news, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewsCubit>();
    return RefreshIndicator(
      onRefresh: () => cubit.loadNews(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: news.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) => NewsCard(
          isAdmin: isAdmin,
          news: news[i],
          onEdit: isAdmin
              ? () => context.pushWithCubit(cubit, NewsAddEditScreen(news: news[i]))
              : null,
          onDelete: isAdmin
              ? () async {
            final confirmed = await showDeleteNewsDialog(context);
            if (confirmed == true) cubit.deleteNews(news[i].id);
          }
              : null,
        ),
      ),
    );
  }
}