import 'package:news_app/src/core/error/exceptions.dart';
import 'package:news_app/src/core/services/local_database_service/local_database_service.dart';

import '../models/news_model.dart';

abstract class LocalDataSource {
  Future<List<NewsModel>> getFavoriteArticles();

  Future<bool> addArticleToFavorite(NewsModel news);

  void deleteArticleFromFavorite(int id);

  void clearNews();
}

class LocalDataSourceImpl implements LocalDataSource {
  final LocalDatabaseService localDatabaseService;

  LocalDataSourceImpl({required this.localDatabaseService});

  @override
  Future<bool> addArticleToFavorite(NewsModel news) async {
    try {
      await localDatabaseService.addNews(news);
      return Future.value(true);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  void deleteArticleFromFavorite(int id) {
    try {
      localDatabaseService.deleteNews(id);
    } catch (e) {
      throw CacheException;
    }
  }

  @override
  Future<List<NewsModel>> getFavoriteArticles() async {
    try {
      return await localDatabaseService.getNews();
    } catch (e) {
      throw CacheException;
    }
  }

  @override
  void clearNews() {
    try {
      localDatabaseService.clearNews();
    } catch (e) {
      throw CacheException;
    }
  }
}
