import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutterpoc/common/index.dart';
import 'package:flutterpoc/pages/index.dart';

import 'package:flutterpoc/api/index.dart';

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  await SplashApi.getSplashMode();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/Main': (ctx) => CounterPage(),
      },
      // home: CounterPage(),
      home: SplashPage(),
    );
  }
}
