// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

App _$AppFromJson(Map<String, dynamic> json) {
  return App()
    ..firstUse = json['firstUse'] as bool
    ..theme = json['theme'] as num
    ..themeMode = json['themeMode'] as String
    ..token = json['token'] as String
    ..locale = json['locale'] as String
    ..cacheConfig =
        CacheConfig.fromJson(json['cacheConfig'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AppToJson(App instance) => <String, dynamic>{
      'firstUse': instance.firstUse,
      'theme': instance.theme,
      'themeMode': instance.themeMode,
      'token': instance.token,
      'locale': instance.locale,
      'cacheConfig': instance.cacheConfig,
    };
