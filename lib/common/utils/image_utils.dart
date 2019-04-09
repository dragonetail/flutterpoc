export 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterpoc/common/index.dart';

class ImageUtils {
  static Widget imageWidgets(
    String url, {
    double width = double.infinity,
    double height = double.infinity,
    BoxFit fit,
  }) {
    if (RegexUtils.isURL(url)) {
      return new CachedNetworkImage(
        fit: fit,
        width: width,
        height: height,
        imageUrl: url,
      );
    } else {
      return Image.asset(
        url,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
