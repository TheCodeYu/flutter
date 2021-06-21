import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secret/core/base_widget.dart';

/// description:常用小工具集合
///
/// user: yuzhou
/// date: 2021/6/21

class CommonUtils {
  ///Toast 弹框 不需要context
  static showToast(
    String msg, {
    Toast? toastLength,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
  }) =>
      Fluttertoast.showToast(
          msg: msg,
          toastLength: toastLength,
          gravity: gravity,
          backgroundColor: backgroundColor ?? BaseWidget.defaultColor,
          textColor: textColor);

  static cancelToast() => Fluttertoast.cancel();
}
