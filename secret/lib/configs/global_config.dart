import 'package:secret/model/app.dart';
//import 'package:shared_preferences/shared_preferences.dart';

/// description:全局配置类
///
/// user: yuzhou
/// date: 2021/6/7

class GlobalConfig {
  // static late SharedPreferences _prefs;

  //应用配置
  static App application = App();

  ///进入应用前进行全局初始化
  static Future init() async {
    //_prefs = await SharedPreferences.getInstance();
  }

  //持久化profile信息
  //static saveAppProfile() =>
  // _prefs.setString('application', jsonEncode(application.toJson()));
}
