import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/core/network/network_info.dart';
import 'package:news_app/src/core/services/local_database_service/local_database_service.dart';
import 'package:news_app/src/features/news/data/data_sources/local_data_source.dart';
import 'package:news_app/src/features/news/data/data_sources/remote_data_source.dart';
import 'package:news_app/src/features/news/data/repository/news_repository_impl.dart';
import 'package:news_app/src/features/news/domain/repository/news_repository.dart';
import 'package:news_app/src/features/news/domain/usecase/add_news_to_favorite.dart';
import 'package:news_app/src/features/news/domain/usecase/clear_favorite_news.dart';
import 'package:news_app/src/features/news/domain/usecase/delete_news_from_favorite.dart';
import 'package:news_app/src/features/news/domain/usecase/get_last_news.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_by_keywords.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_by_section.dart';
import 'package:news_app/src/features/news/domain/usecase/get_news_from_favorite.dart';
import 'package:news_app/src/features/news/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:news_app/src/features/news/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:news_app/src/features/news/presentation/bloc/search_bloc/search_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() =>
      HomeBloc(
        getLastNews: sl(),
        getNewsBySection: sl(),
      ));
  sl.registerFactory(() =>
      FavoriteBloc(getNewsFromFavorite: sl(),
          deleteNewsFromFavorite: sl(),
          addNewsToFavorite: sl(), clearFavoriteNews: sl()));

  sl.registerFactory(() =>
      SearchBloc(getNewsByKeywords: sl(),));

  // Use cases
  sl.registerLazySingleton(() => GetLastNews(sl()));
  sl.registerLazySingleton(() => GetNewsBySection(sl()));
  sl.registerLazySingleton(() => GetNewsByKeywords(sl()));
  sl.registerLazySingleton(() => GetNewsFromFavorite(sl()));
   sl.registerLazySingleton(() => DeleteNewsFromFavorite(sl()));
    sl.registerLazySingleton(() => AddNewsToFavorite(sl()));
     sl.registerLazySingleton(() => ClearFavoriteNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
        () =>
        NewsRepositoryImpl(
            remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(localDatabaseService: sl()),
  );
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => LocalDatabaseService.instance);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
