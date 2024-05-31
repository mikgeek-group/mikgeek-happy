import 'package:get/get.dart';
import 'package:happyapp/view/category/category_vod_list/binding.dart';
import 'package:happyapp/view/category/category_vod_list/index.dart';
import 'package:happyapp/view/home/index.dart';
import 'package:happyapp/view/navigation.dart';
import 'route_name.dart';

class RoutePage {
  // 第一个界面
  static const INITIAL = RouteName.main;

  static final List<GetPage> routes = [
    GetPage(
      name: RouteName.main,
      page: () => const Navigation(),
    ),
    GetPage(
      name: RouteName.vodPlay,
      binding: VodPlayBinding(),
      page: () =>  VodPlayPage(),
    ),
  GetPage(
      name: RouteName.categoryVodList,
      binding: CategoryVodListBinding(),
      page: () =>  CategoryVodListPage(),
    ),


  ];
}
