import './http_dio.dart';
import 'package:flutterpoc/models/index.dart';

class SplashApi {
  //Online JSON REST mock server, all data is in db.json 
  static const String splash_base_url =
      'https://my-json-server.typicode.com/dragonetail/flutterpoc';

  static Future<SplashModel> getSplashMode() async {
    {
      try {
        Response response = await dio.get(
          splash_base_url + '/splash',
          //queryParameters: {"id": 12, "name": "wendu"},
          options: expectHttpOK,
        );
        print(response.data);
        return SplashModel.fromJson(response.data);
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
