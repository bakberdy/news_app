import 'dart:convert';

import 'package:news_app/src/core/error/exceptions.dart';
import 'package:news_app/src/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<NewsModel>> getLastNews();

  Future<List<NewsModel>> getNewsBySectionName(String sectionName);

  Future<List<NewsModel>> getNewsByKeywords(String keyword);
}

const URL = 'https://api.nytimes.com/svc/search/v2/articlesearch.json';
const API_KEY = 'you can get api key in New York Times';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getLastNews() {
    return _getNewsFromUrl('$URL?api-key=$API_KEY');
  }

  @override
  Future<List<NewsModel>> getNewsByKeywords(String keyword) {
    return _getNewsFromUrl('$URL?q=$keyword&api-key=$API_KEY');
  }

  @override
  Future<List<NewsModel>> getNewsBySectionName(String sectionName) {
    return _getNewsFromUrl(
        '$URL?fq=section_name:(%22$sectionName%22)&api-key=$API_KEY');
  }

  Future<List<NewsModel>> _getNewsFromUrl(String url) async {
    final uri = Uri.parse(url);
    final response = await client.get(uri);
    print('ddd');
    if (response.statusCode == 200) {
      final Map body = jsonDecode(response.body);
      final List dynamicList =  body['response']['docs'];
       List<NewsModel> news =
         dynamicList.map((e) => NewsModel.fromJson(e)).toList();
       print(news);
      return news;
    } else {
      throw ServerException();
    }}
}
