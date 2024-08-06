import 'package:dartz/dartz.dart';

import 'package:news_app/src/core/error/failure.dart';
import 'package:news_app/src/core/network/network_info.dart';
import 'package:news_app/src/features/news/data/data_sources/local_data_source.dart';
import 'package:news_app/src/features/news/data/data_sources/remote_data_source.dart';
import 'package:news_app/src/features/news/data/models/news_model.dart';

import 'package:news_app/src/features/news/domain/entities/news_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  NewsRepositoryImpl(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewsEntity>>> addNewsToFavorite(NewsEntity news) async {

    try{
     final bool isSuccess = (await localDataSource.addArticleToFavorite(NewsModel.fromParent(news)));
      final List<NewsEntity> articles =await localDataSource.getFavoriteArticles();
      return Right(articles);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> clearFavoriteNews() {
    try {
      localDataSource.clearNews();
      return Future.value(const Right(true));
    } catch (e) {
      return Future.value(Left(CacheFailure()));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> deleteNewsFromFavorite(NewsEntity news) async {
    try {
      localDataSource.deleteArticleFromFavorite(news.id??0);
      final List<NewsEntity> articles =await localDataSource.getFavoriteArticles();
      return Right(articles);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getLastNews() async {
    try {
      if (await networkInfo.isConnected) {
        List<NewsEntity> news = await remoteDataSource.getLastNews();
        return Right(news);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsByKeywords(
      String keyword) async {
    try {
      if (await networkInfo.isConnected) {
        List<NewsEntity> news =
            await remoteDataSource.getNewsByKeywords(keyword);
        return Right(news);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsBySection(
      String sectionName) async {
    try {
      if (await networkInfo.isConnected) {
        List<NewsEntity> news =
            await remoteDataSource.getNewsBySectionName(sectionName);
        return Right(news);
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsFromFavorite() async {
    try {
     final List<NewsEntity> articles =await localDataSource.getFavoriteArticles();
      return Future.value(Right(articles));
    } catch (e) {
      return Future.value(Left(CacheFailure()));
    }
  }
}
