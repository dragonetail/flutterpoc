import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './index.dart';
import '../widgets/index.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page) {
    if (context == null || page == null) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushPageBody(BuildContext context,
      {String title, String titleId, Widget body}) {
    if (context == null || body == null) return;
    Navigator.push(
      context,
      CupertinoPageRoute<void>(
        builder: (ctx) => Scaffold(
              appBar: AppBar(
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF333333),
                  ),
                ),
                centerTitle: true,
              ),
              body: body,
            ),
      ),
    );
  }

  static void pushWeb(BuildContext context,
      {String title, String titleId, String url}) {
    if (context == null || CommonUtils.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
              builder: (ctx) => new WebScaffold(
                    title: title,
                    url: url,
                  )));
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void showDemoDialog<T>(BuildContext context, Widget child) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }
}
