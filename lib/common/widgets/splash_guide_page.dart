import 'package:flutter/material.dart';
import 'package:flutterpoc/common/index.dart';

class SplashGuidePage extends StatefulWidget {
  SplashGuidePage(
      {Key key,
      this.isUrl,
      this.images,
      this.textInfos,
      this.nextActionTitle,
      this.nextAction})
      : super(key: key);

  final bool isUrl;
  final List<String> images;
  final List<String> textInfos;
  final String nextActionTitle;
  final Function nextAction;

  @override
  _SplashGuidePageState createState() => _SplashGuidePageState();
}

class _SplashGuidePageState extends State<SplashGuidePage> {
  List<Widget> _bannerList = new List();

  @override
  void initState() {
    super.initState();

    _initBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
          autoStart: false,
          circular: false,
          indicator: CircleSwiperIndicator(
              radius: 2,
              spacing: 4,
              padding: EdgeInsets.only(bottom: 32.0),
              itemColor: Colors.white,
              itemActiveColor: Color(0xfff5f5f5)),
          children: _bannerList),
    );
  }

  void _initBannerData() {
    for (int i = 0, length = this.widget.images.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            ImageUtils.imageWidgets(
              this.widget.images[i],
              fit: BoxFit.cover,
            ),
            new Center(
              child: new Text(
                this.widget.textInfos[i],
                style: new TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: new InkWell(
                  onTap: () {
                    this.widget.nextAction();
                  },
                  child: new Container(
                    width: 185,
                    alignment: Alignment.center,
                    height: 48.0,
                    child: new Text(
                      this.widget.nextActionTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Color(0X19FFFFFF),
                        border:
                            new Border.all(width: 0.33, color: Colors.white70)),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Stack(
          children: <Widget>[
            ImageUtils.imageWidgets(
              this.widget.images[i],
              fit: BoxFit.cover,
            ),
            new Center(
              child: new Text(
                this.widget.textInfos[i],
                style: new TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            )
          ],
        ));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
