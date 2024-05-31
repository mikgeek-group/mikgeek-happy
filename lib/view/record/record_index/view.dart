import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/mk_card_container.dart';
import 'package:happyapp/components/mk_list_cell_item.dart';
import 'package:happyapp/components/theme/theme.dart';

import 'controller.dart';

class RecordIndexPage extends StatefulWidget {
  const RecordIndexPage({Key? key}) : super(key: key);

  @override
  State<RecordIndexPage> createState() => _RecordIndexPageState();
}

class _RecordIndexPageState extends State<RecordIndexPage> {
  final controller = Get.find<RecordIndexController>();
  final state = Get.find<RecordIndexController>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记录"),
      ),
      body: SingleChildScrollView(
        child: MkCardContainer(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(MkTheme.iDefaultPadding),
          child: Column(
            children: [
              MkListCellItem(value: "浏览记录", press: () {}),
              MkListCellItem(value: "缓存记录", press: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
