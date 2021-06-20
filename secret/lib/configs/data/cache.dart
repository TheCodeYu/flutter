import 'package:json_annotation/json_annotation.dart';

part 'cache.g.dart';

/// description:网络缓存配置
///
/// user: yuzhou
/// date: 2021/6/16

@JsonSerializable()
class CacheConfig {
  CacheConfig();

  //是否开启缓存配置
  bool enable = true;
  //缓存过期时间
  num maxAge = 3600;
  //缓存最大条目
  num maxCount = 100;

  factory CacheConfig.fromJson(Map<String, dynamic> json) =>
      _$CacheConfigFromJson(json);
  Map<String, dynamic> toJson() => _$CacheConfigToJson(this);

  @override
  String toString() {
    return 'CacheConfig{enable: $enable, maxAge: $maxAge, maxCount: $maxCount}';
  }
}
