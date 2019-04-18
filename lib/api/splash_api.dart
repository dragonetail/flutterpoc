import 'dart:io';
import 'dart:convert';

import './http_dio.dart';
import 'package:flutterpoc/models/index.dart';
import 'package:flutterpoc/common/index.dart';

class SplashApi {
  static const String splash_ad_mode = 'splash.ad.mode';
  static const String splash_ad_model = 'splash.ad.model';
  static const String splash_guide_model = 'splash.guide.model';

  static final SpUtils spUtils = SpUtils.instance;

  static Future<SplashAdModel> isSplashAdMode() async {
    {
      try {
        Response response = await dio.get(
          "/test",
          queryParameters: {"id": 12, "name": "wendu"},
          options: expectHttpOK,
        );
        print(response.data.toString());
      } on DioError catch (error) {
        if (error.response.statusCode == 302) {
          // do your stuff here
        }
      }
    }
  }

  // dio.post("http://10.1.10.250:3000",data:{"a":1}).then((r) {
  //   setState(() {
  //     _text = r.data.replaceAll(RegExp(r"\s"), "");
  //   });
  // }).catchError(print);
}
