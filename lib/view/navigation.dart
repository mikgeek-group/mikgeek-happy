import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/mk_bottom_navigation.dart';
import 'package:happyapp/generated/assets.dart';
import 'package:happyapp/view/category/category_index/controller.dart';
import 'package:happyapp/view/category/category_index/index.dart';
import 'package:happyapp/view/home/home_index/controller.dart';
import 'package:happyapp/view/home/home_index/index.dart';
import 'package:happyapp/view/record/index.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  PageController _pageViewController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(HomeIndexController());
    Get.put(CategoryIndexController());
    Get.put(RecordIndexController());
  }

  int _currentIndex = 0;

  List<Widget> pageList = [
    HomeIndexPage(),
    CategoryIndexPage(),
    RecordIndexPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _pageViewController,
        children: pageList,
        onPageChanged: _pageChanged,
      ),
      bottomNavigationBar: MkBottomNavigation(
        currentIndex: _currentIndex,
        items: [
          MkNavigationItemModel(
            label: "首页",
            icon: Assets.svgHome,
            activeIcon: Assets.svgHomeActive,
          ),
          MkNavigationItemModel(
            label: "分类",
            icon: Assets.svgCommunication,
            activeIcon: Assets.svgCommunicationActive,
          ),
          MkNavigationItemModel(
            label: "记录",
            icon: Assets.svgUser,
            activeIcon: Assets.svgUserActive,
          ),
        ],
        onTap: navigationChange, // 切换tab事件
      ),
    );
  }

  navigationChange(int index) {
    _currentIndex = index;
    _pageViewController.jumpToPage(index);
    setState(() {});
  }

  void _pageChanged(int value) {
    _currentIndex = value;
    setState(() {});
  }
}
