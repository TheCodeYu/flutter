import 'dart:collection';

import 'package:collection/collection.dart' show compareAsciiUpperCase;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:secret/components/all/click_item.dart';
import 'package:secret/components/app_bar/app_bar.dart' as MyAppBar;
import 'package:secret/components/options_item/options_item.dart';
import 'package:secret/configs/global_states.dart';
import 'package:secret/core/base_widget.dart';

/// description:设置界面
///
/// user: yuzhou
/// date: 2021/6/14

enum _ExpandableSetting {
  textScale,
  textDirection,
  locale,
  platform,
  theme,
}

class SettingPage extends StatefulWidget {
  static const String defaultRoute = '/setting';

  final arguments;
  const SettingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with TickerProviderStateMixin, BaseWidget {
  final ScrollController scrollController = ScrollController();
  late final AnimationController animationController;

  _ExpandableSetting? _expandedSettingId;
  String _packageInfo = "";
  void onTapSetting(_ExpandableSetting settingId) {
    setState(() {
      if (_expandedSettingId == settingId) {
        _expandedSettingId = null;
      } else {
        _expandedSettingId = settingId;
      }
    });
  }

  void _closeSettingId(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      setState(() {
        _expandedSettingId = null;
      });
    }
  }

  @override
  void initState() {
    animationController = widget.arguments['animationController'];
    animationController.addStatusListener(_closeSettingId);

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      _packageInfo = packageInfo.version;
      //String buildNumber = packageInfo.buildNumber;

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_closeSettingId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<ApplicationData>(
      builder: (context, app, child) {
        return Stack(children: [
          getMainListViewUI(context, app),
          MyAppBar.AppBar(
            animationController: animationController,
            scrollController: scrollController,
            left: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            title: locale(context).setting,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ]);
      },
    ));
  }

  /// Given a [Locale], returns a [DisplayOption] with its native name for a
  /// title and its name in the currently selected locale for a subtitle. If the
  /// native name can't be determined, it is omitted. If the locale can't be
  /// determined, the locale code is used.
  DisplayOption _getLocaleDisplayOption(BuildContext context, Locale locale) {
    // TODO: gsw, fil, and es_419 aren't in flutter_localized_countries' dataset
    final localeCode = locale.toString();
    final localeName = LocaleNames.of(context)!.nameOf(localeCode);
    if (localeName != null) {
      final localeNativeName =
          LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeCode];
      return localeNativeName != null
          ? DisplayOption(localeNativeName, subtitle: localeName)
          : DisplayOption(localeName);
    } else {
      switch (localeCode) {
        case 'gsw':
          return DisplayOption('Schwiizertüütsch', subtitle: 'Swiss German');
        case 'fil':
          return DisplayOption('Filipino', subtitle: 'Filipino');
        case 'es_419':
          return DisplayOption(
            'español (Latinoamérica)',
            subtitle: 'Spanish (Latin America)',
          );
      }
    }

    return DisplayOption(localeCode);
  }

  /// Create a sorted — by native name – map of supported locales to their
  /// intended display string, with a system option as the first element.
  LinkedHashMap<Locale, DisplayOption> _getLocaleOptions(ApplicationData app) {
    var localeOptions = LinkedHashMap<Locale, DisplayOption>.of({
      //Locale('system'): DisplayOption(locale(context).auto),
    });
    var supportedLocales = List<Locale>.from(AppLocalizations.supportedLocales);

    final displayLocales = Map<Locale, DisplayOption>.fromIterable(
      supportedLocales,
      value: (dynamic locale) =>
          _getLocaleDisplayOption(context, locale as Locale),
    ).entries.toList()
      ..sort((l1, l2) => compareAsciiUpperCase(l1.value.title, l2.value.title));

    localeOptions.addAll(LinkedHashMap.fromEntries(displayLocales));
    return localeOptions;
  }

  getMainListViewUI(BuildContext context, ApplicationData app) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),

      ///夹住模式
      controller: scrollController,
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
              height: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top),
          ListTile(
            subtitle: Text(locale(context).general),
          ),
          AnimateSettingsListItems(animation: animationController, children: [
            OptionsListItem<Locale>(
                optionsMap: _getLocaleOptions(app),
                title: locale(context).language,
                selectedOption: app.getLocale()!,
                onOptionChanged: (e) {
                  //app.setLocale('Auto');
                  app.setLocale(e.toString());
                },
                onTap: () => onTapSetting(_ExpandableSetting.locale),
                isExpanded: _expandedSettingId == _ExpandableSetting.locale)
          ]),
          AnimateSettingsListItems(animation: animationController, children: [
            OptionsListItem<ThemeMode>(
                optionsMap: LinkedHashMap.of({
                  ThemeMode.system: DisplayOption(locale(context).system),
                  ThemeMode.dark: DisplayOption(
                    locale(context).dark,
                  ),
                  ThemeMode.light: DisplayOption(
                    locale(context).light,
                  ),
                }),
                title: locale(context).themeMode,
                selectedOption: app.getThemeMode(),
                onOptionChanged: (e) {
                  app.setThemeMode(e.toString().split('.')[1]);
                },
                onTap: () => onTapSetting(_ExpandableSetting.theme),
                isExpanded: _expandedSettingId == _ExpandableSetting.theme)
          ]),
          ListTile(
            subtitle: Text(locale(context).privacy),
          ),
          MergeSemantics(
            child: ClickItem(
              title: locale(context).privacy1,
              style: TextStyle(fontSize: 18.0),
              content: locale(context).go,
              child: Icon(Icons.chevron_right),
              onTap: openAppSettings,
            ),
          ),
          MergeSemantics(
            child: ClickItem(
              title: locale(context).storage,
              style: TextStyle(fontSize: 18.0),
              content: locale(context).go1,
              child: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pushNamed('/storage');
              },
            ),
          ),
          ListTile(
            subtitle: Text(locale(context).app_info),
          ),
          MergeSemantics(
            child: ClickItem(
              title: locale(context).feed,
              style: TextStyle(fontSize: 18.0),
              child: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          MergeSemantics(
            child: ClickItem(
              title: locale(context).about,
              style: TextStyle(fontSize: 18.0),
              content: locale(context).version(_packageInfo),
              child: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom * 2,
          ),
          ListTile(
            subtitle: Text(
              'Copyright © 2020 Mychip. All Rights Reserved.',
              textAlign: TextAlign.center,
            ),
          ),
          // SettingsAttribution(
          //   settingsAttribution: locale(context).go,
          // ),
        ]))
      ],
    );
  }
}

class SettingsAttribution extends StatelessWidget {
  final String settingsAttribution;

  const SettingsAttribution({Key? key, required this.settingsAttribution})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 32,
          end: 32,
          top: 28.0,
          bottom: 28.0,
        ),
        child: Text(
          settingsAttribution,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
