// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Splash _$SplashFromJson(Map<String, dynamic> json) {
  return Splash(
      version: json['version'] as String,
      nextShowGuide: json['nextShowGuide'] as bool,
      updateGuide: json['updateGuide'] as bool,
      updateAd: json['updateAd'] as bool,
      guide: json['guide'] == null
          ? null
          : SplashGuide.fromJson(json['guide'] as Map<String, dynamic>),
      ad: json['ad'] == null
          ? null
          : SplashAd.fromJson(json['ad'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SplashToJson(Splash instance) => <String, dynamic>{
      'version': instance.version,
      'nextShowGuide': instance.nextShowGuide,
      'updateGuide': instance.updateGuide,
      'updateAd': instance.updateAd,
      'guide': instance.guide,
      'ad': instance.ad
    };

SplashAd _$SplashAdFromJson(Map<String, dynamic> json) {
  return SplashAd(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      targetUrl: json['targetUrl'] as String);
}

Map<String, dynamic> _$SplashAdToJson(SplashAd instance) => <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'targetUrl': instance.targetUrl
    };

SplashGuide _$SplashGuideFromJson(Map<String, dynamic> json) {
  return SplashGuide(
      isUrl: json['isUrl'] as bool,
      images: (json['images'] as List)?.map((e) => e as String)?.toList(),
      texts: (json['texts'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$SplashGuideToJson(SplashGuide instance) =>
    <String, dynamic>{
      'isUrl': instance.isUrl,
      'images': instance.images,
      'texts': instance.texts
    };

TempModel _$TempModelFromJson(Map<String, dynamic> json) {
  return TempModel(name: json['name'] as bool);
}

Map<String, dynamic> _$TempModelToJson(TempModel instance) =>
    <String, dynamic>{'name': instance.name};
