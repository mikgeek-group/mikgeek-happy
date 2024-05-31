import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/mk_title.dart';
import 'package:happyapp/components/theme/theme.dart';

import 'controller.dart';

class CategoryIndexPage extends StatefulWidget {
  const CategoryIndexPage({Key? key}) : super(key: key);

  @override
  State<CategoryIndexPage> createState() => _CategoryIndexPageState();
}

class _CategoryIndexPageState extends State<CategoryIndexPage> {
  final controller = Get.find<CategoryIndexController>();
  final state = Get.find<CategoryIndexController>().state;

  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("分类"),
        ),
        // 一行两个
        body: Padding(
            padding: EdgeInsets.all(MkTheme.iDefaultPadding),
            child: ListView.builder(
                itemCount: state.category?.length ?? 0,
                itemBuilder: _itemBuilder)
        )
    );
  }

  Widget? _itemBuilder(BuildContext context, int index) {
    double width = (Get.width - (MkTheme.iDefaultPadding * 2) - 40) / 2;
    List<Widget> Boxs(list) =>
        List.generate(list.length, (index) {
          return InkWell(
            onTap: () => {
              controller.categoryClick(list[index].id,list[index].name)
            },
            child: Container(
              width:width,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: getRandomColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(list[index].name,style: TextStyle(color: Colors.white,fontSize: 20),),
            ),
          );
        });

    return Column(
      children: [
        MkTitle(title: state.category?[index].name),
        // 循环所有子集
        Padding(
          padding: EdgeInsets.only(top: 10,bottom: 10),
          child: Wrap(
            spacing: 40, //主轴上子控件的间距
            runSpacing: 10, //交叉轴上子控件之间的间距
            children: Boxs(state.category?[index].children), //要显示的子控件集合
          ),
        )
      ],
    );
  }

}
