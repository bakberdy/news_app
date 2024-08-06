import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_from_favorite.dart';
import 'package:news_app/src/features/news/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:news_app/src/features/news/presentation/widgets/article_list_bar_widget.dart';

import '../../../../core/error/failure.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context.read<FavoriteBloc>().add(LoadFavoriteArticlesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: appBar(context, themeData),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.w),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
            return _widgetDependOnState(state: state);
          }),
        ),
      ),
    );
  }

  Widget _widgetDependOnState({required state}) {
    if (state is FavoriteLoadingState) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: const CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    } else if (state is FavoriteErrorState) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0.h),
          child: Text(
            textAlign: TextAlign.center,
            '${_checkError(state.failure)} occurred.\nTry it again!',
            style: TextStyle(
                color: Colors.red,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      );
    } else if (state is FavoriteLoadedState) {
      return ArticleListBar(
        onRefresh: () async {},
        titleOfList: 'Favorite Articles',
        news: state.favoriteArticles,
        isInHomeScreen: false,
        barHeight: 540.h,
      );
    } else {
      return const SizedBox();
    }
  }

  String _checkError(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Error';
    } else if (failure is NetworkFailure) {
      return 'Lost Connection';
    } else if (failure is CacheFailure) {
      return 'Cache Error';
    } else {
      return 'Unknown Error';
    }
  }

  PreferredSizeWidget appBar(context, themeData) {
    return AppBar(actions: [
      PopupMenuButton(
        iconColor: Colors.white,
        color: themeData.scaffoldBackgroundColor,
        onSelected: (int val) {
          if (val == 0) {
            BlocProvider.of<FavoriteBloc>(context)
                .add(ClearFavoriteArticlesEvent());
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(value: 0, child: Text('Clear Favorite List'))
          ];
        },
      )
    ], title: const Text("Favorite"));
  }
}
