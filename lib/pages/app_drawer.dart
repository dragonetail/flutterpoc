import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Drawer(
      child: SafeArea(
        // color: Colors.grey[50],
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                '微笑卡卡西',
                //_auth.user.firstname + " " + _auth.user.lastname,
                textScaleFactor: 1.0,
                maxLines: 1,
              ),
              subtitle: Text(
                '微笑卡卡西',
                //_auth.user.id.toString(),
                textScaleFactor: 1.0,
                maxLines: 1,
              ),
              // onTap: () {
              //   Navigator.of(context).popAndPushNamed("/myaccount");
              // },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "What's New",
                textScaleFactor: 1.0,
              ),
              onTap: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WhatsNewPage.changelog(
                          title: Text(
                            "更新履历",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              // Text Style Needed to Look like iOS 11
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          buttonText: Text(
                            '返回',
                            textScaleFactor: 1.0,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                textScaleFactor: 1.0,
              ),
              onTap: () {
                Navigator.of(context).popAndPushNamed("/settings");
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                'Logout',
                textScaleFactor: 1.0,
              ),
              onTap: () => null, //_auth.logout(),
            ),
          ],
        ),
      ),
    );
  }
}
