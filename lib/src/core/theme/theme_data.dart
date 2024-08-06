import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black.withOpacity(0.9),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white),
    scaffoldBackgroundColor: const Color(0xffD3D3D3),
    cardColor: const Color(0xff696969),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20.sp),
    ),
    primaryColor: Colors.black,
    useMaterial3: true,
  );
}
