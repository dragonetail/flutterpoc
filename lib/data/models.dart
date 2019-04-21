import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Splash {
  @JsonKey(name: 'version', nullable: true)
  String version;
  bool nextShowGuide;
  bool updateGuide;
  bool updateAd;
  SplashGuide guide;
  SplashAd ad;

  Splash(
      {this.version,
      this.nextShowGuide,
      this.updateGuide,
      this.updateAd,
      this.guide,
      this.ad});

  factory Splash.fromJson(Map<String, dynamic> json) => _$SplashFromJson(json);

  Map<String, dynamic> toJson() => _$SplashToJson(this);

  @override
  String toString() {
    return "$version $nextShowGuide".toString();
  }
}

@JsonSerializable()
class SplashAd {
  String title;
  String imageUrl;
  String targetUrl;

  SplashAd({this.title, this.imageUrl, this.targetUrl});

  factory SplashAd.fromJson(Map<String, dynamic> json) =>
      _$SplashAdFromJson(json);

  Map<String, dynamic> toJson() => _$SplashAdToJson(this);

  @override
  String toString() {
    return "$title $imageUrl $targetUrl".toString();
  }
}

@JsonSerializable()
class SplashGuide {
  bool isUrl;
  List<String> images;
  List<String> texts;

  SplashGuide({this.isUrl, this.images, this.texts});

  factory SplashGuide.fromJson(Map<String, dynamic> json) =>
      _$SplashGuideFromJson(json);

  Map<String, dynamic> toJson() => _$SplashGuideToJson(this);

  @override
  String toString() {
    return "$isUrl $images $texts".toString();
  }
}


@JsonSerializable()
class TempModel {
  bool name;

  TempModel({this.name});

  factory TempModel.fromJson(Map<String, dynamic> json) =>
      _$TempModelFromJson(json);

  Map<String, dynamic> toJson() => _$TempModelToJson(this);

  @override
  String toString() {
    return "$name".toString();
  }
}