import 'package:get/get.dart';
import 'package:happyapp/model/VodPagination.dart';

class HomeIndexState {
  HomeIndexState() {
    ///Initialize variables
  }

  var _vodPagination = VodPagination().obs;

  VodPagination get vodPagination => _vodPagination.value;

  set vodPagination(VodPagination value) => _vodPagination.value = value;

  var _isInit = false.obs;

  bool get init => _isInit.value;

  set init(bool value) => _isInit.value = value;
}
