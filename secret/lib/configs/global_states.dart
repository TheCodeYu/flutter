import 'package:flutter/material.dart';
import 'package:secret/model/app.dart';

import 'global_config.dart';

/// description:全局共享状态类
///
/// user: yuzhou
/// date: 2021/6/10

///继承[ChangeNotifier] ,保存状态并通知所订阅的组件进行更新
class ProfileChangeNotifier extends ChangeNotifier {
  App get _application => GlobalConfig.application;

  //app是否第一次使用
  bool? get isFirst => _application.firstUse;

  @override
  void notifyListeners() {
    // GlobalConfig.saveAppProfile();
    super.notifyListeners();
  }
}

///[LocaleModel]
///
/// 语言配置
class LocaleModel extends ProfileChangeNotifier {
  Locale? getLocale() {
    if (_application.locale == null) return null; //null表示语言跟随系统
    var t = _application.locale!.split('_');
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String? get locale => _application.locale;

  void setLocale(String locale) {
    if (locale != _application.locale) {
      _application.locale = locale;
      notifyListeners();
    }
  }
}
