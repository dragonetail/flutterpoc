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
