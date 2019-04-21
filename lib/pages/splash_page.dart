import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/data/models.dart';
import 'package:flutterpoc/blocs/index.dart';
import 'package:flutterpoc/services/index.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc _splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BaseEvent, BaseState>(
        bloc: _splashBloc,
        builder: (BuildContext context, BaseState baseState) {
          if (baseState is SplashGuideState) {
            return buildSplashGuideWidget(baseState);
          } else if (baseState is SplashAdState) {
            return buildSplashAdWidget(baseState);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildSplashAdWidget(SplashAdState state) {
    SplashAd splashAdModel = state.splashAdModel;
    return SplashADPage(
      adImageUrl: splashAdModel.imageUrl,
      skipActionTitle: '跳过',
      skipAction: _skipAction,
      adAction: _adAction,
      count: 3,
      logoImagePath: Utils.getImgPath('splash_logo'),
    );
  }

  Widget buildSplashGuideWidget(SplashGuideState state) {
    SplashGuide splashGuideModel = state.splashGuide;
    return SplashGuidePage(
        images: splashGuideModel.images,
        textInfos: splashGuideModel.texts,
        nextActionTitle: '立即启程',
        nextAction: _nextActionFromGuide);
  }

  void _nextActionFromGuide() {
    SplashService.setSplashModeAd();
    Navigator.of(context).pushReplacementNamed('/Main');
  }

  void _skipAction() {
    Navigator.of(context).pushReplacementNamed('/Main');
  }

  void _adAction() {
    if (!(_splashBloc.currentState is SplashAdState)) {
      return;
    }
    SplashAd splashAdModel =
        (_splashBloc.currentState as SplashAdState).splashAdModel;

    Navigator.of(context).pushReplacementNamed('/Main');
    NavigatorUtil.pushWeb(context,
        title: splashAdModel.title, url: splashAdModel.targetUrl);
  }

  @override
  void dispose() {
    _splashBloc.dispose();
    super.dispose();
  }
}
