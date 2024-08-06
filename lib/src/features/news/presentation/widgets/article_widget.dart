import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/features/news/presentation/bloc/favorite_bloc/favorite_bloc.dart';

import '../../domain/entities/news_entity.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.themeData,
    required this.news, required this.isInHomeScreen,
  });

  final ThemeData themeData;
  final NewsEntity news;
  final bool isInHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 260.w,
                  child: Text(
                    news.title,
                    style: TextStyle(
                        height: 1.2,
                        color: themeData.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (int result) {
                    if (result == 0) {
                      context.read<FavoriteBloc>().add(AddToFavoriteArticlesEvent(news: news));
                    } else if (result == 1) {
                      context.read<FavoriteBloc>().add(DeleteFromFavoriteArticlesEvent(news: news));
                    }
                  },
                  iconSize: 35.sp,
                  popUpAnimationStyle: AnimationStyle(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 300)),
                  color: themeData.scaffoldBackgroundColor,
                  itemBuilder: (BuildContext context) {
                    return [
                      isInHomeScreen
                          ? const PopupMenuItem(
                              value: 0, child: Text('Add To Favorite'))
                          : const PopupMenuItem(
                              value: 1, child: Text('Delete From Favorite'))
                    ];
                  },
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              news.body,
              style: TextStyle(
                  color: themeData.cardColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Published at: ${DateFormat('HH:mm, d MMMM yyyy').format(news.pubDate)}",
              style: TextStyle(
                  color: themeData.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            ),
            Text(
              "Category: ${news.sectionName}",
              style: TextStyle(
                  color: themeData.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp),
            )
          ],
        ));
  }
}
