part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteLoadedState extends FavoriteState {
  final List<NewsEntity> favoriteArticles;

  FavoriteLoadedState({required this.favoriteArticles});
}

final class FavoriteLoadingState extends FavoriteState {}

final class FavoriteEmptyState extends FavoriteState {}

final class FavoriteErrorState extends FavoriteState {
  final Failure failure;

  FavoriteErrorState({required this.failure});
}
final class FavoriteSnackBarState extends FavoriteState{
  final String message;

  FavoriteSnackBarState({required this.message});
}
