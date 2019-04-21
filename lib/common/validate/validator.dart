import 'package:validate/validate.dart';

//import 'package:fluttertoast/fluttertoast.dart';

class Validator {
  static String validateMobile(String mobile) {
    try {
      Validate.matchesPattern(mobile, new RegExp(
          //"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}\$"));
          "^(1)\\d{10}\$"));
    } catch (e) {
      // Fluttertoast.showToast(
      //     msg: "请输入手机号。",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIos: 1);
      return '请输入正确的手机号。';
    }

    return null;
  }

  static String validatePassword(String password) {
    try {
      Validate.matchesPattern(
          password,
          new RegExp(
              "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d\\\~\\\`\\\!\\\@\\\#\\\$\\\%\\\^\\\&\\\*\\\-\\\_\\\=\\\+\\\[\\\]\\\{\\\}\\\;\\\:\\\'\\\"\\\,\\\<\\\.\\\>\\\/\\\?\\\|\\\\]{8,15}\$"));
    } catch (e) {
      return '请输入正确的密码（字母数字组合8位以上）。';
    }

    return null;
  }


static String validateSmsCode(String smsCode) {
    try {
      Validate.matchesPattern(smsCode, new RegExp(
          "^\\d{6}\$"));
    } catch (e) {
      return '请输入正确的6位数字短信验证码。';
    }

    return null;
  }

}
