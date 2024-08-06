import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final int? id;
  final String title;
  final String body;
  final DateTime pubDate;
  final String sectionName;

  const NewsEntity(
      {this.id,
      required this.title,
      required this.body,
      required this.pubDate,
      required this.sectionName});

  @override
  // TODO: implement props
  List<Object?> get props => [title, body, pubDate, sectionName];

  NewsEntity copyWith(
      {String? title,
      String? body,
      DateTime? pubDate,
      String? sectionName,
      int? id}) {
    return NewsEntity(
      title: title ?? this.title,
      body: body ?? this.body,
      pubDate: pubDate ?? this.pubDate,
      sectionName: sectionName ?? this.sectionName,
      id: id,
    );
  }
}
