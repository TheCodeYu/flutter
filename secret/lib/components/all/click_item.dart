/// description:点击条目，常用于列表展示功能项，具备点击事件
///
/// user: yuzhou
/// date: 2021/6/14
import 'package:flutter/material.dart';

class ClickItem extends StatelessWidget {
  const ClickItem(
      {Key? key,
      this.onTap,
      this.child,
      this.color,
      this.style,
      this.title: '',
      this.content: '',
      this.textAlign: TextAlign.start,
      this.maxLines: 1,
      this.padding: 15.0,
      this.animationController,
      this.animation})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String title;
  final TextStyle? style;
  final MaterialColor? color;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final Widget? child;
  final double padding;
  final AnimationController? animationController;
  final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    var item = Container(
        child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: padding),
        padding: EdgeInsets.fromLTRB(padding / 2, 10.0, padding, 5.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 25.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            border: Border(
              bottom: Divider.createBorderSide(context, width: 0.6),
            )),
        child: Row(
          //为了数字类文字居中
          crossAxisAlignment: maxLines == 1
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: style,
            ),
            const Spacer(),
            const SizedBox(height: 10),
            Expanded(
              flex: 4,
              child: Text(content,
                  maxLines: maxLines,
                  textAlign: maxLines == 1 ? TextAlign.right : textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 12)),
            ),
            Opacity(
              // 无点击事件时，隐藏箭头图标
              opacity: this.child == null ? 0 : 1,
              child: Padding(
                  padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
                  child: this.child),
            )
          ],
        ),
      ),
    ));
    if (animationController == null) {
      return item;
    } else {
      return AnimatedBuilder(
          animation: animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
                opacity: animation!,
                child: new Transform(
                    transform: new Matrix4.translationValues(
                        0.0, 30 * (1.0 - animation!.value), 0.0),
                    child: item));
          });
    }
  }
}
