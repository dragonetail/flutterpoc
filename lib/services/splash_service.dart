import 'dart:convert';

import 'package:flutterpoc/models/index.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/api/index.dart';

class SplashService {
  static const String splash_version = 'splash.version';
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

  static void updateSplashInfo() {
    String version = spUtils.getString(splash_version) ?? '';

    Future<SplashModel> future = SplashApi.getSplashMode(version);
    future.then((SplashModel splash) {
      spUtils.putString(splash_version, splash.version ?? '');

      if (splash.nextShowGuide) {
        clearSplashAdMode();
      }

      if (splash.updateAdInfo && splash.adInfo != null) {
        String _jsonStr = json.encode(splash.adInfo.toJson());
        spUtils.putString(splash_ad_model, _jsonStr);
      }

      if (splash.updateGuideInfo && splash.guideInfo != null) {
        String _jsonStr = json.encode(splash.guideInfo.toJson());
        spUtils.putString(splash_guide_model, _jsonStr);
      }
    }, onError: (error) {
      print(error);
    });
  }
}
