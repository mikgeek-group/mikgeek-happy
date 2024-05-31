import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:happyapp/util/device_util.dart';
import 'package:sp_util/sp_util.dart';

class Bootstrap {
  static Future<void> init() async {
    /// 确保初始化完成
    WidgetsFlutterBinding.ensureInitialized();


    // 缓存初始化
    await SpUtil.getInstance();



    // 设备信息初始化
    await DeviceUtil.initDeviceInfo();

    // 安卓 flutter 沉浸式透明状态栏 #安卓状态栏设置成透明
    if (DeviceUtil.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
