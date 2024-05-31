import 'package:get/get.dart';
import 'package:happyapp/model/VodCategory.dart';

class CategoryIndexState {
  CategoryIndexState() {
    ///Initialize variables
  }

  // 分类
  var _category = <VodCategory>[].obs;

   get category => _category.value;

  set category(value) => _category.value = value;
}
