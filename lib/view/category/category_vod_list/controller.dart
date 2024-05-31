import 'dart:async';

import 'package:get/get.dart';
import 'package:happyapp/api/vod.dart';

import 'state.dart';

class CategoryVodListController extends GetxController {
  final CategoryVodListState state = CategoryVodListState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    state.categoryName = Get.arguments['name'];
    state.categoryId = Get.arguments['id'];

  }

  getDataList() async {
    var data = await VodApi.list({
      "vodCategoryId": state.categoryId,
      "current": state.current.toString(),
      "size": state.size.toString(),
    });
    state.dataList.addAll(data.records!);
    update();
  }

  FutureOr onRefresh() {
    state.current = 1;
    state.dataList.clear();
    getDataList();
  }

  FutureOr onLoad() {
    state.current++;
    getDataList();
  }
}
