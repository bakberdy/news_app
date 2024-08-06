import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/usecase/usecase.dart';
import 'package:news_app/src/features/news/domain/entities/news_entity.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

import '../../../../core/error/failure.dart';

class GetLastNews implements UseCase<Either<Failure, List<NewsEntity>>, NoParams>{

  final NewsRepository repository;

  GetLastNews(this.repository);

  @override
  Future<Either<Failure, List<NewsEntity>>> call({required NoParams params}) {
    return repository.getLastNews();
  }

}
