part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<NewsEntity> lastNews;

  HomeLoadedState({required this.lastNews});
}

final class HomeErrorState extends HomeState {
  final Failure failure;

  HomeErrorState({required this.failure});
}

final class HomeSearchLoadedState extends HomeState {
  final List<NewsEntity> searchResultNews;
  final String searchQuery;

  bool get isSearchMode => searchQuery.isNotEmpty;

  HomeSearchLoadedState(
      {required this.searchResultNews, required this.searchQuery});
}

final class HomeCategoryLoadedState extends HomeState {
  final List<NewsEntity> categoryFilterResultNews;

  final String categoryQuery;

  HomeCategoryLoadedState(
      {required this.categoryFilterResultNews, required this.categoryQuery});
}
