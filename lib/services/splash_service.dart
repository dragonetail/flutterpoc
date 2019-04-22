import 'dart:convert';

import 'package:flutterpoc/data/models.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/api/index.dart';

class SplashService {
  static const String splash_version = 'splash.version';
  static const String splash_mode_ad = 'splash.mode.ad';
  static const String splash_ad = 'splash.ad';
  static const String splash_guide = 'splash.guide';

  static final SpUtils spUtils = SpUtils.instance;

  static bool isSplashModeAd() {
    return spUtils.getBool(splash_mode_ad);
  }

  static void clearSplashModeAd() {
    spUtils.remove(splash_mode_ad);
  }

  static void setSplashModeAd() {
    spUtils.putBool(splash_mode_ad, true);
  }

  static SplashAd getSplashAd([SplashAd defaultValue]) {
    String _splash = spUtils.getString(splash_ad);
    if (CommonUtils.isNotEmpty(_splash)) {
      Map userMap = json.decode(_splash);
      return SplashAd.fromJson(userMap);
    }
    return defaultValue;
  }

  static SplashGuide getSplashGuide([SplashGuide defaultValue]) {
    String _splash = spUtils.getString(splash_guide);
    if (CommonUtils.isNotEmpty(_splash)) {
      Map userMap = json.decode(_splash);
      return SplashGuide.fromJson(userMap);
    }
    return defaultValue;
  }

  static void updateSplashInfo() {
    String version = spUtils.getString(splash_version) ?? '';

    Future<Splash> future = SplashApi.getSplashMode(version);
    future.then((Splash splash) {
      spUtils.putString(splash_version, splash.version ?? '');

      if (splash.nextShowGuide) {
        clearSplashModeAd();
      }

      if (splash.updateAd && splash.ad != null) {
        String _jsonStr = json.encode(splash.ad.toJson());
        spUtils.putString(splash_ad, _jsonStr);
      }

      if (splash.updateGuide && splash.guide != null) {
        String _jsonStr = json.encode(splash.guide.toJson());
        spUtils.putString(splash_guide, _jsonStr);
      }
    }, onError: (error) {
      print(error);
    });
  }
}
