import 'package:flutter/material.dart';
import 'package:weather/core/themes/colors.dart';
import 'package:weather/core/themes/constants.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),

    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.onDrag,
      thumbColor: Colors.white,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.all(AppDefaults.kDimension15),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDefaults.kborderRadius10,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(AppDefaults.kDimension15),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDefaults.kborderRadius10,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    primaryColor: AppColors.primaryColor,
    buttonTheme: ButtonThemeData(buttonColor: AppColors.primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.secondaryColor,
    ),
    useMaterial3: true,
  );
}
