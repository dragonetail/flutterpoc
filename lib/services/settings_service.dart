import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:flutterpoc/data/beans.dart';
import 'package:flutterpoc/common/index.dart';

class SettingsService {
  static const String settings_key = 'settings.key';
  static final SpUtils spUtils = SpUtils.instance;

  static Settings getSettings() {
    String _settings = spUtils.getString(settings_key);
    if (CommonUtils.isNotEmpty(_settings)) {
      Map dataMap = json.decode(_settings);
      return Settings.fromJson(dataMap);
    }
    return Settings();
  }

  static void updateSettings({@required Settings settings}) {
    String _jsonStr = json.encode(settings.toJson());
    spUtils.putString(settings_key, _jsonStr);
  }
}
