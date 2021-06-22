import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// description:常用小工具集合
///
/// user: yuzhou
/// date: 2021/6/21

class CommonUtils {
  ///Toast 弹框 不需要context
  static showToast(
    String msg, {
    Duration time = const Duration(milliseconds: 2000),
    alignment: Alignment.bottomCenter,
    //默认消失类型,类似android的toast,toast一个一个展示
    //非默认消失类型,多次点击,后面toast会顶掉前者的toast显示
    bool isDefaultDismissType = true,
    Widget? widget,
  }) =>
      SmartDialog.showToast(msg,
          time: time,
          alignment: alignment,
          isDefaultDismissType: isDefaultDismissType,
          widget: widget);

  static showLoading(
          {String msg = 'loading...',
          Color background = Colors.black,
          bool clickBgDismissTemp = false,
          bool isLoadingTemp = true,
          bool? isPenetrateTemp,
          bool? isUseAnimationTemp,
          Duration? animationDurationTemp,
          Color? maskColorTemp,
          Widget? widget}) =>
      SmartDialog.showLoading(
        msg: msg,
        background: background,
        clickBgDismissTemp: clickBgDismissTemp,
        isLoadingTemp: isLoadingTemp,
        isPenetrateTemp: isPenetrateTemp,
        isUseAnimationTemp: isUseAnimationTemp,
        animationDurationTemp: animationDurationTemp,
        maskColorTemp: maskColorTemp,
        widget: widget,
      );
  static cancelDismiss({int closeType = 0}) =>
      SmartDialog.dismiss(closeType: closeType);
}
