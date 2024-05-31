import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/mk_title.dart';
import 'package:happyapp/components/theme/gaps.dart';
import 'package:happyapp/components/theme/theme.dart';
import 'package:happyapp/components/vod.dart';
import 'package:happyapp/model/VodPagination.dart';
import 'package:happyapp/util/mk_load_image.dart';

import 'controller.dart';

class HomeIndexPage extends StatefulWidget {
  const HomeIndexPage({Key? key}) : super(key: key);

  @override
  State<HomeIndexPage> createState() => _HomeIndexPageState();
}

class _HomeIndexPageState extends State<HomeIndexPage> {
  final controller = Get.find<HomeIndexController>();
  final state = Get.find<HomeIndexController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HappyGo"),
        centerTitle: false,
        actions: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.search_rounded,
                size: 20,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MkTheme.iDefaultPadding,
              right: MkTheme.iDefaultPadding,
              bottom: MkTheme.iDefaultPadding * 2),
          child: Column(
            children: [
              Gaps.vGap8,
              MkTitle(title: "今日更新"),
              Gaps.vGap8,
              Obx(() => _buildVideoList(state.vodPagination)),
            ],
          ),
        ),
      ),
    );
  }

  _buildVideoList(VodPagination vodPagination) {
    if (!state.init) {
      return Container();
    }
    return Vod(vodPagination: vodPagination);
  }
}
