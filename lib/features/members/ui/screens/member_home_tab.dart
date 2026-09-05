import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/extensions/navigation_extensions.dart';
import 'package:pjs_portal/core/widgets/custom_app_bar.dart';

import '../../../../core/Constants/app_strings.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../news/logic/news_cubit.dart';
import '../../../news/logic/news_state.dart';
import '../../../news/ui/screens/news_screen.dart';
import '../../../news/ui/widgets/featured_banner.dart';
import '../../../news/ui/widgets/news_card.dart';

class MemberHomeTab extends StatefulWidget {
  const MemberHomeTab({super.key});

  @override
  State<MemberHomeTab> createState() => _MemberHomeTabState();
}

class _MemberHomeTabState extends State<MemberHomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NewsCubit>().loadNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(isAdmin: false),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NewsError) {
            return Center(child: Text(state.message));
          }
          if (state is NewsLoaded) {
            final featured = state.news.where((n) => n.isFeatured).toList();
            final latest = state.news.take(10).toList();

            return RefreshIndicator(
              onRefresh: () => context.read<NewsCubit>().loadNews(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  // ── Featured Banner ──
                  if (featured.isNotEmpty)
                    SliverToBoxAdapter(
                      child: FeaturedBanner(featured: featured),
                    ),

                  // ── Header ──
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.latestNews,
                            style: AppTextStyles.headlineSmall,
                          ),
                          GestureDetector(
                            onTap: () => context.pushWithCubit(
                              context.read<NewsCubit>(),
                              NewsScreen(isAdmin: false),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  AppStrings.viewAll,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.primaryNavy,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: AppColors.primaryNavy,
                                  size: 18.w,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── News List ──
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      if (latest.isEmpty) return const SizedBox();
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        child: NewsCard(news: latest[i], isAdmin: false),
                      );
                    }, childCount: latest.length),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 80.h)),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
