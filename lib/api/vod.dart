import 'package:happyapp/model/VodCategory.dart';
import 'package:happyapp/model/VodPagination.dart';
import 'package:happyapp/util/http_util.dart';

import '../model/Vod.dart';

class VodApi {
  /**
   * 分类
   */
  static Future<List<VodCategory>> getCategory() async {
    var response = await HttpUtil().get('/vod/category');
    return response['data']
        .map<VodCategory>((item) => VodCategory.fromJson(item))
        .toList();
  }

  /**
   * 分页查询
   */
  static Future<VodPagination> list(Map<String, String> queryParameters) async {
    var response =
        await HttpUtil().get('/vod/list', queryParameters: queryParameters);
    return VodPagination.fromJson(response['data']);
  }


  static Future<Vod> getById(int id) async {
    var response =
    await HttpUtil().get('/vod/getById?id=' + id.toString(),);
    return Vod.fromJson(response['data']);
  }
}
