import 'dart:math';

import 'package:news_app/src/core/error/exceptions.dart';
import 'package:news_app/src/features/news/data/models/news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  LocalDatabaseService._constructor();

  static final LocalDatabaseService instance =
      LocalDatabaseService._constructor();
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await _getDatabase();
      return _db!;
    }
  }

  final String FAVORITE_NEWS_TABLE_NAME = 'favorite_news';
  final String FAVORITE_NEWS_ID_COLUMN_NAME = 'id';
  final String FAVORITE_NEWS_TITLE_COLUMN_NAME = 'abstract';
  final String FAVORITE_NEWS_BODY_COLUMN_NAME = 'lead_paragraph';
  final String FAVORITE_NEWS_PUB_DATE_COLUMN_NAME = 'pub_date';
  final String FAVORITE_NEWS_SECTION_NAME_COLUMN_NAME = 'section_name';

  Future<Database> _getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    String path = join(databaseDirPath, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE 
    $FAVORITE_NEWS_TABLE_NAME(
        $FAVORITE_NEWS_ID_COLUMN_NAME INTEGER PRIMARY KEY, 
        $FAVORITE_NEWS_TITLE_COLUMN_NAME TEXT NOT NULL, 
        $FAVORITE_NEWS_BODY_COLUMN_NAME TEXT NOT NULL, 
        $FAVORITE_NEWS_PUB_DATE_COLUMN_NAME TEXT NOT NULL, 
        $FAVORITE_NEWS_SECTION_NAME_COLUMN_NAME TEXT NOT NULL)''');
  }

  Future<bool> addNews(NewsModel news) async {
    if (!(await getNews()).contains(news)) {
      final db = await database;
      final newNews =
          NewsModel.fromParent(news.copyWith(id: Random().nextInt(1000)));
      db.insert(FAVORITE_NEWS_TABLE_NAME, newNews.toJson());
      return true;
    } else {
      throw CacheException();
    }
  }

  Future<void> deleteNews(int id) async {
    final db = await database;
    db.delete(
      FAVORITE_NEWS_TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<NewsModel>> getNews() async {
    final db = await database;
    final List<dynamic> data = await db.query(FAVORITE_NEWS_TABLE_NAME);
    final List<NewsModel> news =
        data.map((e) => NewsModel.fromLocalJson(e)).toList();
    return news;
  }

  Future<void> clearNews() async {
    final db = await database;
    db.delete(
      FAVORITE_NEWS_TABLE_NAME,
    );
  }
}
