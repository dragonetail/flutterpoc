import 'dart:convert';

import 'package:flutterpoc/data/beans.dart';
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

  static SplashAd getSplashAd() {
    String _splash = spUtils.getString(splash_ad);
    if (CommonUtils.isNotEmpty(_splash)) {
      Map userMap = json.decode(_splash);
      return SplashAd.fromJson(userMap);
    }
    return SplashAd(
      title: '带你去旅行',
      imageUrl:
          'https://raw.githubusercontent.com/dragonetail/flutterpoc/master/assets/images/3.0x/ad.jpg',
      targetUrl: 'https://github.com/dragonetail/flutterpoc/',
    );
  }

  static SplashGuide getSplashGuide() {
    String _splash = spUtils.getString(splash_guide);
    if (CommonUtils.isNotEmpty(_splash)) {
      Map userMap = json.decode(_splash);
      return SplashGuide.fromJson(userMap);
    }
    return SplashGuide(
      isUrl: false,
      images: [
        Utils.getImgPath('guide1', format: 'jpg'),
        Utils.getImgPath('guide2', format: 'jpg'),
        Utils.getImgPath('guide3', format: 'jpg'),
        Utils.getImgPath('guide4', format: 'jpg'),
      ],
      texts: [
        "在你需要的每个地方",
        "载你去往每个地方",
        "懂你，更懂你所行",
        "因为在意，所以用心",
      ],
    );
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
