import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:secret/api/system/login.dart';
import 'package:secret/components/all/click_item.dart';
import 'package:secret/components/all/personal.dart';
import 'package:secret/components/all/title_view.dart';
import 'package:secret/components/app_bar/app_bar.dart' as MyAppBar;
import 'package:secret/configs/global_config.dart';
import 'package:secret/configs/rx_config.dart';
import 'package:secret/core/base_widget.dart';
import 'package:secret/model/user.dart';
import 'package:secret/pages/owner/settings_page.dart';

import '../login.dart';

/// description: 个人主页，应用设置页
///
/// user: yuzhou
/// date: 2021/6/14

class Owner extends StatefulWidget {
  const Owner({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner>
    with TickerProviderStateMixin, BaseWidget {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  User? user;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void addAllListData() {
    const int count = 5;
    listViews.clear();
    listViews.add(
      TitleView(
        titleTxt: locale(context).user_info,
        subTxt: locale(context).update,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        // child: Icon(
        //   Icons.arrow_forward,
        //   //color: FitnessAppTheme.darkText,
        //   size: 18,
        // ),
        callback: () {},
      ),
    );
    listViews.add(
      Personal(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        padding: dp(12.0),
        user: user,
        onPress: () async {
          await getData();
        },
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: locale(context).server,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
        // child: Icon(
        //   Icons.arrow_forward,
        //   //color: FitnessAppTheme.darkText,
        //   size: 18,
        // ),
        callback: () {},
      ),
    );

    listViews.add(SizedBox(
      height: dp(20),
    ));
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).setting,
          style: TextStyle(fontSize: 18),
          child: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pushNamed(SettingPage.defaultRoute,
                arguments: {"animationController": widget.animationController});
          },
          padding: dp(15.0),
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 3, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: 'exit',
          style: TextStyle(fontSize: 18),
          child: Icon(Icons.chevron_right),
          onTap: () async {
            // print('logout:${await logout()}');
            GlobalConfig.setToken('');
            rx.push('bottom_bar', data: 0);

            ///[fixed] 修复退出登陆界面，BottonBar定位不对
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginPage.defaultRoute, (Route<dynamic> route) => false);
          },
          padding: dp(15.0),
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 4, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getMainListViewUI(),
          MyAppBar.AppBar(
              animationController: widget.animationController,
              scrollController: scrollController,
              children: [
                CachedNetworkImage(
                  imageUrl: dio.options.baseUrl + (user?.avatar ?? ''),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => IconButton(
                      iconSize: dp(75),
                      onPressed: () {},
                      icon: Image.asset(
                        'images/init_icon.png',
                      )),
                ),
              ],
              title: locale(context).my),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  getData() async {
    var r = await getInfo();
    if (r['user'] is Map) {
      user = User.fromJson(r['user']);
      log("info:${user.toString()}");
    }
    // r = await getRouters();
    // log("router:$r");
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    setState(() {});
  }

  Widget getMainListViewUI() {
    addAllListData();

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            dp(75),
        bottom: dh(64) + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController.forward();
        return listViews[index];
      },
    );
  }
}
