class SplashGuideModel {
  bool isUrl;
  List<String> images;
  List<String> textInfos;

  SplashGuideModel({this.isUrl, this.images, this.textInfos});

  SplashGuideModel.fromJson(Map<String, dynamic> json)
      : isUrl = json['isUrl'],
        images = json['images'].cast<String>(),
        textInfos = json['textInfos'].cast<String>();

  Map<String, dynamic> toJson() => {
        'tiisUrltle': isUrl,
        'images': images,
        'textInfos': textInfos,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"isUrl\":\"$isUrl\"");
    sb.write(",\"images\":\"$images\"");
    sb.write(",\"textInfos\":\"$textInfos\"");
    sb.write('}');
    return sb.toString();
  }
}
