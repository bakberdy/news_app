part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {
  final String query;
  final List<NewsEntity> searchResults;

  SearchLoadedState( {required this.query,required this.searchResults});}

final class SearchErrorState extends SearchState {
  final Failure failure;

  SearchErrorState({required this.failure});
}


