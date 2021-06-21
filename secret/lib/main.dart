import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:secret/configs/global_config.dart';
import 'package:secret/configs/router_config.dart';

import 'configs/global_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  GlobalConfig.init().then((value) => runApp(MyApp()));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.dark,
    // statusBarBrightness:
    //     Platform.isAndroid ? Brightness.dark : Brightness.light,
    //systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.blueGrey,
    // systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        ///注册订阅内容
        providers: [
          ChangeNotifierProvider.value(value: ApplicationData()),
        ],
        child: ScreenUtilInit(
            designSize: Size(428, 926),
            builder: () {
              return Consumer<ApplicationData>(
                builder: (context, appData, child) {
                  return MaterialApp(
                    builder: (context, child) =>
                        FlutterSmartDialog(child: child),
                    debugShowCheckedModeBanner: false,
                    theme: appData.getTheme(),
                    darkTheme: appData.getTheme(isDarkMode: true),
                    themeMode: appData.getThemeMode(),
                    onGenerateTitle: (context) =>
                        AppLocalizations.of(context)!.app,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: [
                      LocaleNamesLocalizationsDelegate(),
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      const FallbackCupertinoLocalisationsDelegate(),
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: appData.getLocale(),
                    localeResolutionCallback:

                        /// [supportedLocales] : supportedLocales
                        ///iOS上语言表示不一样 [en_US, zh_CN]  zh_Hans_CN languageCode-scriptCode-countryCode
                        (Locale? _locale, Iterable<Locale>? supportedLocales) {
                      if (_locale != null) {
                        return _locale;
                      }

                      Locale locale = Locale.fromSubtags(
                          languageCode: 'zh',
                          scriptCode: 'Hans',
                          countryCode: 'CN'); //当APP不支持系统设置的语言时，设置默认语言
                      /// [todo]遍历系统选择的语言是否是支持的语言,去除了脚本代码，暂时没测会不会有问题,ios系统带了脚本代码
                      supportedLocales?.forEach((l) {
                        if ((l.countryCode == _locale?.countryCode) &&
                            (l.languageCode == _locale?.languageCode)) {
                          locale = Locale.fromSubtags(
                              languageCode: l.languageCode,
                              scriptCode: l.scriptCode,
                              countryCode: l.countryCode);
                        }
                      });
                      return locale;
                    },
                    //home: HomePage(),
                    onGenerateRoute: RouterConfig.onGenerateRoute,
                  );
                },
              );
            }));
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(locale);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}
