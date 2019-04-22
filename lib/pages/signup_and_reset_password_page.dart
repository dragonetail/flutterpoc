import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupAndResetPasswordPage extends StatefulWidget {
  final bool isSignup;

  SignupAndResetPasswordPage({Key key, this.isSignup}) : super(key: key);

  @override
  _SignupAndResetPasswordPageState createState() =>
      _SignupAndResetPasswordPageState();
}

class _SignupAndResetPasswordData {
  bool isSignup;
  String mobile = '';
  String verificationCode = '';
  String smsCode = '';
  String password = '';
}

class _SignupAndResetPasswordPageState extends State<SignupAndResetPasswordPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _SignupAndResetPasswordData _data = _SignupAndResetPasswordData();

  String _smsCodeSenderTitle = '发送验证码';
  int _count = 3;
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  void sendSmsCode() {
    if (_timer != null) {
      Fluttertoast.showToast(
          msg: "短信验证码已经发送，如果没有收到，请稍候再试。",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
      return;
    }

    _formKey.currentState.save(); // Save our form now.

    if (_data.verificationCode.length != 4) {
      //TODO 校验后台验证码的正确性

      Fluttertoast.showToast(
          msg: "请输入图片验证码（点击图片验证码可刷新）。",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3);
      return;
    }

    _count = 60;
    const duration = const Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_count == 1) {
        timer.cancel();
        setState(() {
          _smsCodeSenderTitle = '发送验证码';
        });
        _timer = null;
        return;
      }

      _count--;
      setState(() {
        _smsCodeSenderTitle = '剩余 $_count 秒';
      });
    });

    //TODO 请求后台发送短信验证码，可以考虑携带前一步校验验证码返回随机值，增强抗刷能力
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the SignupAndResetPassword data.');
      print('Email: ${_data.isSignup}');
      print('Email: ${_data.mobile}');
      print('Email: ${_data.verificationCode}');
      print('Email: ${_data.smsCode}');
      print('Password: ${_data.password}');

      // widget.isSignup? '注册':'重置密码'
      Navigator.of(context).pushReplacementNamed('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(widget.isSignup ? '注册' : '重置密码'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        shrinkWrap: true,
        reverse: false,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/3.0x/logo.png",
                    height: 150.0,
                    width: 210.0,
                    fit: BoxFit.scaleDown,
                  )
                ],
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Form(
                        key: this._formKey,
                        autovalidate: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: '请输入手机号',
                                labelText: '手机号',
                                prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 7.0),
                                    child: Image.asset(
                                      "assets/images/icon/account.png",
                                      height: 16.0,
                                      width: 16.0,
                                      fit: BoxFit.scaleDown,
                                    )),
                              ),
                              maxLines: 1,
                              // maxLength: 11,
                              //键盘展示为号码
                              keyboardType: TextInputType.phone,
                              //只能输入数字
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              validator: Validator.validateMobile,
                              onSaved: (String value) {
                                this._data.mobile = value;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0, top: 10.0, bottom: 0.0),
                              child: Row(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: '请输入图片校验码',
                                      labelText: '图片校验码',
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 7.0),
                                          child: Image.asset(
                                            "assets/images/icon/verification_code.png",
                                            height: 16.0,
                                            width: 16.0,
                                            fit: BoxFit.scaleDown,
                                          )),
                                    ),
                                    maxLines: 1,
                                    // maxLength: 4,
                                    //键盘展示为号码
                                    keyboardType: TextInputType.text,
                                    onSaved: (String value) {
                                      this._data.verificationCode = value;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7.0),
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: new BoxDecoration(
                                      border:
                                          new Border.all(color: Colors.grey)),
                                  child: Image.asset(
                                    "assets/images/3.0x/dummy_verification_code.png",
                                    height: 36.0,
                                    width: 100.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0, top: 10.0, bottom: 0.0),
                              child: Row(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: '请输入短信校验码',
                                      labelText: '短信校验码',
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 7.0),
                                          child: Image.asset(
                                            "assets/images/icon/sms_code.png",
                                            height: 16.0,
                                            width: 16.0,
                                            fit: BoxFit.scaleDown,
                                          )),
                                    ),
                                    maxLines: 1,
                                    // maxLength: 6,
                                    //键盘展示为号码
                                    keyboardType: TextInputType.phone,
                                    //只能输入数字
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly,
                                    ],
                                    validator: Validator.validateSmsCode,
                                    onSaved: (String value) {
                                      this._data.smsCode = value;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7.0),
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0)),
                                    onPressed: this.sendSmsCode,
                                    child: Text(
                                      this._smsCodeSenderTitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Color(0xFF54C5F8),
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    padding: EdgeInsets.only(
                                        left: 16.0,
                                        right: 16.0,
                                        top: 10.0,
                                        bottom: 10.0),
                                  ),
                                ),
                              ]),
                            ),
                            TextFormField(
                              obscureText: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: '请输入密码',
                                labelText: '密码',
                                prefixIcon: Padding(
                                    padding: EdgeInsets.only(right: 7.0),
                                    child: Image.asset(
                                      "assets/images/icon/password.png",
                                      height: 16.0,
                                      width: 16.0,
                                      fit: BoxFit.scaleDown,
                                    )),
                              ),
                              maxLines: 1,
                              // maxLength: 16,
                              //键盘展示为号码
                              keyboardType: TextInputType.text,
                              validator: Validator.validatePassword,
                              onSaved: (String value) {
                                this._data.password = value;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.0, top: 15.0, bottom: 0.0),
                              child: Row(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(0.0)),
                                    onPressed: this.submit,
                                    child: Text(
                                      widget.isSignup ? '注册' : '提交',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    color: Color(0xFF54C5F8),
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    padding: EdgeInsets.only(
                                        left: 80.0,
                                        right: 80.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
