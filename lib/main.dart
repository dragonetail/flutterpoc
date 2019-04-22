import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/pages/index.dart';
// import 'package:flutter/rendering.dart';


void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  // debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/main': (ctx) => HomePage(),
        '/Login': (ctx) => LoginPage(),
        '/signup': (ctx) => SignupAndResetPasswordPage(isSignup: true),
        '/resetPassword': (ctx) => SignupAndResetPasswordPage(isSignup: false),
        '/splash': (ctx) => SplashPage(),
        "/settings": (ctx) => SettingsPage(),
      },
      home: HomePage(),
    );
  }
}
