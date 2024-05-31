
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/theme/theme.dart';
import 'package:happyapp/router/route_page.dart';
import 'package:sp_util/sp_util.dart';

import 'bootstrap/bootstrap.dart';


Future<void> main() async {
  // 框架初始化
  await Bootstrap.init();

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    /// Toast 配置
    return GetMaterialApp(
      title: 'HappyGo',
      // showPerformanceOverlay: true, //显示性能标签
      // 去除右上角debug的标签
      debugShowCheckedModeBanner: false,
      // checkerboardRasterCacheImages: true,
      // showSemanticsDebugger: true, // 显示语义视图
      // checkerboardOffscreenLayers: true, // 检查离屏渲染
      theme: MkTheme.getTheme(isDarkMode: false),
      // 首页路由初始化
      initialRoute:  RoutePage.INITIAL,
      getPages: RoutePage.routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      // defaultTransition: Transition.,
      builder:FlutterSmartDialog.init(),
      // defaultTransition: Transition.,
    );
  }
}
