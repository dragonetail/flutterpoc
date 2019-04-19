import 'dart:async';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/models/index.dart';
import 'package:flutterpoc/services/index.dart';

class SplashBloc extends BaseBloc<BaseEvent, BaseState> {
  @override
  BaseState get initialState {
    _init();

    return SplashInitialState();
  }

  void _init() async {
    //等待SP初始化完毕
    await SpUtils.instance.initializationDone;
    if (SplashService.isSplashAdMode()) {
      this.dispatch(SplashAdEvent());
    } else {
      this.dispatch(SplashGuideEvent());
    }

    //3秒之后获取服务器最新的Splash信息，更新本地存储
    Future.delayed(const Duration(seconds: 3), () {
      SplashService.updateSplashInfo();
    });
  }

  @override
  Map<Type, Function(BaseEvent)> get mapper => {
        SplashGuideEvent: _mapSplashGuideEventToState,
        SplashAdEvent: _mapSplashAdEventToState,
      };

  Stream<BaseState> _mapSplashGuideEventToState(BaseEvent event) async* {
    SplashGuideModel splashGuideModel =
        SplashService.getSplashGuideModel(SplashGuideModel(
      isUrl: false,
      images: [
        Utils.getImgPath('guide1', format: 'jpg'),
        Utils.getImgPath('guide2', format: 'jpg'),
        Utils.getImgPath('guide3', format: 'jpg'),
        Utils.getImgPath('guide4', format: 'jpg'),
      ],
      textInfos: [
        "在你需要的每个地方",
        "载你去往每个地方",
        "懂你，更懂你所行",
        "因为在意，所以用心",
      ],
    ));
    yield SplashGuideState(splashGuideModel);
  }

  Stream<BaseState> _mapSplashAdEventToState(BaseEvent event) async* {
    SplashAdModel splashAdModel = SplashService.getSplashAdModel(SplashAdModel(
      title: '带你去旅行',
      imageUrl:
          'https://raw.githubusercontent.com/dragonetail/flutterpoc/master/assets/images/3.0x/ad.jpg',
      targetUrl: 'https://github.com/dragonetail/flutterpoc/',
    ));
    yield SplashAdState(splashAdModel);
  }
}

//Event定义
class SplashGuideEvent extends BaseEvent {}

class SplashAdEvent extends BaseEvent {}

//State定义
class SplashInitialState extends BaseState {
  SplashInitialState() : super();
}

class SplashGuideState extends BaseState {
  final SplashGuideModel splashGuideModel;

  SplashGuideState(this.splashGuideModel) : super([splashGuideModel]);
}

class SplashAdState extends BaseState {
  final SplashAdModel splashAdModel;

  SplashAdState(this.splashAdModel) : super([splashAdModel]);
}
