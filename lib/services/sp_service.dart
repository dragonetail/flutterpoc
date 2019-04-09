import 'dart:convert';

import 'package:flutterpoc/models/index.dart';
import 'package:flutterpoc/common/index.dart';

class SpService {
  static const String splash_guide_mode = 'splash.guide.mode';
  static const String splash_ad_model = 'splash.ad.model';
  static const String splash_guide_model = 'splash.guide.model';

  static final SpUtils spUtils = SpUtils.instance;

  static bool isSplashGuideMode() {
    return spUtils.getBool(splash_guide_mode);
  }

  static SplashAdModel getSplashAdModel([SplashAdModel defaultValue]) {
    String _splashModel = spUtils.getString(splash_ad_model);
    if (CommonUtils.isNotEmpty(_splashModel)) {
      Map userMap = json.decode(_splashModel);
      return SplashAdModel.fromJson(userMap);
    }
    return defaultValue;
  }

  static SplashGuideModel getSplashGuideModel([SplashGuideModel defaultValue]) {
    String _splashModel = spUtils.getString(splash_guide_model);
    if (CommonUtils.isNotEmpty(_splashModel)) {
      Map userMap = json.decode(_splashModel);
      return SplashGuideModel.fromJson(userMap);
    }
    return defaultValue;
  }

  static void updateSplashGuideModel() {
    //TODO
    // HttpUtils httpUtil = new HttpUtils();
    //   httpUtil.getSplash().then((model) {
    //     if (!ObjectUtil.isEmpty(model.imgUrl)) {
    //       if (_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
    //         SpHelper.putObject(Constant.key_splash_model, model);
    //         setState(() {
    //           _splashModel = model;
    //         });
    //       }
    //     } else {
    //       SpHelper.putObject(Constant.key_splash_model, null);
    //     }
    //   });
  }
}
