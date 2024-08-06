import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/usecase/usecase.dart';
import 'package:news_app/src/features/news/domain/entities/news_entity.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

import '../../../../core/error/failure.dart';

class DeleteNewsFromFavorite implements UseCase<Either<Failure, List<NewsEntity>>, NewsEntity>{

  final NewsRepository repository;

  DeleteNewsFromFavorite(this.repository);

  @override
  Future<Either<Failure, List<NewsEntity>>> call({required NewsEntity params}) {
    return repository.deleteNewsFromFavorite(params);
  }

}
