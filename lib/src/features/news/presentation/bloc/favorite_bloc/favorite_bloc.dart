import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/core/usecase/usecase.dart';
import 'package:news_app/src/features/news/domain/usecase/delete_news_from_favorite.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_from_favorite.dart';

import '../../../domain/entities/news_entity.dart';
import '../../../domain/usecase/add_news_to_favorite.dart';
import '../../../domain/usecase/clear_favorite_news.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetNewsFromFavorite getNewsFromFavorite;
  final DeleteNewsFromFavorite deleteNewsFromFavorite;
  final AddNewsToFavorite addNewsToFavorite;
  final ClearFavoriteNews clearFavoriteNews;

  FavoriteBloc(
      {required this.getNewsFromFavorite,
      required this.clearFavoriteNews,
      required this.deleteNewsFromFavorite,
      required this.addNewsToFavorite})
      : super(FavoriteLoadingState()) {
    on<LoadFavoriteArticlesEvent>((event, emit) async {
      emit(FavoriteLoadingState());
      final newsOrFailure = await getNewsFromFavorite(params: NoParams());
      newsOrFailure
          .fold((failure) => emit(FavoriteErrorState(failure: failure)),
              (List<NewsEntity> articles) {
        emit(FavoriteLoadedState(favoriteArticles: articles));
      });
    });
    on<AddToFavoriteArticlesEvent>((event, emit) async {
      emit(FavoriteLoadingState());
      final newsOrFailure = await addNewsToFavorite(params: event.news);
      newsOrFailure.fold((failure) {
        emit(FavoriteErrorState(failure: failure));
        emit(FavoriteSnackBarState(message: 'Failed to add from favorite'));
      }, (List<NewsEntity> articles) {
        emit(FavoriteLoadedState(favoriteArticles: articles));
      });
    });
    on<DeleteFromFavoriteArticlesEvent>((event, emit) async {
      emit(FavoriteLoadingState());
      final newsOrFailure = await deleteNewsFromFavorite(params: event.news);
      newsOrFailure.fold((failure) {
        emit(FavoriteErrorState(failure: failure));
        emit(FavoriteSnackBarState(message: 'Failed to delete from favorite'));
      },
          (List<NewsEntity> articles) =>
              emit(FavoriteLoadedState(favoriteArticles: articles)));
    });
    on<ClearFavoriteArticlesEvent>((event, emit) async {
      final newsOrFailure = await clearFavoriteNews(params: NoParams());
      newsOrFailure
          .fold((failure) => emit(FavoriteErrorState(failure: failure)),
              (bool success) {
        emit(FavoriteLoadedState(favoriteArticles: const []));
      });
    });
    on<ShowSnackBarEvent>((event, emit) async {
      emit(FavoriteSnackBarState(message: event.message));
    });
  }
}
