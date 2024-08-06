import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/features/news/domain/entities/news_entity.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_by_keywords.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_by_section.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../domain/usecase/get_last_news.dart';

part 'home_event.dart';

part 'home_state.dart';
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetLastNews getLastNews;
  final GetNewsBySection getNewsBySection;


  HomeBloc({
    required this.getLastNews,
    required this.getNewsBySection,
  }) : super(HomeLoadingState()) {
    on<GetLastNewsEvent>((event, emit) async {
      emit(HomeLoadingState());
      final failureOrNews = await getLastNews(params: NoParams());
      failureOrNews.fold(
          (failure) => emit(HomeErrorState(failure: failure)),
          (List<NewsEntity> news) => emit(HomeLoadedState(lastNews: news)));
    });



    on<GetNewsByCategoryEvent>((event, emit) async {
      emit(HomeLoadingState());
      final failureOrNews = await getNewsBySection(params: event.categoryStr);
      failureOrNews.fold(
          (failure) => emit(HomeErrorState(failure: failure)),
          (List<NewsEntity> news) => emit(HomeCategoryLoadedState(
              categoryFilterResultNews: news, categoryQuery: event.categoryStr)));
    });
  }
}
