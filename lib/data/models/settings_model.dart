import 'package:scoped_model/scoped_model.dart';

import '../beans.dart';
import 'package:flutterpoc/services/index.dart';

class SettingsModel extends Model {
  Settings _settings;

  void load() async {
    _settings = SettingsService.getSettings();

    notifyListeners();
  }

  Settings get settings => _settings;

  // bool get rememberMe => _settings.rememberMe;
  void updateRememberMe(bool value) {
    _settings.rememberMe = value;
    _notifyAndUpdaeSp();
  }

  // bool get isBioSetup => _settings.useBio;
  void updateIsBioSetup(bool value) {
    _settings.useBio = value;
    _notifyAndUpdaeSp();
  }

  // bool get stayLoggedIn => _settings.stayLoggedIn;
  void updateStayLoggedIn(bool value) {
    _settings.stayLoggedIn = value;
    _notifyAndUpdaeSp();
  }

  void _notifyAndUpdaeSp() {
    notifyListeners();
    SettingsService.updateSettings(settings: _settings);
  }
}
