import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/news_entity.dart';
import '../../../domain/usecase/get_news_by_keywords.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetNewsByKeywords getNewsByKeywords;

  SearchBloc({required this.getNewsByKeywords}) : super(SearchInitial()) {
    on<SearchGetArticles>((event, emit) async {
      emit(SearchLoadingState());
      final failureOrNews = await getNewsByKeywords(params: event.query);
      failureOrNews.fold(
          (failure) => emit(SearchErrorState(failure: failure)),
          (List<NewsEntity> news) => emit(SearchLoadedState(
              searchResults: news, query: event.query)));
    });
  }
}
