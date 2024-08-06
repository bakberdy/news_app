import 'package:dartz/dartz.dart';
import 'package:news_app/src/core/usecase/usecase.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/news_entity.dart';

class GetNewsFromFavorite implements UseCase<Either<Failure, List<NewsEntity>>, NoParams>{

  final NewsRepository repository;

  GetNewsFromFavorite(this.repository);
  @override
  Future<Either<Failure, List<NewsEntity>>> call({required NoParams params}) {
    return repository.getNewsFromFavorite();
  }

}