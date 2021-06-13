import 'package:flutter/material.dart';
import 'package:secret/components/all/countdown.dart';
import 'package:secret/core/base_widget.dart';

/// description:闪屏页
///
/// user: yuzhou
/// date: 2021/6/12
class SplashPage extends StatefulWidget {
  static const String defaultRoute = '/';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with BaseWidget {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: dp(25),
              top: dp(25),
              child: CountdownInit(),
            ),
            SizedBox(
              width: dp(375),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/init_logo.webp',
                    width: dp(300),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: dp(70)),
                  ),
                  Image.asset(
                    'images/init_icon.png',
                    width: dp(90),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
