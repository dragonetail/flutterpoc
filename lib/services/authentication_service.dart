import 'dart:convert';

import 'package:local_auth/local_auth.dart';
import 'package:flutterpoc/data/beans.dart';
import 'package:flutterpoc/common/index.dart';
// import 'package:uuid/uuid.dart';

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

    // var uuid = new Uuid();
    // User _newUser = await getInfo(uuid.v4().toString());


  static Future<bool>  biometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
    return authenticated;
  }
}
