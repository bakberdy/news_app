part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchGetArticles extends  SearchEvent{
  final String query;

  SearchGetArticles({required this.query});
}

