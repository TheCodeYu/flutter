import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:secret/configs/data/app.dart';

import 'global_config.dart';

/// description:全局共享状态类
///
/// user: yuzhou
/// date: 2021/6/10

///继承[ChangeNotifier] ,保存状态并通知所订阅的组件进行更新
class ProfileChangeNotifier extends ChangeNotifier {
  App get _application => GlobalConfig.application;

  //app是否第一次使用
  bool get isFirst => _application.firstUse;

  @override
  void notifyListeners() {
    GlobalConfig.saveAppProfile();
    super.notifyListeners();
  }
}

///[ApplicationData]
///
class ApplicationData extends ProfileChangeNotifier {
  Color get theme => Color(_application.theme.toInt());

  String get themeMode => _application.themeMode;

  //主题模式处理
  ThemeMode getThemeMode() {
    //获取主题模式的字符串模式
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  void setThemeMode(String theme) {
    if (themeMode != theme) {
      _application.themeMode = theme;
      notifyListeners();
    }
  }

  //主题色处理，可以更精细的控制
  getTheme({bool isDarkMode: false}) {
    return ThemeData(
      errorColor: isDarkMode ? Color(0xFFE03E4E) : Color(0xFFFF4759),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Colors.black : theme,
      accentColor: isDarkMode ? Color(0xFF3F7AE0) : Color(0xFF4688FA),
      // // Tab指示器颜色
      // indicatorColor: isDarkMode ? Styles.dark_app_main : Styles.app_main,
      // // 页面背景色
      // scaffoldBackgroundColor:
      //     isDarkMode ? Styles.dark_bg_color : Colors.white,
      // // 主要用于Material背景色
      // canvasColor: isDarkMode ? Styles.dark_material_bg : Colors.white,
      // // 文字选择色（输入框复制粘贴菜单）
      // textSelectionColor: Styles.app_main.withAlpha(70),
      // textSelectionHandleColor: Styles.app_main,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        //color: isDarkMode ? Styles.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // dividerTheme: DividerThemeData(
      //     color: isDarkMode ? Styles.dark_line : Styles.line,
      //     space: 0.6,
      //     thickness: 0.6)
    );
  }

  void setTheme(Color color) {
    if (color != theme) {
      _application.theme = color.value;
      notifyListeners();
    }
  }

  Locale? getLocale() {
    if (!(LocaleNamesLocalizationsDelegate.nativeLocaleNames
        .containsKey(_application.locale))) return null; //null表示语言跟随系统
    var t = List.generate(3, (_) => '');
    var i = 0;
    _application.locale.split('_').forEach((element) {
      t[i++] = element;
    });
    return Locale.fromSubtags(
        languageCode: t[0],
        scriptCode: t[1] == '' ? null : t[1],
        countryCode: t[2] == '' ? null : t[2]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _application.locale;

  void setLocale(String locale) {
    if (locale != _application.locale) {
      _application.locale = locale;
      notifyListeners();
    }
  }

  //app是否处于已登陆
  String get isLogin => _application.token;

  set isLogin(String token) {
    _application.token = token;
    notifyListeners();
  }
}
