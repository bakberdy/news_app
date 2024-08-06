import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/navigation/bloc/bottom_nav_bar_cubit.dart';
import 'package:news_app/src/features/navigation/widgets/bottom_navigation_bar.dart';
import 'package:news_app/src/features/news/presentation/screens/home_screen.dart';

import '../../news/presentation/screens/favorite_screen.dart';
import '../../news/presentation/screens/search_screen.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final pages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        builder: (context, state) {
      int currentIndex = 0;
      if (state is BottomNavBarUpdated) {
        currentIndex = state.currentIndex;
      }
      return Scaffold(
          body: pages[currentIndex],
          bottomNavigationBar: MyBottomNavigationBar(
            index: currentIndex,
            onTap: (int index) {
              context.read<BottomNavBarCubit>().updateIndex(index);
            },
          ));
    });
  }
}
