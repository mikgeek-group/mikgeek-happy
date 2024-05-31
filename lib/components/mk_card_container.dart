import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happyapp/components/theme/theme.dart';

const EdgeInsets _margin = EdgeInsets.only(
  left: MkTheme.iDefaultPadding,
  right: MkTheme.iDefaultPadding,
  bottom: MkTheme.iDefaultPadding,
);

const EdgeInsets _padding = EdgeInsets.symmetric(
  vertical: MkTheme.iDefaultPadding,
);

/**
 * 卡片容器
 *
 * 用于包裹卡片内容的容器，提供了一些样式属性
 */
class MkCardContainer extends StatelessWidget {
  const MkCardContainer({
    Key? key,
    this.child, // 子组件
    this.margin = _margin, // 边距
    this.padding = _padding, // 内边距
    this.height,
    this.border,// 容器高度
    this.isTransparent = false, // 是否透明
    this.borderRadius = MkTheme.iBorderRadius, // 是否透明
  }) : super(key: key);

  final Widget? child; // 子组件
  final double? height; // 容器高度
  final EdgeInsets margin, padding; // 边距和内边距
  final bool isTransparent; // 是否透明
  final BorderRadiusGeometry borderRadius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:Get.width,
      margin: margin, // 边距
      padding: padding, // 内边距
      height: height, // 容器高度
      decoration: BoxDecoration(
        color: isTransparent ? Colors.transparent : Theme.of(context).cardColor, // 容器背景颜色
        borderRadius: borderRadius,
        border: border// 容器圆角半径
      ),
      child: child, // 子组件
    );
  }
}
