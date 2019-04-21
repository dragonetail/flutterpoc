import './splash_ad_model.dart';
import './splash_guide_model.dart';

class Splash {
  String version;
  bool nextShowGuide;
  bool updateGuideInfo;
  bool updateAdInfo;
  SplashGuide guideInfo;
  SplashAd adInfo;

  Splash(
      {this.version,
      this.nextShowGuide,
      this.updateGuideInfo,
      this.updateAdInfo,
      this.guideInfo,
      this.adInfo});

  Splash.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        nextShowGuide = json['nextShowGuide'],
        updateGuideInfo = json['updateGuideInfo'],
        updateAdInfo = json['updateAdInfo'],
        guideInfo = json['guideInfo'] == null
            ? null
            : SplashGuide.fromJson(json['guideInfo']),
        adInfo = json['adInfo'] == null
            ? null
            : SplashAd.fromJson(json['adInfo']);

  Map<String, dynamic> toJson() => {
        'version': version,
        'nextShowGuide': nextShowGuide,
        'updateGuideInfo': updateGuideInfo,
        'updateAdInfo': updateAdInfo,
        'guideInfo': guideInfo?.toJson(),
        'adInfo': adInfo?.toJson(),
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"version\":\"$version\"");
    sb.write("\"nextShowGuide\":\"$nextShowGuide\"");
    sb.write(",\"updateGuideInfo\":\"$updateGuideInfo\"");
    sb.write(",\"updateAdInfo\":\"$updateAdInfo\"");
    sb.write(",\"guideInfo\":\"$guideInfo\"");
    sb.write(",\"adInfo\":\"$adInfo\"");
    sb.write('}');
    return sb.toString();
  }
}
