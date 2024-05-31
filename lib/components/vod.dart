import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/theme/gaps.dart';
import 'package:happyapp/components/theme/theme.dart';
import 'package:happyapp/model/VodPagination.dart';
import 'package:happyapp/router/route_name.dart';
import 'package:happyapp/util/mk_load_image.dart';

class Vod extends StatelessWidget {
  const Vod({super.key, required this.vodPagination});

  final VodPagination vodPagination;

  @override
  Widget build(BuildContext context) {
    double width = (Get.width - (MkTheme.iDefaultPadding * 2) - 40) / 2;
    List<Widget> Boxs() =>
        List.generate(vodPagination.records!.length, (index) {
          return InkWell(
            onTap: () => {
              Get.toNamed(RouteName.vodPlay,
                  arguments: {"id": vodPagination.records?[index].id})
            },
            child: Container(
                width: width,
                padding: EdgeInsets.only(bottom: MkTheme.iDefaultPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor, // 容器背景颜色
                  borderRadius: MkTheme.iBorderRadius,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: MkTheme.iBorderRadius,
                          child: MkLoadImage(
                            vodPagination.records?[index].vodPic as String,
                            height: 220,
                            width: width,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 3),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4)),
                              ),
                              child: Text(
                                vodPagination.records?[index].vodRemarks
                                    as String,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ))
                      ],
                    ),
                    Gaps.vGap8,
                    Row(
                      children: [
                        BrnStateTag(
                          tagText:
                              vodPagination.records?[index].vodClass as String,
                          tagState: TagState.succeed,
                        ),
                      ],
                    ),
                    Gaps.vGap8,
                    Text(
                      vodPagination.records![index].vodName as String,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          );
        });

    return Wrap(
      spacing: 30, //主轴上子控件的间距
      runSpacing: 20, //交叉轴上子控件之间的间距
      children: Boxs(), //要显示的子控件集合
    );
  }
}
