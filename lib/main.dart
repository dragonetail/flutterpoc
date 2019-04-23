import 'package:flutter/material.dart';
import 'package:persist_theme/persist_theme.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/pages/index.dart';
import 'package:flutterpoc/services/index.dart';
import 'package:flutterpoc/data/models.dart';
// import 'package:flutter/rendering.dart';

void main() async {
  //BlocSupervisor().delegate = SimpleBlocDelegate();

  await _init();
  _delayedInit();

  // debugPaintSizeEnabled=true;
  runApp(MyApp());
}

Future _init() async {
  //等待SP初始化完毕
  return await SpUtils.instance.initializationDone;
}

void _delayedInit() {
  //3秒之后获取服务器最新的Splash信息，更新本地存储
  Future.delayed(const Duration(seconds: 3), () {
    SplashService.updateSplashInfo();
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModel _theme = ThemeModel();
  final SettingsModel _settings = SettingsModel();
  final AuthenticationModel _auth = AuthenticationModel();

  @override
  void initState() {
    // try {
    //   _auth.loadSettings();
    // } catch (e) {
    //   print("Error Loading Settings: $e");
    // }
    try {
      //TODO 异步调用有问题???
      _theme.init();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
      model: _theme,
      child: ScopedModel<SettingsModel>(
        model: _settings,
        child: ScopedModel<AuthenticationModel>(
          model: _auth,
          child: ScopedModelDescendant<ThemeModel>(
            builder: (context, child, theme) => MaterialApp(
                  theme: theme.theme,
                  home: ScopedModelDescendant<AuthenticationModel>(
                      builder: (context, child, model) {
                    return SplashPage();
                    // if (model?.user != null) return Home();
                    // return LoginPage();
                  }),
                  routes: <String, WidgetBuilder>{
                    '/main': (ctx) => HomePage(),
                    '/Login': (ctx) => LoginPage(),
                    '/signup': (ctx) =>
                        SignupAndResetPasswordPage(isSignup: true),
                    '/resetPassword': (ctx) =>
                        SignupAndResetPasswordPage(isSignup: false),
                    '/splash': (ctx) => SplashPage(),
                    "/settings": (ctx) => SettingsPage(),
                  },
                ),
          ),
        ),
      ),
    );
  }
}
