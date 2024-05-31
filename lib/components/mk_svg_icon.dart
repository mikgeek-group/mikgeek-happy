import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MkSvgIcon extends StatelessWidget {
  final String assetName;
  final double? size;
  final Color? color;

  const MkSvgIcon(
      this.assetName, {
        Key? key,
        this.size,
        this.color,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
      color: color,
    );
  }
}