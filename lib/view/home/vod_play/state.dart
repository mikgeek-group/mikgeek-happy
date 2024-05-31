import 'package:get/get.dart';
import 'package:happyapp/model/Vod.dart';

class VodPlayState {
  VodPlayState() {
    ///Initialize variables
  }

  var _init = false.obs;
  bool get init => _init.value;
  set init(bool value) => _init.value = value;

  var _vod = Vod().obs;

  Vod get vod => _vod.value;

  set vod(Vod value) => _vod.value = value;

  var _playList = <Map<String, String>>[].obs;

  List<Map<String, String>> get playList => _playList;

  set playList(List<Map<String, String>> value) => _playList.value = value;
}
