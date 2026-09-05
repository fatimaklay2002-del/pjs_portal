import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pjs_portal/core/extensions/navigation_extensions.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/model/news_model.dart';
import '../../logic/news_cubit.dart';
import '../screens/news_detail_screen.dart';

class FeaturedBanner extends StatefulWidget {
  final List<NewsModel> featured;
  const FeaturedBanner({super.key, required this.featured});

  @override
  State<FeaturedBanner> createState() => FeaturedBannerState();
}

class FeaturedBannerState extends State<FeaturedBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250.h,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.featured.length,
            itemBuilder: (context, i) {
              final news = widget.featured[i];
              return GestureDetector(
                onTap: () =>context.pushWithCubit(context.read<NewsCubit>(),NewsDetailScreen(news: news)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        news.imageUrl != null
                            ? Image.network(
                          news.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => _gradientBg(),
                        )
                            : _gradientBg(),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.65),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: .2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'في الصدارة',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Text(
                            news.title,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.featured.length > 1)
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.featured.length,
                    (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: _currentPage == i ? 16.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.primaryNavy
                        : AppColors.inputBorder,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _gradientBg() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.primaryNavy,
          AppColors.primaryNavy.withValues(alpha: 0.6),
        ],
      ),
    ),
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
