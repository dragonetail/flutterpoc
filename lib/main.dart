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
        '/Main': (ctx) => CounterPage(),
        '/Login': (ctx) => LoginPage(),
        '/Signup': (ctx) => SignupAndResetPasswordPage(isSignup: true),
        '/ResetPassword': (ctx) => SignupAndResetPasswordPage(isSignup: false),
        '/Splash': (ctx) => SplashPage(),
      },
      home: SplashPage(),
    );
  }
}
