import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/configs/global_states.dart';
import 'package:secret/configs/rx_config.dart';
import 'package:secret/core/base_widget.dart';
import 'package:secret/utils/color.dart';

import 'tab_icons.dart';

/// description:主页底部bar
///
/// user: yuzhou
/// date: 2021/6/13

class BottomBar extends StatefulWidget {
  const BottomBar(
      {Key? key,
      required this.changeIndex,
      required this.addClick,
      required this.tabIconsList})
      : super(key: key);

  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIcon> tabIconsList;
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with TickerProviderStateMixin, BaseWidget {
  late AnimationController animationController;
  @override
  void initState() {
    rx.subscribe('bottom_bar', (data) {
      setRemoveAllSelection(widget.tabIconsList[data]);
    }, name: 'BottomBar');
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1000));
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    rx.unSubscribe('bottom_bar', name: 'BottomBar');
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var app = Provider.of<ApplicationData>(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                child: PhysicalShape(
                  clipper: TabClipper(
                      radius: Tween<double>(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn))
                              .value *
                          38.0),
                  color: app.getThemeMode() == ThemeMode.system
                      ? (MediaQuery.platformBrightnessOf(context) ==
                              Brightness.light
                          ? Colors.white
                          : Colors.white70)
                      : (app.getThemeMode() == ThemeMode.light
                          ? Colors.white
                          : Colors.white70),
                  elevation: 16.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: dp(62),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TabIcons(
                                tabIconData: widget.tabIconsList[0],
                                removeAllSelect: () {
                                  setRemoveAllSelection(widget.tabIconsList[0]);
                                  widget.changeIndex(0);
                                },
                              )),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[1],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[1]);
                                      widget.changeIndex(1);
                                    }),
                              ),
                              SizedBox(
                                width: Tween<double>(begin: 0.0, end: 1.0)
                                        .animate(CurvedAnimation(
                                            parent: animationController,
                                            curve: Curves.fastOutSlowIn))
                                        .value *
                                    64.0,
                              ),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[2],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[2]);
                                      widget.changeIndex(2);
                                    }),
                              ),
                              Expanded(
                                child: TabIcons(
                                    tabIconData: widget.tabIconsList[3],
                                    removeAllSelect: () {
                                      setRemoveAllSelection(
                                          widget.tabIconsList[3]);
                                      widget.changeIndex(3);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
              );
            }),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38.0 + dp(62.0),
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController,
                            curve: Curves.fastOutSlowIn)),
                    child: Container(
                      // alignment: Alignment.center,s
                      decoration: BoxDecoration(
                        color: BaseWidget.defaultColor,
                        gradient: LinearGradient(
                            colors: [
                              BaseWidget.defaultColor,
                              HexColor('#6A88E5'),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: BaseWidget.defaultColor.withOpacity(0.4),
                              offset: const Offset(8.0, 16.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            widget.addClick();
                          },
                          child: Icon(
                            Icons.add,
                            //color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIcon tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIcon tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  const TabIcons(
      {Key? key, required this.tabIconData, required this.removeAllSelect})
      : super(key: key);
  final TabIcon tabIconData;
  final Function removeAllSelect;
  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController!.reverse();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              widget.tabIconData.animationController!.forward();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween<double>(begin: 0.88, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.tabIconData.animationController!,
                          curve:
                              Interval(0.1, 1.0, curve: Curves.fastOutSlowIn))),
                  child: widget.tabIconData.isSelected
                      ? widget.tabIconData.selected
                      : widget.tabIconData.unSelected,
                ),
                Positioned(
                    top: 4,
                    left: 6,
                    right: 0,
                    child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: widget.tabIconData.animationController!,
                              curve: Interval(0.2, 1.0,
                                  curve: Curves.fastOutSlowIn))),
                      child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              color: BaseWidget.defaultColor,
                              shape: BoxShape.circle)),
                    )),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController!,
                            curve: Interval(0.5, 0.8,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: BaseWidget.defaultColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: widget.tabIconData.animationController!,
                            curve: Interval(0.5, 0.6,
                                curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: BaseWidget.defaultColor,
                        shape: BoxShape.circle,
                      ),
                    ),
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

class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
