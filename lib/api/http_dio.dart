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

    //  (super.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //      (client) {
    //    client.findProxy = (uri) {
    //      //proxy to my PC(charles)
    //      return "PROXY 10.1.10.250:8888";
    //    };
    //  };
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
