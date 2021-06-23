import 'package:flutter/material.dart';
import 'package:secret/components/bottom_bar/bottom_bar.dart';
import 'package:secret/components/bottom_bar/tab_icons.dart';
import 'package:secret/configs/rx_config.dart';
import 'package:secret/pages/owner/ower.dart';
import 'package:secret/pages/system/system.dart';
import 'package:secret/pages/tools/tools.dart';
import 'package:secret/pages/watch/watch.dart';

import 'owner/permission_page.dart';

/// description:
///
/// user: yuzhou
/// date: 2021/6/12
class HomePage extends StatefulWidget {
  static const String defaultRoute = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController animationController;

  List<TabIcon> tabIconsList = TabIcon.tabIconsList;

  late PageController controller;
  @override
  void initState() {
    controller = PageController();

    getData();
    WidgetsBinding.instance!.addObserver(this);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this); //销毁
    animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///（FutureBuilder多次请求的原理是每次setState函数刷新，都会返回一个新的对象，如果可以对对象进行保存，就可以避免重复请求）
      ///FutureBuilder组件内置了setState函数，都会出发future请求从而对页面进行一次刷新
      ///只在页面第一次build的时候采用自动，页面不disposed的情况下不再自动获取数据，改为手动获取
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              print(index);
              rx.push('bottom_bar', data: index);
            },
            children: [
              System(
                animationController: animationController,
              ),
              Watch(
                animationController: animationController,
              ),
              Tools(
                animationController: animationController,
              ),
              Owner(animationController: animationController)
            ],
          ),
          bottomBar(),
        ],
      ),
      //bottomNavigationBar: bottomBar(),
    );
  }

  Future<bool> getData() async {
    await requestAllPermission();

    return true;
  }

  ///[todo] 实现类似淘宝复制黏贴指令，进来就读取粘贴板
  @override //inactive->paused->inactive->resumed
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("app_state:${state.toString()}");
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台//进到锁屏界面
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        break;
    }
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBar(
          tabIconsList: tabIconsList,
          addClick: () {
            ///Navigator.of(context).push(GradualChangeRoute(SencondPage()));
            // Navigator.of(context).push<void>(
            //   MaterialPageRoute<void>(
            //     builder: (BuildContext context) => const My(),
            //   ),
            // );

            ///Navigator.of(context).push<void>(GradualChangeRoute(My()));
            ///Navigator.of(context).push<void>(ZoomRoute(My()));  RotateAndZoomRoute
            ///Navigator.of(context).push<void>(RotateAndZoomRoute(My()));
            //Navigator.of(context).push<void>(SlidingAroundRoute(My()));
          },
          changeIndex: (int index) {
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              controller.jumpToPage(index);
            });
          },
        ),
      ],
    );
  }
}
