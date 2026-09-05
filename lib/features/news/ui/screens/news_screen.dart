import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_color.dart';
import '../../logic/news_cubit.dart';
import '../../logic/news_state.dart';
import '../widgets/news_empty_state.dart';
import '../widgets/news_filter_tabs.dart';
import '../widgets/news_list_view.dart';
class NewsScreen extends StatefulWidget {
  final bool isAdmin;
  const NewsScreen({super.key, required this.isAdmin});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> _categories = ['الكل', 'عام', 'تدريبي', 'خدمات', 'اجتماعي'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = context.read<NewsCubit>().state;
      if (state is! NewsLoaded) {
        context.read<NewsCubit>().loadNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryNavy),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.news),
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsActionSuccess) {
            context.showSuccessSnackBar(state.message);
          }
          if (state is NewsError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          final selected = switch (state) {
                      NewsLoaded(:final selectedCategory) => selectedCategory,
                      NewsLoading(:final selectedCategory) => selectedCategory,
                      _ => 'الكل',
                    };
          return Column(
            children: [
              NewsFilterTabs(
                categories: _categories,
                selected: selected,
                onSelect: (cat) => context.read<NewsCubit>().filterByCategory(cat),
              ),
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(NewsState state) {
    if (state is NewsLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is NewsError) {
      return NewsErrorState(
        message: state.message,
        onRetry: () => context.read<NewsCubit>().loadNews(),
      );
    }
    if (state is NewsLoaded) {
      return state.news.isEmpty
          ? const NewsEmptyState()
          : NewsListView(news: state.news, isAdmin: widget.isAdmin);
    }
    return const SizedBox();
  }
}