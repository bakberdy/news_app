part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {
}

final class LoadFavoriteArticlesEvent extends FavoriteEvent{}
final class ClearFavoriteArticlesEvent extends FavoriteEvent{}

final class AddToFavoriteArticlesEvent extends FavoriteEvent{
  final NewsEntity news;

  AddToFavoriteArticlesEvent({required this.news});
}

final class DeleteFromFavoriteArticlesEvent extends FavoriteEvent{
  final NewsEntity news;

  DeleteFromFavoriteArticlesEvent({required this.news});
}


final class ShowSnackBarEvent extends FavoriteEvent{
  final String message;

  ShowSnackBarEvent({required this.message});

}

