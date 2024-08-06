import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/src/features/news/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:news_app/src/features/news/presentation/widgets/article_list_bar_widget.dart';

import '../../../../core/error/failure.dart';
import '../bloc/favorite_bloc/favorite_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (BuildContext context, FavoriteState state) {
        if (state is FavoriteSnackBarState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _searchBar(themeData, context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (BuildContext context, state) {
                    return _widgetDependOnState(state: state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(themeData, context) {
    return Container(
      padding: EdgeInsets.only(right: 15.w, bottom: 10.h, left: 15.w),
      height: 60.h,
      color: themeData.primaryColor,
      child: TextField(
        onSubmitted: (val) {
          BlocProvider.of<SearchBloc>(context)
              .add(SearchGetArticles(query: val));
        },
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18.sp),
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            filled: true,
            fillColor: themeData.scaffoldBackgroundColor,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.r))),
      ),
    );
  }

  Widget _widgetDependOnState({required state}) {
    if (state is SearchLoadingState) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: const CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    } else if (state is SearchErrorState) {
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
    } else if (state is SearchLoadedState) {
      return ArticleListBar(
        titleOfList: 'Results Of Search',
        news: state.searchResults,
        isInHomeScreen: true,
        barHeight: 480.h, onRefresh: () async{  },
      );
    } else {
      return  ArticleListBar(
        titleOfList: 'Results Of Search',
        news: [],
        isInHomeScreen: true,
        barHeight: 480.h, onRefresh: () async {  },
      );
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
}
