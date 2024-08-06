part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetLastNewsEvent extends HomeEvent {}

class GetNewsByKeyWordEvent extends HomeEvent {
  final String keyWord;

  GetNewsByKeyWordEvent({required this.keyWord});
}

class GetNewsByCategoryEvent extends HomeEvent {
  final String categoryStr;

  GetNewsByCategoryEvent({required this.categoryStr});
}

class UpdateNewsListEvent extends HomeEvent {}
