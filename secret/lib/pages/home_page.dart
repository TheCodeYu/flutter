import 'package:flutter/material.dart';
import 'package:secret/core/base_widget.dart';

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
    with TickerProviderStateMixin, WidgetsBindingObserver, BaseWidget {
  late AnimationController animationController;

  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          print(snapshot.toString());
          if (snapshot.data == null) {
            return const SizedBox();
          } else {
            return Stack(
              children: [
                tabBody,
                //bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    print(await requestAllPermission());
    return true;
  }

  ///[todo] 实现类似淘宝复制黏贴指令，进来就读取粘贴板
  @override //inactive->paused->inactive->resumed
  void didChangeAppLifecycleState(AppLifecycleState state) {
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

  // Widget bottomBar() {
  //   return Column(
  //     children: <Widget>[
  //       const Expanded(
  //         child: SizedBox(),
  //       ),
  //       BottomBarView(
  //         tabIconList: tabIconList,
  //         addClick: () {
  //           print('dsd');
  //         },
  //         changeIndex: (int index) {
  //           if (index == 0 || index == 2) {
  //             animationController.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 tabBody =
  //                     SecretPage(animationController: animationController);
  //               });
  //             });
  //           } else if (index == 1 || index == 3) {
  //             animationController.reverse().then<dynamic>((data) {
  //               if (!mounted) {
  //                 return;
  //               }
  //               setState(() {
  //                 tabBody =
  //                     SecretPage(animationController: animationController);
  //               });
  //             });
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }
}
