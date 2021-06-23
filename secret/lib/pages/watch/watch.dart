import 'package:flutter/material.dart';
import 'package:secret/components/all/click_item.dart';
import 'package:secret/components/app_bar/app_bar.dart' as MyAppBar;
import 'package:secret/core/base_widget.dart';

/// description: 系统监控
///
/// user: yuzhou
/// date: 2021/6/23

class Watch extends StatefulWidget {
  const Watch({Key? key, required this.animationController}) : super(key: key);
  final AnimationController animationController;
  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch>
    with TickerProviderStateMixin, BaseWidget {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  void addAllListData() {
    const int count = 9;
    listViews.clear();
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).user,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.person),
          onTap: () async {
            // // print('logout:${await logout()}');
            // GlobalConfig.setToken('');
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //     LoginPage.defaultRoute, (Route<dynamic> route) => false);
          },
          padding: dp(30.0),
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 0, 1.0,
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
            title: locale(context).watch,
            children: [Icon(Icons.computer_outlined)],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget getMainListViewUI() {
    addAllListData();
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            dh(50),
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
