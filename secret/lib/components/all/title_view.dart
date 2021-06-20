import 'package:flutter/material.dart';

/// description:title view
///
/// user: yuzhou
/// date: 2021/6/14

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController animationController;
  final Animation<double> animation;
  final Widget? child;
  final Function() callback;
  final double padding;
  const TitleView(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
      required this.animationController,
      required this.animation,
      this.child = const SizedBox(),
      required this.callback,
      this.padding = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: padding * 2, right: padding * 2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                          color: Color(0xFF4A6572),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: callback,
                      child: Padding(
                        padding: EdgeInsets.only(left: padding / 2),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                letterSpacing: 0.5,
                                color: Color(0xFF213333),
                              ),
                            ),
                            SizedBox(
                                height: 38,
                                width: padding * 2,
                                child: this.child),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
