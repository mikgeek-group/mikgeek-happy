import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happyapp/const/constant.dart';
import 'package:sp_util/sp_util.dart';
import 'package:get/get.dart';

import 'colors.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class MkTheme {
  // 系统级padding
  static const double iDefaultPadding = 12.0;

  // 圆角
  static const iDefaultRadius = 10.0;

  static const BorderRadiusGeometry iBorderRadius =
      BorderRadius.all(Radius.circular(10));

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    Get.changeTheme(
        getTheme(isDarkMode: themeMode.value == ThemeMode.dark.value));
  }

  static ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static ThemeData getCurrentTheme() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    switch (theme) {
      case 'Dark':
        return getTheme(isDarkMode: true);
      case 'Light':
        return getTheme(isDarkMode: false);
      default:
        return getTheme(isDarkMode: false);
    }
  }

  static ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      // 风格主题
      brightness: Brightness.light,

      /// iOS 17 解决TextField 输入框输入文本后，光标选择最后一个字符的问题
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.transparent,
      ),

      /// 页面背景图
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,

      primaryColor: Colours.app_main,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // secondary: const Color(0xFF5C78FF),
      ),
      appBarTheme: const AppBarTheme(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 18.0),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 18,
        ),
        toolbarTextStyle: TextStyle(
          color: Color(0xFF333333),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),

      iconTheme: IconThemeData(
          color: Colours.app_main
      ),


      dividerTheme: DividerThemeData(
          color: isDarkMode ? Colours.dark_line : Colours.line,
          space: 0.6,
          thickness: 0.6),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colours.app_main),
        unselectedItemColor: Color(0xffA2A5B9),
        selectedItemColor: Colours.app_main,
      ),
      tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFF303133),
          indicatorColor: Color(0xFFFF8362),
          unselectedLabelColor: Color(0xFF909399),
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
          unselectedLabelStyle: TextStyle(
              fontSize: 14
          )
      ),
    );
  }
}
