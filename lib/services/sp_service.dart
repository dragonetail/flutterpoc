import 'dart:convert';

import 'package:flutterpoc/models/index.dart';
import 'package:flutterpoc/common/index.dart';

class SpService {
  static const String splash_ad_mode = 'splash.ad.mode';
  static const String splash_ad_model = 'splash.ad.model';
  static const String splash_guide_model = 'splash.guide.model';

  static final SpUtils spUtils = SpUtils.instance;

  static bool isSplashAdMode() {
    return spUtils.getBool(splash_ad_mode);
  }

  static void clearSplashAdMode() {
    spUtils.remove(splash_ad_mode);
  }

  static void setSplashAdMode() {
    spUtils.putBool(splash_ad_mode, true);
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
