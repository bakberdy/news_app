part of 'bottom_nav_bar_cubit.dart';

@immutable
abstract class BottomNavBarState {}

class BottomNavBarInitial extends BottomNavBarState {}

class BottomNavBarUpdated extends BottomNavBarState {
  final int currentIndex;

  BottomNavBarUpdated(this.currentIndex);
}
