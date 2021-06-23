import 'package:flutter/material.dart';
import 'package:secret/core/base_widget.dart';

/// description:
///
/// user: yuzhou
/// date: 2021/6/23

class LoadingDialog extends StatelessWidget with BaseWidget {
  final String text;

  LoadingDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          //width: dp(60),
          //height: dh(60),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: BaseWidget.defaultColor,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: dp(20),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
