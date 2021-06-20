import 'dart:convert';

import 'package:secret/configs/data/app.dart';
import 'package:secret/utils/log.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// description:全局配置类
///
/// user: yuzhou
/// date: 2021/6/7

class GlobalConfig {
  static late SharedPreferences _prefs;

  //应用配置
  static App application = App();

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  ///进入应用前进行全局初始化
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();

    ///1.读取应用配置,之后应用配置可以发送到后台留存

    var _profile = _prefs.getString("application");

    if (_profile != null) {
      try {
        application = App.fromJson(jsonDecode(_profile));
        Log.info('application', application.toString());
      } catch (e) {
        Log.error('global_config-App', e.toString());
      }
    }

    ///2.初始化网络请求相关配置
    ///3.数据库配置
  }

  ///持久化profile信息
  static saveAppProfile() =>
      _prefs.setString('application', jsonEncode(application.toJson()));
}
