import 'package:flutter/material.dart';
import 'package:np_career/core/app_color.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightAppTheme = ThemeData(
    fontFamily: "Tinos",
    scaffoldBackgroundColor: AppColor.lightBackgroundColor,
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 25,
          color: AppColor.greenPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          color: AppColor.textLightBackgroundColor,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
            fontSize: 10,
            color: AppColor.lightTextColor,
            fontWeight: FontWeight.w600)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shadowColor: AppColor.greenPrimaryColor,
            minimumSize: const Size.fromHeight(45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
              side: BorderSide(color: AppColor.greenPrimaryColor, width: 2),
            ),
            backgroundColor: AppColor.orangePrimaryColor)),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColor.greenPrimaryColor, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColor.greenPrimaryColor, width: 2)),
        errorBorder: OutlineInputBorder(
          // Thêm errorBorder
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColor.orangeRedColor,
              width: 2), // Màu đỏ cho border khi có lỗi
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: AppColor.orangeRedColor, width: 2)),
        hintStyle: const TextStyle(
            fontSize: 16,
            color: AppColor.greenPrimaryColor,
            fontWeight: FontWeight.w600),
        labelStyle: TextStyle(
          fontSize: 16,
          color: AppColor.greenPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
        errorStyle: TextStyle(
          fontSize: 16,
          color: AppColor.orangeRedColor, // Màu chữ khi có lỗi
        )),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.greenPrimaryColor, // Màu con trỏ nhập liệu
      selectionColor: AppColor.greenPrimaryColor
          .withOpacity(0.3), // Màu khi bôi đen văn bản
      selectionHandleColor:
          AppColor.greenPrimaryColor, // Màu tay cầm chọn văn bản
    ),
  );
}
