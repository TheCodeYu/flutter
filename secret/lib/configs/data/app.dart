/// description:app 全局设置信息
/// flutter packages pub run json_model
/// user: yuzhou
/// date: 2021/6/10
import 'package:json_annotation/json_annotation.dart';

import 'cache.dart';

part 'app.g.dart';

///要有这条

@JsonSerializable()
class App {
  App();
  //是否第一次使用app
  bool firstUse = true;
  //主题色
  num theme = 0xffff5d23;
  //主题模式
  String themeMode = "system";
  //登陆用户的token
  String token = "";
  //国际化语言
  String locale = "zh_Hans_CN"; //
  //网络缓存配置
  CacheConfig cacheConfig = CacheConfig();

  factory App.fromJson(Map<String, dynamic> json) => _$AppFromJson(json);
  Map<String, dynamic> toJson() => _$AppToJson(this);

  @override
  String toString() {
    return 'App{firstUse: $firstUse, theme: $theme, themeMode: $themeMode, token: $token, locale: $locale, cacheConfig: $cacheConfig}';
  }
}
