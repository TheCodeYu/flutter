import 'package:flutter/material.dart';

/// description:
///
/// user: yuzhou
/// date: 2021/6/14
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print("myinit");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("my");
    return Container(
      child: Text("dwedewfewfewfewfewfewfwefewfef"),
    );
  }

  @override
  void dispose() {
    print('weqw');
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
