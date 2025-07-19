import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/src/features/news/presentation/bloc/home_bloc/home_bloc.dart';
import '../../../../core/error/failure.dart';
import '../bloc/favorite_bloc/favorite_bloc.dart';
import '../widgets/article_list_bar_widget.dart';
import '../widgets/category_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (BuildContext context, FavoriteState state) {
          if (state is FavoriteSnackBarState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                "Categories",
                style: TextStyle(
                    color: themeData.primaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              _categoryFilterBar(themeData, context),
              Divider(
                height: 30.h,
                thickness: 2,
                color: Colors.black,
              ),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                return _widgetDependOnState(state: state, context: context);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetDependOnState({required state, required context}) {
    if (state is HomeLoadingState) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: const CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    } else if (state is HomeErrorState) {
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
    } else if (state is HomeLoadedState) {
      return ArticleListBar(
        titleOfList: 'Daily News',
        news: state.lastNews,
        isInHomeScreen: true,
        barHeight: MediaQuery.of(context).size.height * 0.58,
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context).add(GetLastNewsEvent());
        },
      );
    } else if (state is HomeCategoryLoadedState) {
      return ArticleListBar(
        onRefresh: () async {
          BlocProvider.of<HomeBloc>(context)
              .add(GetNewsByCategoryEvent(categoryStr: state.categoryQuery));
        },
        barHeight: MediaQuery.of(context).size.height * 0.64,
        titleOfList: state.categoryQuery,
        news: state.categoryFilterResultNews,
        isInHomeScreen: true,
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

  Widget _categoryFilterBar(themeData, context) {
    final categories =
        ['Sports', 'Business Day', 'Books', 'Food', 'Health', 'U.S.', 'World']
            .map((el) => CategoryButton(
                themeData: themeData,
                title: el,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetNewsByCategoryEvent(categoryStr: el));
                }))
            .toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryButton(
              themeData: themeData,
              title: "Daily News",
              onTap: () {
                BlocProvider.of<HomeBloc>(context).add(GetLastNewsEvent());
              }),
          ...categories
        ],
      ),
    );
  }
}
