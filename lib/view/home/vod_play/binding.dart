import 'package:get/get.dart';

import 'controller.dart';

class VodPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VodPlayController());
  }
}
