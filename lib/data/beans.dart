import 'package:json_annotation/json_annotation.dart';

part 'beans.g.dart';

@JsonSerializable()
class User {
  int id;
  String firstname;
  String lastname;
  String avatar;
  String token;

  User({
    this.token,
    this.avatar,
    this.firstname,
    this.id,
    this.lastname,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstname $lastname".toString();
  }
}

@JsonSerializable()
class Settings {
  bool rememberMe = false;
  bool stayLoggedIn= false;
  bool useBio= false;

  Settings({
    this.rememberMe,
    this.stayLoggedIn,
    this.useBio,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  @override
  String toString() {
    return "$rememberMe $stayLoggedIn".toString();
  }
}

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
