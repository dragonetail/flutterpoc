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
    if (SpService.isSplashGuideMode()) {
      this.dispatch(SplashGuideEvent());
    } else {
      this.dispatch(SplashAdEvent());
    }
  }

  @override
  Map<Type, Function(BaseEvent)> get mapper => {
        SplashGuideEvent: _mapSplashGuideEventToState,
        SplashAdEvent: _mapSplashAdEventToState,
      };

  Stream<BaseState> _mapSplashGuideEventToState(BaseEvent event) async* {
    SplashGuideModel splashGuideModel =
        SpService.getSplashGuideModel(SplashGuideModel(
      isUrl: false,
      images: [
        Utils.getImgPath('guide1'),
        Utils.getImgPath('guide2'),
        Utils.getImgPath('guide3'),
        Utils.getImgPath('guide4'),
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
    SplashAdModel splashAdModel = SpService.getSplashAdModel(SplashAdModel(
      title: 'Flutter 常用工具类库',
      imageUrl:
          'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png',
      targetUrl: 'https://www.jianshu.com/p/425a7ff9d66e',
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
