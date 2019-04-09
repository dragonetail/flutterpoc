import 'dart:async';
import 'package:flutter/material.dart';
export 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterpoc/common/index.dart';

class SplashADPage extends StatefulWidget {
  SplashADPage({
    Key key,
    this.adImageUrl,
    this.skipActionTitle,
    this.skipAction,
    this.adAction,
    this.logoImagePath,
    this.count = 3,
  }) : super(key: key);

  final String adImageUrl;
  final String skipActionTitle;
  final Function skipAction;
  final Function adAction;
  final int count;
  final String logoImagePath;

  @override
  _SplashADPageState createState() => _SplashADPageState();
}

class _SplashADPageState extends State<SplashADPage> {
  int _count = 3;
  Timer _timer;

  @override
  void initState() {
    super.initState();

    const duration = const Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_count == 1) {
        timer.cancel();
        this.widget.skipAction();
        return;
      }

      setState(() {
        _count--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildAdWidget(),
          _buildSplash(),
        ],
      ),
    );
  }

  Widget _buildAdWidget() {
    return new InkWell(
      onTap: () {
        _timer.cancel();
        this.widget.adAction();
      },
      child: new Container(
        alignment: Alignment.center,
        child: ImageUtils.imageWidgets(
          this.widget.adImageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildSplash() {
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: 90,
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            new Center(
              child: ImageUtils.imageWidgets(
                this.widget.logoImagePath,
                width: 120,
                height: 90,
              ),
            ),
            _buildCountDown()
          ],
        ),
      ),
    );
  }

  Widget _buildCountDown() {
    return new Align(
      alignment: Alignment.bottomRight,
      child: new InkWell(
        onTap: () {
          _timer.cancel();
          this.widget.skipAction();
        },
        child: new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(12),
          child: new RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(children: <TextSpan>[
              new TextSpan(
                  style: new TextStyle(fontSize: 14, color: Colors.orange),
                  text: "$_count"),
              new TextSpan(
                  style: new TextStyle(fontSize: 12, color: Color(0xFF666666)),
                  text: " ${this.widget.skipActionTitle}")
            ]),
          ),
          height: 30,
          width: 60,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              border: new Border.all(width: 0.33, color: Color(0xffcccccc))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
