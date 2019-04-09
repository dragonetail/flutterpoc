class SplashAdModel {
  String title;
  String imageUrl;
  String targetUrl;

  SplashAdModel({this.title, this.imageUrl, this.targetUrl});

  SplashAdModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['imageUrl'],
        targetUrl = json['targetUrl'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'imageUrl': imageUrl,
        'targetUrl': targetUrl,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"title\":\"$title\"");
    sb.write(",\"imageUrl\":\"$imageUrl\"");
    sb.write(",\"targetUrl\":\"$targetUrl\"");
    sb.write('}');
    return sb.toString();
  }
}
