import 'package:get/get.dart';

import 'controller.dart';

class CategoryIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryIndexController());
  }
}
