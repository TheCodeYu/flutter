import 'package:flutter/cupertino.dart';

/// description:底部bar view
///
/// user: yuzhou
/// date: 2021/6/13

class TabIcon {
  TabIcon(
      {this.index = 0,
      this.isSelected = false,
      this.selected,
      required this.unSelected,
      this.animationController});
  Widget unSelected;
  Widget? selected;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIcon> tabIconsList = <TabIcon>[
    TabIcon(
      unSelected: Image.asset('images/home/tab_1.png'),
      selected: Image.asset('images/home/tab_1s.png'),
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIcon(
      unSelected: Image.asset('images/home/tab_2.png'),
      selected: Image.asset('images/home/tab_2s.png'),
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIcon(
      unSelected: Image.asset('images/home/tab_3.png'),
      selected: Image.asset('images/home/tab_3s.png'),
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIcon(
      unSelected: Image.asset('images/home/tab_4.png'),
      selected: Image.asset('images/home/tab_4s.png'),
      index: 3,
      isSelected: false,
      animationController: null,
    )
  ];
}
