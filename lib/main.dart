import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/src/core/theme/theme_data.dart';
import 'package:news_app/src/features/navigation/bloc/bottom_nav_bar_cubit.dart';
import 'package:news_app/src/features/navigation/screens/wrapper.dart';
import 'package:news_app/src/features/news/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:news_app/src/features/news/presentation/bloc/search_bloc/search_bloc.dart';
import 'injection_container.dart' as di;
import 'package:news_app/src/features/news/presentation/bloc/home_bloc/home_bloc.dart';

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690), // Set the design size of your app
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: AppTheme.themeData,
            home: MultiBlocProvider(providers: [
              BlocProvider(
                  create: (_) => di.sl<HomeBloc>()..add(GetLastNewsEvent())),
              BlocProvider(create: (_) => di.sl<FavoriteBloc>()),
              BlocProvider(create: (_) => BottomNavBarCubit()),
              BlocProvider(create:(_)=> di.sl<SearchBloc>())
            ], child: MainWrapper()),
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}
