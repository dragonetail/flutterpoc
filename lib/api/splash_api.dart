import './http_dio.dart';
import 'package:flutterpoc/data/models.dart';

class SplashApi {
  //Online JSON REST mock server, all data is in db.json
  //具有1分钟数据缓存，测试需要等待数据刷新
  static const String splash_base_url =
      'https://my-json-server.typicode.com/dragonetail/flutterpoc';

  static Future<Splash> getSplashMode([String version = '']) async {
    {
      Response response = await dio.get(
        splash_base_url + '/splash',
        queryParameters: {"version": version},
        options: expectHttpOK,
      );
      print(response.data);
      return Splash.fromJson(response.data);
    }
  }
}
