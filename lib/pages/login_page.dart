import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterpoc/common/index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginData {
  String mobile = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _LoginData _data = _LoginData();

  @override
  void initState() {
    super.initState();
  }

  void submit() {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the login data.');
      print('Email: ${_data.mobile}');
      print('Password: ${_data.password}');

      Navigator.of(context).pushReplacementNamed('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: ListView(
        shrinkWrap: true,
        reverse: false,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: TextFormField(
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
                                maxLength: 11,
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
                              child: TextFormField(
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
                                maxLength: 16,
                                //键盘展示为号码
                                keyboardType: TextInputType.text,
                                validator: Validator.validatePassword,
                                onSaved: (String value) {
                                  this._data.password = value;
                                },
                              ),
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
                                      "登录",
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
          Padding(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text(
                          "新账号注册",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/resetPassword');
                        },
                        child: Text(
                          "忘记密码?",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 30.0, right: 20.0, top: 50.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "使用第三方账号直接登录：",
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/images/icon/wechat.svg",
                        width: 28, height: 28),
                    label: Text(
                      "微信登录",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Color(0xFF54C5F8),
                    textColor: Colors.white,
                    elevation: 5.0,
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Expanded(
                  flex: 1,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {},
                    icon: Image.asset("assets/images/icon/alipay.png",
                        width: 28, height: 28),
                    // Icon(Icons.add_shopping_cart),
                    label: Text(
                      "支付宝登录",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Color(0xFF54C5F8),
                    textColor: Colors.white,
                    elevation: 5.0,
                  ),
                ),
              ],
            ),
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
