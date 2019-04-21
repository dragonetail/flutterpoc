import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 存储安全的内容到本地设备
/// https://pub.dartlang.org/packages/flutter_secure_storage
/// 注意： 需要设置安卓的最小依赖版本。minSdkVersion 18
/// SsUtils ssUtils = SsUtils();
/// or SsUtils ssUtils = SsUtils.instance;
class SsUtils {
  //单体实例
  static final SsUtils _singleton = new SsUtils._internal();

  //工厂模式 和 静态实例
  factory SsUtils() => _singleton;
  static SsUtils get instance => _singleton;

  FlutterSecureStorage _secureStorage;
  //私有构造
  SsUtils._internal() {
    _secureStorage = new FlutterSecureStorage();
  }

  Future<void> write({@required String key, @required String value}) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<String> read({@required String key}) {
    return _secureStorage.read(key: key);
  }

  Future<Map<String, String>> readAll({@required String key}) {
    return _secureStorage.readAll();
  }

  Future<void> delete({@required String key}) {
    return _secureStorage.delete(key: key);
  }

  Future<void> deleteAll({@required String key}) {
    return _secureStorage.deleteAll();
  }
}
