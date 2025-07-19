import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:news_app/src/core/error/exceptions.dart';
import 'package:news_app/src/features/news/data/models/news_model.dart';

abstract class RemoteDataSource {
  Future<List<NewsModel>> getLastNews();
  Future<List<NewsModel>> getNewsBySectionName(String sectionName);
  Future<List<NewsModel>> getNewsByKeywords(String keyword);
}

const String _baseUrl =
    'https://api.nytimes.com/svc/search/v2/articlesearch.json';
const String _apiKey = 'eTMdVG3pV3A3hOOONUvqar6SUEItkHcr';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  Uri _buildUri({String? query, String? section}) {
    final params = {
      'api-key': _apiKey,
      if (query != null) 'q': query,
      if (section != null) 'fq': 'section_name:("$section")',
    };

    return Uri.parse(_baseUrl).replace(queryParameters: params);
  }

  @override
  Future<List<NewsModel>> getLastNews() async {
    final uri = _buildUri();
    return _getNewsFromUri(uri);
  }

  @override
  Future<List<NewsModel>> getNewsByKeywords(String keyword) async {
    final uri = _buildUri(query: keyword);
    return _getNewsFromUri(uri);
  }

  @override
  Future<List<NewsModel>> getNewsBySectionName(String sectionName) async {
    final uri = _buildUri(section: sectionName);
    return _getNewsFromUri(uri);
  }

  Future<List<NewsModel>> _getNewsFromUri(Uri uri) async {
    print('[HTTP] GET $uri');

    try {
      final response = await client.get(uri);
      print('[HTTP] Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final List<dynamic> docs = body['response']['docs'];
        final newsList = docs.map((e) => NewsModel.fromJson(e)).toList();

        print('[HTTP] Fetched ${newsList.length} news items');
        return newsList;
      } else {
        print('[HTTP] Error: ${response.statusCode} ${response.reasonPhrase}');
        throw ServerException();
      }
    } catch (e) {
      print('[HTTP] Exception: $e');
      throw ServerException();
    }
  }
}
