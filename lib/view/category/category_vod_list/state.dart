import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CategoryVodListState {
  CategoryVodListState() {
    ///Initialize variables
  }

  var _categoryId = "".obs;
  get categoryId => _categoryId.value;
  set categoryId(value) => _categoryId.value = value;

  var _categoryName = "".obs;
  get categoryName => _categoryName.value;
  set categoryName(value) => _categoryName.value = value;


  var _dataList  = [].obs;
  get dataList => _dataList.value;
  set dataList(value) => _dataList.value = value;


  var _current = 1.obs;
  get current => _current.value;
  set current(value)=>_current.value = value;

  var _size = 12.obs;
  get size => _size.value;
  set size(value)=>_size.value = value;


}
