import 'package:news_app/src/features/news/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel(
      {required super.title,
      required super.body,
      required super.pubDate,
      required super.sectionName,
      super.id});

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
        title: map['abstract'].toString().replaceAll('\'\'', 'â'),
        body: map['headline']['main'] as String,
        pubDate: DateTime.parse(map['pub_date']),
        sectionName: map['section_name'] as String,
        id: map['id']);
  }
  factory NewsModel.fromLocalJson(Map<String, dynamic> map) {
    return NewsModel(
        title: map['abstract'].toString().replaceAll('\'\'', 'â'),
        body: map['lead_paragraph'] as String,
        pubDate: DateTime.parse(map['pub_date']),
        sectionName: map['section_name'] as String,
        id: map['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'abstract': title,
      'lead_paragraph': body,
      'pub_date': pubDate.toIso8601String(),
      'section_name': sectionName,
    };
  }

  factory NewsModel.fromParent(NewsEntity news) {
    return NewsModel(
        title: news.title,
        body: news.body,
        pubDate: news.pubDate,
        sectionName: news.sectionName,
        id: news.id);
  }
}
