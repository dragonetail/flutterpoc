class SplashModel {
  bool nextShowGuide;
  bool updateGuideInfo;
  bool updateAdInfo;

  SplashModel({this.nextShowGuide, this.updateGuideInfo, this.updateAdInfo});

  SplashModel.fromJson(Map<String, dynamic> json)
      : nextShowGuide = json['nextShowGuide'],
        updateGuideInfo = json['updateGuideInfo'],
        updateAdInfo = json['updateAdInfo'];

  Map<String, dynamic> toJson() => {
        'nextShowGuide': nextShowGuide,
        'updateGuideInfo': updateGuideInfo,
        'updateAdInfo': updateAdInfo,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"nextShowGuide\":\"$nextShowGuide\"");
    sb.write(",\"updateGuideInfo\":\"$updateGuideInfo\"");
    sb.write(",\"updateAdInfo\":\"$updateAdInfo\"");
    sb.write('}');
    return sb.toString();
  }
}
