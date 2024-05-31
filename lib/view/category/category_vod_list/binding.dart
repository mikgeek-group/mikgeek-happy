import 'package:get/get.dart';

import 'controller.dart';

class CategoryVodListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryVodListController());
  }
}
