
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BdImageUtil {
  
  static ImageProvider getAssetImage(String name, {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }

  static ImageProvider getImageProvider(String? imageUrl, {String holderImg = 'none'}) {
    if (imageUrl == '') {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl!);
  }
}

enum ImageFormat {
  png,
  jpg,
  jpeg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'jpeg','gif', 'webp'][index];
}
