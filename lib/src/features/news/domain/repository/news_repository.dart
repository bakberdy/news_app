import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/features/news/domain/entities/news_entity.dart';

abstract class NewsRepository{
  Future<Either<Failure, List<NewsEntity>>> getLastNews();
  Future<Either<Failure, List<NewsEntity>>> getNewsBySection(String sectionName);
  Future<Either<Failure, List<NewsEntity>>> getNewsByKeywords(String keyword);
  Future<Either<Failure, List<NewsEntity>>> addNewsToFavorite(NewsEntity news);
  Future<Either<Failure, List<NewsEntity>>> deleteNewsFromFavorite(NewsEntity news);
  Future<Either<Failure, bool>> clearFavoriteNews();
  Future<Either<Failure, List<NewsEntity>>> getNewsFromFavorite();
}