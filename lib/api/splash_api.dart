import './http_dio.dart';
import 'package:flutterpoc/models/index.dart';

class SplashApi {
  static const String splash_base_url =
      'https://github.com/dragonetail/flutterpoc/tree/master/lib/mockdata/splash';

  static Future<SplashModel> getSplashMode() async {
    {
      try {
        Response response = await dio.get(
          splash_base_url + '/splash.json',
          //queryParameters: {"id": 12, "name": "wendu"},
          options: expectHttpOK,
        );
        print(response.data);
        return response.data as SplashModel;
      } on DioError catch (error) {
         print(error);
        return null;
      }
    }
  }

  // dio.post("http://10.1.10.250:3000",data:{"a":1}).then((r) {
  //   setState(() {
  //     _text = r.data.replaceAll(RegExp(r"\s"), "");
  //   });
  // }).catchError(print);
}
