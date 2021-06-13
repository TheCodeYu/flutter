// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

App _$AppFromJson(Map<String, dynamic> json) {
  return App()
    ..firstUse = json['firstUse'] as bool?
    ..theme = json['theme'] as num?
    ..themeMode = json['themeMode'] as String?
    ..locale = json['locale'] as String?;
}

Map<String, dynamic> _$AppToJson(App instance) => <String, dynamic>{
      'firstUse': instance.firstUse,
      'theme': instance.theme,
      'themeMode': instance.themeMode,
      'locale': instance.locale,
    };
