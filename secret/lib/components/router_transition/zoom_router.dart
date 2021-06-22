import 'package:flutter/material.dart';

/// description:路由动画效果 缩放的效果
///
/// user: yuzhou
/// date: 2021/6/23

class ZoomRoute extends PageRouteBuilder {
  final Widget widget;
  ZoomRoute(this.widget)
      : super(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (
              BuildContext context,
              Animation<double> animation1,
              Animation<double> animation2,
            ) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              // 缩放的效果
              return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
