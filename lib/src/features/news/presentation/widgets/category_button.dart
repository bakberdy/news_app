
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.themeData,
    required this.title,
    required this.onTap,
  });

  final ThemeData themeData;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                  color: themeData.primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}
