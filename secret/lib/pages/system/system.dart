import 'package:flutter/material.dart';
import 'package:secret/components/all/click_item.dart';
import 'package:secret/components/app_bar/app_bar.dart' as MyAppBar;
import 'package:secret/core/base_widget.dart';

/// description: 系统管理
///
/// user: yuzhou
/// date: 2021/6/14

class System extends StatefulWidget {
  const System({Key? key, required this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System>
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
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).role,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.supervisor_account),
          onTap: () {},
          padding: dp(30.0),
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 1, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).menu,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.menu_outlined),
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
                  curve: Interval((1 / count) * 2, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).department,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.art_track_rounded),
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
                  curve: Interval((1 / count) * 3, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).post,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.book),
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
                  curve: Interval((1 / count) * 4, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).dictionary,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.bookmark_border),
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
                  curve: Interval((1 / count) * 5, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).parameter,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.edit),
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
                  curve: Interval((1 / count) * 6, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).notice,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.speaker_notes_sharp),
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
                  curve: Interval((1 / count) * 7, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController,
        ),
      ),
    );
    listViews.add(
      MergeSemantics(
        child: ClickItem(
          title: locale(context).log,
          style: TextStyle(fontSize: 20),
          child: Icon(Icons.info),
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
                  curve: Interval((1 / count) * 8, 1.0,
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
            title: locale(context).system1,
            children: [Icon(Icons.settings)],
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
