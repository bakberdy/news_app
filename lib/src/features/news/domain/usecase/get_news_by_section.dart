import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/usecase/usecase.dart';
import 'package:news_app/src/features/news/domain/entities/news_entity.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

import '../../../../core/error/failure.dart';

class GetNewsBySection implements UseCase<Either<Failure, List<NewsEntity>>, String>{

  final NewsRepository repository;

  GetNewsBySection(this.repository);

  @override
  Future<Either<Failure, List<NewsEntity>>> call({required String params}) {
    return repository.getNewsBySection(params);
  }

}
