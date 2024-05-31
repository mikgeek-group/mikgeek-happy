
import 'package:flutter/foundation.dart';

class Constant {

  // 接口地址
  static String SERVER_API_URL = "http://api.mikgeek.com";


  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;
  // 请求头
  static String authorizationToken = "authorizationToken";

  // 是否第一次打开
  static String isFirstOpen = "isFirstOpen";

  // 启动页轮播key
  static const String keyGuide = 'keyGuide';

  // 主题缓存键
  static const String theme = 'AppTheme';

  // 错误码
  static const num RESULT_ERROR = -1;
}
