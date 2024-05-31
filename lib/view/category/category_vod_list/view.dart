import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CategoryVodListPage extends StatefulWidget {
  const CategoryVodListPage({Key? key}) : super(key: key);

  @override
  State<CategoryVodListPage> createState() => _CategoryVodListPageState();
}

class _CategoryVodListPageState extends State<CategoryVodListPage> {
  final controller = Get.find<CategoryVodListController>();
  final state = Get.find<CategoryVodListController>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryVodListController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.categoryName),
          ),
          body:  EasyRefresh(
              onRefresh: controller.onRefresh,
              onLoad: controller.onLoad,
              child:  ListView.builder(
                  itemCount: state.dataList.length,
                  itemBuilder: _itemBuilder)
          ),
        );
      },
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    return Text(state.dataList[index].vodName);
  }

  @override
  void dispose() {
    Get.delete<CategoryVodListController>();
    super.dispose();
  }
}