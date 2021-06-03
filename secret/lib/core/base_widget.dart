import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// description: 所有Widget继承的抽象类
///
/// user: yuzhou
/// date: 2021/6/2

abstract class BaseWidget {
  //默认字体大小
  double defaultSize = 18;
  //主题色
  Color defaultColor = Color(0xffff5d23);
  // 初始化设计稿尺寸
  static final double dessignWidth = 375.0;
  static final double dessignHeight = 1335.0;

  static final double statusBarHeight =
      MediaQueryData.fromWindow(window).padding.top;

  // flutter_screenutil px转dp
  num dp(double dessignValue) => ScreenUtil().setWidth(dessignValue);
}
