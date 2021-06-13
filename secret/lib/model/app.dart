/// description:app q全局信息
///
/// user: yuzhou
/// date: 2021/6/10
import 'package:json_annotation/json_annotation.dart';

//import 'cache.dart';

part 'app.g.dart';

/// description: app配置属性
///
/// user: yuzhou
/// date: 2020/10/23

@JsonSerializable()
class App {
  App();

  //是否第一次使用app
  bool? firstUse;
  //主题色
  num? theme;
  //主题模式
  String? themeMode;
  //国际化语言
  String? locale;
  //网络缓存配置
  //CacheConfig cacheConfig;

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);
  Map<String, dynamic> toJson() => _$AppToJson(this);

  @override
  String toString() {
    return 'App{firstUse: $firstUse, theme: $theme, themeMode: $themeMode, locale: $locale, cacheConfig: }';
  }
}
