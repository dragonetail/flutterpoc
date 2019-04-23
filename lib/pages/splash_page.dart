import 'package:flutter/material.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/data/beans.dart';
import 'package:flutterpoc/services/index.dart';

class SplashPage extends  StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    if (SplashService.isSplashModeAd()) {
      return buildSplashAdWidget(SplashService.getSplashAd());
    } else {
      return buildSplashGuideWidget(SplashService.getSplashGuide());
    }
  }

  Widget buildSplashAdWidget(SplashAd splashAd) {
    return SplashADPage(
      adImageUrl: splashAd.imageUrl,
      skipActionTitle: '跳过',
      skipAction: _skipAction,
      adAction: _adAction,
      count: 3,
      logoImagePath: Utils.getImgPath('splash_logo'),
    );
  }

  Widget buildSplashGuideWidget(SplashGuide splashGuide) {
    return SplashGuidePage(
        images: splashGuide.images,
        textInfos: splashGuide.texts,
        nextActionTitle: '立即启程',
        nextAction: _nextActionFromGuide);
  }

  void _nextActionFromGuide() {
    SplashService.setSplashModeAd();
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _skipAction() {
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _adAction() {
    if (!(SplashService.isSplashModeAd())) {
      return;
    }
    SplashAd splashAd = SplashService.getSplashAd();

    Navigator.of(context).pushReplacementNamed('/main');
    NavigatorUtil.pushWeb(context,
        title: splashAd.title, url: splashAd.targetUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
