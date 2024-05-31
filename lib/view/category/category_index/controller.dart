import 'package:get/get.dart';
import 'package:happyapp/api/vod.dart';
import 'package:happyapp/router/route_name.dart';

import 'state.dart';

class CategoryIndexController extends GetxController {
  final CategoryIndexState state = CategoryIndexState();


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    state.category = await VodApi.getCategory();



  }

  categoryClick(id,name) {
    Get.toNamed(RouteName.categoryVodList,arguments: {
      "id": id,
      "name": name
    });
  }
}
