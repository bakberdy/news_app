import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/news_entity.dart';
import 'article_widget.dart';

class ArticleListBar extends StatelessWidget {
  const ArticleListBar(
      {super.key,
      required this.titleOfList,
      required this.news,
      required this.isInHomeScreen,
      required this.onRefresh,
      required this.barHeight});

  final String titleOfList;
  final List<NewsEntity> news;
  final bool isInHomeScreen;
  final double barHeight;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          titleOfList,
          style: TextStyle(
              color: themeData.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          height: barHeight,
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ArticleWidget(
                      themeData: themeData,
                      news: news[index],
                      isInHomeScreen: isInHomeScreen,
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
