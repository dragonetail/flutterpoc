# APP启动页（Splash Page）



**说明：** 本部分完成部分在分支： <https://github.com/dragonetail/flutterpoc/tree/3-splash_page>

**目标：** 涉及Flutter的Router和Splash Page工作原理，全程使用Bloc模式。

**思路：** 

- 使用Model定义Splash过程所涉及的数据，引导页、广告页、同服务器交互更新图片所有的数据Model。
- 存储数据Splash所用数据到SP（shared_preferences）中。
- 提供HTTP API通过后端Rest更新Splash显示所用图片和标题，控制显示动作。
- 抽象Service提供对SP和HTTP数据的访问封装。
- 定义Bloc，根据SP中获取的数据进行视图Builder构建，包括默认数据行为设置。
- 实现Page页面；
- 通过Common封装实现引导页、广告页的View。



1. Model数据：

   引导页数据模型。

   ```dart
   class SplashGuideModel {
     bool isUrl;
     List<String> images;
     List<String> textInfos;
   
     SplashGuideModel({this.isUrl, this.images, this.textInfos});
   
     SplashGuideModel.fromJson(Map<String, dynamic> json)
         : isUrl = json['isUrl'],
           images = json['images'].cast<String>(),
           textInfos = json['textInfos'].cast<String>();
   
     Map<String, dynamic> toJson() => {
           'tiisUrltle': isUrl,
           'images': images,
           'textInfos': textInfos,
         };
   
     @override
     String toString() {
       StringBuffer sb = new StringBuffer('{');
       sb.write("\"isUrl\":\"$isUrl\"");
       sb.write(",\"images\":\"$images\"");
       sb.write(",\"textInfos\":\"$textInfos\"");
       sb.write('}');
       return sb.toString();
     }
   }
   ```

   广告页数据模型：

   ```dart
   class SplashAdModel {
     String title;
     String imageUrl;
     String targetUrl;
   
     SplashAdModel({this.title, this.imageUrl, this.targetUrl});
   
     SplashAdModel.fromJson(Map<String, dynamic> json)
         : title = json['title'],
           imageUrl = json['imageUrl'],
           targetUrl = json['targetUrl'];
   
     Map<String, dynamic> toJson() => {
           'title': title,
           'imageUrl': imageUrl,
           'targetUrl': targetUrl,
         };
   
     @override
     String toString() {
       StringBuffer sb = new StringBuffer('{');
       sb.write("\"title\":\"$title\"");
       sb.write(",\"imageUrl\":\"$imageUrl\"");
       sb.write(",\"targetUrl\":\"$targetUrl\"");
       sb.write('}');
       return sb.toString();
     }
   }
   ```

   网络通信用的数据模型：

   ```dart
   import './index.dart';
   
   class SplashModel {
     String version;
     bool nextShowGuide;
     bool updateGuideInfo;
     bool updateAdInfo;
     SplashGuideModel guideInfo;
     SplashAdModel adInfo;
   
     SplashModel(
         {this.version,
         this.nextShowGuide,
         this.updateGuideInfo,
         this.updateAdInfo,
         this.guideInfo,
         this.adInfo});
   
     SplashModel.fromJson(Map<String, dynamic> json)
         : version = json['version'],
           nextShowGuide = json['nextShowGuide'],
           updateGuideInfo = json['updateGuideInfo'],
           updateAdInfo = json['updateAdInfo'],
           guideInfo = json['guideInfo'] == null
               ? null
               : SplashGuideModel.fromJson(json['guideInfo']),
           adInfo = json['adInfo'] == null
               ? null
               : SplashAdModel.fromJson(json['adInfo']);
   
     Map<String, dynamic> toJson() => {
           'version': version,
           'nextShowGuide': nextShowGuide,
           'updateGuideInfo': updateGuideInfo,
           'updateAdInfo': updateAdInfo,
           'guideInfo': guideInfo?.toJson(),
           'adInfo': adInfo?.toJson(),
         };
   
     @override
     String toString() {
       StringBuffer sb = new StringBuffer('{');
       sb.write("\"version\":\"$version\"");
       sb.write("\"nextShowGuide\":\"$nextShowGuide\"");
       sb.write(",\"updateGuideInfo\":\"$updateGuideInfo\"");
       sb.write(",\"updateAdInfo\":\"$updateAdInfo\"");
       sb.write(",\"guideInfo\":\"$guideInfo\"");
       sb.write(",\"adInfo\":\"$adInfo\"");
       sb.write('}');
       return sb.toString();
     }
   }
   ```

   

2. SP访问封装工具类（shared_preferences）：

   ```dart
   import 'dart:async';
   import 'dart:convert';
   import 'package:shared_preferences/shared_preferences.dart';
   
   /// SpUtils spUtils = SpUtils();
   /// or SpUtils spUtils = SpUtils.instance;
   /// await spUtils.initializationDone;  //初始化完成
   class SpUtils {
     //单体实例
     static final SpUtils _singleton = new SpUtils._internal();
   
     //工厂模式 和 静态实例
     factory SpUtils() => _singleton;
     static SpUtils get instance => _singleton;
   
     Future _doneFuture;
     Future get initializationDone => _doneFuture;
   
     //私有构造
     SpUtils._internal() {
       _doneFuture = _init();
     }
   
     SharedPreferences _prefs;
     Future _init() async {
       _prefs = await SharedPreferences.getInstance();
     }
   
     Future<bool> putObject(String key, Object value) {
       return _prefs.setString(key, value == null ? "" : json.encode(value));
     }
   
     Map getObject(String key) {
       String _data = _prefs.getString(key);
       return (_data == null || _data.isEmpty) ? null : json.decode(_data);
     }
   
     Future<bool> putObjectList(String key, List<Object> list) {
       List<String> _dataList = list?.map((value) {
         return json.encode(value);
       })?.toList();
       return _prefs.setStringList(key, _dataList);
     }
   
     List<Map> getObjectList(String key) {
       List<String> dataLis = _prefs.getStringList(key);
       return dataLis?.map((value) {
         Map _dataMap = json.decode(value);
         return _dataMap;
       })?.toList();
     }
   
     String getString(String key, {String defaultValue: ''}) {
       return _prefs.getString(key) ?? defaultValue;
     }
   
     Future<bool> putString(String key, String value) {
       return _prefs.setString(key, value);
     }
   
     bool getBool(String key, {bool defaultValue: false}) {
       return _prefs.getBool(key) ?? defaultValue;
     }
   
     Future<bool> putBool(String key, bool value) {
       return _prefs.setBool(key, value);
     }
   
     int getInt(String key, {int defaultValue: 0}) {
       return _prefs.getInt(key) ?? defaultValue;
     }
   
     Future<bool> putInt(String key, int value) {
       return _prefs.setInt(key, value);
     }
   
     double getDouble(String key, {double defaultValue: 0.0}) {
       return _prefs.getDouble(key) ?? defaultValue;
     }
   
     Future<bool> putDouble(String key, double value) {
       return _prefs.setDouble(key, value);
     }
   
     List<String> getStringList(String key, {List<String> defaultValue: const []}) {
       return _prefs.getStringList(key) ?? defaultValue;
     }
   
     Future<bool> putStringList(String key, List<String> value) {
       return _prefs.setStringList(key, value);
     }
   
     dynamic getDynamic(String key, {Object defaultValue}) {
       return _prefs.get(key) ?? defaultValue;
     }
   
     bool haveKey(String key) {
       return _prefs.getKeys().contains(key);
     }
   
     Set<String> getKeys() {
       return _prefs.getKeys();
     }
   
     Future<bool> remove(String key) {
       return _prefs.remove(key);
     }
   
     Future<bool> clear() {
       return _prefs.clear();
     }
   }
   ```

   实现Dart语言模式的单体类（Singleton）模式，由于shared_preferences的初始化时异步的，需要调用方使用前通过`await spUtils.initializationDone;`完成初始化工作才能正常后续使用。（**注意:** 整体体验上这一点在Flutter和Dart语言设计上还是比较复杂的，对一些必须的系统依赖，需要额外关注异步和同步处理流程之间的衔接。）

   

3. 封装Http库Dio的实现。

   ```dart
   import 'dart:io';
   import 'dart:convert';
   
   import 'package:dio/dio.dart';
   export 'package:dio/dio.dart';
   import 'package:cookie_jar/cookie_jar.dart';
   import 'package:flutter/foundation.dart';
   
   var dio = new MyDio();
   
   class MyDio extends Dio {
     MyDio([BaseOptions options]) : super(options) {
       super.interceptors
         ..add(CookieManager(CookieJar()))
         ..add(LogInterceptor(responseBody: true));
       (super.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
       super.options.receiveTimeout = 15000;
       super.options.validateStatus = (int status) {
         return status >= HttpStatus.ok && status < HttpStatus.multipleChoices ||
             status == HttpStatus.notModified;
         //return status >= HttpStatus.ok && status < 300 || status == 304;
       };
       //TODO 认证Token追加到Header的处理
     }
   }
   
   // Must be top-level function
   _parseAndDecode(String response) {
     return jsonDecode(response);
   }
   
   parseJson(String text) {
     return compute(_parseAndDecode, text);
   }
   
   //全局方便约束的变量
   final Options expectHttpOK = Options(
     validateStatus: (int status) {
       return status == HttpStatus.ok; //200
     },
   );
   
   final Options expectHttpCreated = Options(
     validateStatus: (int status) {
       return status == HttpStatus.created; //201
     },
   );
   ```

   构建全局变量dio，实现了继承Dio子类MyDio，封装了通用初始化设置：Cookie处理、日志、JSON转换（reponse中的ContentType是application/json; charset=utf-8的时候，会自动把结果JSON字符串转换成JSON Map）、访问超时、默认返回有效状态校验。

   

4. 封装后端数据访问API。

   ```dart
   import './http_dio.dart';
   import 'package:flutterpoc/models/index.dart';
   
   class SplashApi {
     //Online JSON REST mock server, all data is in db.json
     //具有1分钟数据缓存，测试需要等待数据刷新
     static const String splash_base_url =
         'https://my-json-server.typicode.com/dragonetail/flutterpoc';
   
     static Future<SplashModel> getSplashMode([String version = '']) async {
       {
         Response response = await dio.get(
           splash_base_url + '/splash',
           queryParameters: {"version": version},
           options: expectHttpOK,
         );
         print(response.data);
         return SplashModel.fromJson(response.data);
       }
     }
   }
   ```

   封装后端访问数据的API实现。这里使用了`my-json-server.typicode.com`利用Github上的JSON文件实现模拟REST JSON访问请求。

   

5. 封装Model数据的访问Service。

   ```dart
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
   ```

   实现了对SP数据访问的封装，并提供一个对API访问后端数据的更新到SP的封装。

   

6. 构建BLOC，组合数据和状态控制。

   ```dart
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
   ```

   定义了两个状态：SplashGuideEvent、SplashAdEvent；定义了三个状态：SplashInitialState、SplashGuideState、SplashAdState。

   通过Event和状态实现Bloc状态迁移控制。

   

7. Page页面构造，实现状态对应Widget的构建和组装。

   ```dart
   import 'package:flutter/material.dart';
   import 'package:flutter_bloc/flutter_bloc.dart';
   import 'package:flutterpoc/common/index.dart';
   import 'package:flutterpoc/models/index.dart';
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
       SplashAdModel splashAdModel = state.splashAdModel;
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
       SplashGuideModel splashGuideModel = state.splashGuideModel;
       return SplashGuidePage(
           images: splashGuideModel.images,
           textInfos: splashGuideModel.textInfos,
           nextActionTitle: '立即启程',
           nextAction: _nextActionFromGuide);
     }
   
     void _nextActionFromGuide() {
       SplashService.setSplashAdMode();
       Navigator.of(context).pushReplacementNamed('/main');
     }
   
     void _skipAction() {
       Navigator.of(context).pushReplacementNamed('/main');
     }
   
     void _adAction() {
       if (!(_splashBloc.currentState is SplashAdState)) {
         return;
       }
       SplashAdModel splashAdModel =
           (_splashBloc.currentState as SplashAdState).splashAdModel;
   
       Navigator.of(context).pushReplacementNamed('/main');
       NavigatorUtil.pushWeb(context,
           title: splashAdModel.title, url: splashAdModel.targetUrl);
     }
   
     @override
     void dispose() {
       _splashBloc.dispose();
       super.dispose();
     }
   }
   ```

   

8. APP入口定义SplashPage的使用。

   ```dart
   class MyApp extends StatelessWidget {
     // This widget is the root of your application.
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'Flutter Demo',
         theme: ThemeData(
           primarySwatch: Colors.blue,
         ),
         routes: {
           '/main': (ctx) => CounterPage(),
         },
         home: SplashPage(),
       );
     }
   }
   ```

   

9. Splash共通组件： SplashGuidePage、SplashADPage，构建对应具体画面布局和内容显示。代码请直接查看Github。

   

10. 结论： 在整体上，使用Bloc架构、包括SP本地存储、HTTP API远程访问在一起的Splash实现，整体组件隔离还是相当清晰简单的。

   