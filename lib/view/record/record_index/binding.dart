import 'package:get/get.dart';

import 'controller.dart';

class RecordIndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecordIndexController());
  }
}
