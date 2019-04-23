import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';

import '../beans.dart';
import 'package:flutterpoc/services/index.dart';

class AuthenticationModel extends Model {
  String errorMessage = "";

  User _user;
  User get user => _user;

  // void loadSettings() async {
  //   if (_stayLoggedIn) {
  //     User _savedUser;
  //     try {
  //       String _saved = _prefs.getString("user_data");
  //       print("Saved: $_saved");
  //       _savedUser = User.fromJson(json.decode(_saved));
  //     } catch (e) {
  //       print("User Not Found: $e");
  //     }
  //     if (_useBio) {
  //       if (await biometrics()) {
  //         _user = _savedUser;
  //       }
  //     } else {
  //       _user = _savedUser;
  //     }
  //   }
  //   notifyListeners();
  // }

  // Future<bool> biometrics() async {
  //   final LocalAuthentication auth = LocalAuthentication();
  //   bool authenticated = false;
  //   try {
  //     authenticated = await auth.authenticateWithBiometrics(
  //         localizedReason: 'Scan your fingerprint to authenticate',
  //         useErrorDialogs: true,
  //         stickyAuth: false);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return authenticated;
  // }



  // Future<User> getInfo(String token) async {
  //   try {
  //     var _data = await WebClient(User(token: token)).get(apiURL);
  //     // var _json = json.decode(json.encode(_data));
  //     var _newUser = User.fromJson(_data["data"]);
  //     _newUser?.token = token;
  //     return _newUser;
  //   } catch (e) {
  //     print("Could Not Load Data: $e");
  //     return null;
  //   }
  // }

  // Future<bool> login({
  //   @required String username,
  //   @required String password,
  // }) async {
  //   var uuid = new Uuid();
  //   String _username = username;
  //   String _password = password;

  //   // TODO: API LOGIN CODE HERE
  //   await Future.delayed(Duration(seconds: 3));
  //   print("Logging In => $_username, $_password");

  //   if (_rememberMe) {
  //     SharedPreferences.getInstance().then((prefs) {
  //       prefs.setString("saved_username", _username);
  //     });
  //   }

  //   // Get Info For User
  //   User _newUser = await getInfo(uuid.v4().toString());
  //   if (_newUser != null) {
  //     _user = _newUser;
  //     notifyListeners();

  //     SharedPreferences.getInstance().then((prefs) {
  //       var _save = json.encode(_user.toJson());
  //       print("Data: $_save");
  //       prefs.setString("user_data", _save);
  //     });
  //   }

  //   if (_newUser?.token == null || _newUser.token.isEmpty) return false;
  //   return true;
  // }

  // Future<void> logout() async {
  //   _user = null;
  //   notifyListeners();
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setString("user_data", null);
  //   });
  //   return;
  // }
}
