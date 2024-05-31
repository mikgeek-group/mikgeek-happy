import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:happyapp/api/vod.dart';
import 'package:happyapp/util/toast_util.dart';

import 'state.dart';

class HomeIndexController extends GetxController {
  final HomeIndexState state = HomeIndexState();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    ToastUtil.showLoading("加载中...");

    state.vodPagination = await VodApi.list({"limit":"20","vodName":"庆余"});
    state.init = true;
    ToastUtil.cancelLoading();

    update();
  }
}
