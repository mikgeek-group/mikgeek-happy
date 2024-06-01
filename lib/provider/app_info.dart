import 'package:flutter/material.dart';
import 'package:happyapp/common/constant.dart';
import 'package:happyapp/utils/sp_helper.dart';

class AppInfoProvider with ChangeNotifier {
  String _themeColor = 'pink';

  String get themeColor => _themeColor;

  void setTheme(String themeColor) {
    _themeColor = themeColor;
    SpHelper.putString(Constant.keyThemeColor, themeColor);
    notifyListeners();
  }
}
