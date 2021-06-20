import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secret/configs/rx_config.dart';
import 'package:secret/core/base_widget.dart';

/// description: 登陆注册页面
///
/// user: yuzhou
/// date: 2021/6/12

class LoginPage extends StatefulWidget {
  final arguments;
  static const String defaultRoute = '/login';

  const LoginPage({Key? key, this.arguments}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState(arguments);
}

class _LoginPageState extends State<LoginPage> with BaseWidget {
  late TapGestureRecognizer _longPressRecognizer;
  final _routeProp;
  late String? _country = null;
  bool _checkboxSelected = false; //维护复选框状态
  String _phoneNumber = '86';
  int type = 2;
  int _timer = 0;
  bool _sendCode = true;
  Timer? timer;

  ///0:注册，1：手机+密码 2：手机+验证码 3：昵称+密码

  _LoginPageState(this._routeProp) {
    switch (_routeProp?['type']) {
      case 'signin':
        type = 1;
        break;
      case 'signup':
        type = 0;
        break;
    }
  }

  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _longPressRecognizer = TapGestureRecognizer()..onTap = _handlePress;
    rx.subscribe('chooseArea', (data) {
      if (mounted) {
        setState(() {
          _country = data[0];
          _phoneNumber = data[1];
        });
      }
    }, name: 'LoginPage');
  }

  void _handlePress() {
    print("_handlePress");
  }

  @override
  void dispose() {
    rx.unSubscribe('chooseArea', name: 'LoginPage');
    _longPressRecognizer.dispose();
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    _country ??= locale(context).china;
    switch (type) {
      case 0:
        title = locale(context).register;
        break;
      case 1:
      case 2:
        title = locale(context).login_m;
        break;
      case 3:
        title = locale(context).login_n;
        break;
    }
    return Scaffold(
      ///在flutter中，键盘弹起时系统会缩小Scaffold的高度并重建
      ///把Scaffold的resizeToAvoidBottomInset属性设置为false，这样在键盘弹出时将不会resize
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: AppBar(
          centerTitle: true,
          title: Text(
            title!,
            style: TextStyle(fontSize: dp(16)),
          ),
          //backgroundColor: Colors.white,
          titleSpacing: 0,
          // leading: GestureDetector(
          //   onTap: () => Navigator.of(context).pop(),
          //   child: Container(
          //     child: Center(
          //       child: Icon(Icons.arrow_back),
          //     ),
          //   ),
          // ),
          elevation: 0,
          actions: <Widget>[
            type != 0
                ? GestureDetector(
                    onTap: _changeNickNameLogin,
                    child: Row(
                      children: [
                        Text(
                          type == 3
                              ? locale(context).login_m
                              : locale(context).login_n,
                          style: TextStyle(fontSize: dp(16)),
                        ),
                        Padding(padding: EdgeInsets.only(left: dp(20)))
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
        preferredSize: Size.fromHeight(dp(48)),
      ),
      //backgroundColor: Color(0xffeeeeee),
      body: Padding(
        padding: EdgeInsets.only(left: dp(10), right: dp(10)),
        child: Column(
          children: <Widget>[
            // type != 3
            //     ? GestureDetector(
            //         onTap: _showAreaList,
            //         child: Container(
            //           margin: EdgeInsets.only(top: dp(18)),
            //           height: dp(40),
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.all(Radius.circular(5))),
            //           child: Padding(
            //             padding: EdgeInsets.only(left: dp(1), right: dp(1)),
            //             child: Row(
            //               children: <Widget>[
            //                 Expanded(
            //                     flex: 1,
            //                     child: Text(
            //                       locale(context).area,
            //                       style: TextStyle(color: Color(0xff9b9b9b)),
            //                     )),
            //                 Text(_country!),
            //                 Padding(padding: EdgeInsets.only(left: dp(5))),
            //                 Icon(Icons.chevron_right)
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),
            SizedBox(
              height: dh(10.0),
            ),
            Image.asset(
              'images/init_icon.png',
              width: dp(90),
            ),
            type != 3
                ? Container(
                    margin: EdgeInsets.only(top: dp(18)),
                    height: dp(40),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(),
                          right: BorderSide(),
                          top: BorderSide(),
                          bottom: BorderSide()),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dp(20), right: dp(20)),
                      child: Row(
                        children: <Widget>[
                          TextButton(
                              onPressed: _showAreaList,
                              child: Text(
                                '+$_phoneNumber',
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xff999999),
                                        width: dp(1))),
                              ),
                              child: TextField(
                                controller: _mobileController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                keyboardType: TextInputType.number,
                                cursorColor: BaseWidget.defaultColor,
                                cursorWidth: 1.5,
                                style: TextStyle(
                                  // color: Color(0xff333333),
                                  fontSize: dp(16.0),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(
                                      left: dp(15), top: dp(3), bottom: dp(3)),
                                  hintText: locale(context).hit1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(top: dp(18)),
                    height: dp(40),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(),
                          right: BorderSide(),
                          top: BorderSide(),
                          bottom: BorderSide()),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dp(20), right: dp(20)),
                      child: Row(
                        children: <Widget>[
                          TextButton(
                              onPressed: null, child: Icon(Icons.person)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xff999999),
                                        width: dp(1))),
                              ),
                              child: TextField(
                                controller: _nickNameController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                keyboardType: TextInputType.number,
                                cursorColor: BaseWidget.defaultColor,
                                cursorWidth: 1.5,
                                style: TextStyle(
                                  //color: Color(0xff333333),
                                  fontSize: dp(12.0),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(
                                      left: dp(15), top: dp(3), bottom: dp(3)),
                                  hintText: locale(context).hit2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            type != 2
                ? Container(
                    margin: EdgeInsets.only(top: dp(18)),
                    height: dp(40),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(),
                          right: BorderSide(),
                          top: BorderSide(),
                          bottom: BorderSide()),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dp(20), right: dp(5)),
                      child: Row(
                        children: <Widget>[
                          TextButton(onPressed: null, child: Icon(Icons.lock)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xff999999),
                                        width: dp(1))),
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                cursorColor: BaseWidget.defaultColor,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                cursorWidth: 1.5,
                                style: TextStyle(
                                  //color: Color(0xff333333),
                                  fontSize: dp(16.0),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(
                                      left: dp(15), top: dp(3), bottom: dp(3)),
                                  hintText: locale(context).hit3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            type == 2 || type == 0
                ? Container(
                    margin: EdgeInsets.only(top: dp(18)),
                    height: dp(40),
                    decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(),
                          right: BorderSide(),
                          top: BorderSide(),
                          bottom: BorderSide()),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: dp(20), right: dp(5)),
                      child: Row(
                        children: <Widget>[
                          TextButton(
                              onPressed: null,
                              child: Icon(Icons.admin_panel_settings)),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: Color(0xff999999),
                                        width: dp(1))),
                              ),
                              child: TextField(
                                controller: _codeController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                cursorColor: BaseWidget.defaultColor,
                                cursorWidth: 1.5,
                                style: TextStyle(
                                  //color: Color(0xff333333),
                                  fontSize: dp(16.0),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.only(
                                      left: dp(15), top: dp(3), bottom: dp(3)),
                                  hintText: locale(context).hit4,
                                ),
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            constraints: BoxConstraints(
                                maxHeight: dp(30), minWidth: dp(100)),
                            fillColor: Color(0xffff7701),
                            elevation: 0,
                            highlightElevation: 0,
                            highlightColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            onPressed: _sendCode
                                ? () {
                                    _sendCode = false;
                                    _timer = 60;
                                    setState(() {});
                                    timer = Timer.periodic(Duration(seconds: 1),
                                        (timer) {
                                      if (_timer == 0) {
                                        timer.cancel();

                                        _sendCode = true;
                                        // return;
                                      }
                                      setState(() {
                                        _timer == 0 ? _timer = 0 : _timer--;
                                      });
                                      // int _timer = 60;
                                      // bool _sendCode = true;
                                    });
                                  }
                                : null,
                            child: Center(
                              child: Text(
                                _timer == 0
                                    ? locale(context).hit5
                                    : locale(context).hit6(_timer),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: dp(16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.only(top: dh(30)),
            ),
            RawMaterialButton(
              constraints: BoxConstraints(minHeight: 40),
              fillColor: Color(0xffff7701),
              elevation: 0,
              highlightElevation: 0,
              highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              onPressed: () {},
              child: Center(
                child: Text(
                  type == 0 ? locale(context).register : locale(context).login,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: dh(10)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                type != 0
                    ? GestureDetector(
                        onTap: _forgetPassword,
                        child: Text(
                          locale(context).forgetPWD,
                          style: TextStyle(
                            color: Color(0xff999999),
                          ),
                        ))
                    : SizedBox(),
                type != 0
                    ? GestureDetector(
                        onTap: _changePhoneLogin,
                        child: Text(
                          type == 2
                              ? locale(context).login_p
                              : locale(context).login_c,
                          style: TextStyle(
                            color: Color(0xffff7701),
                          ),
                        ),
                      )
                    : SizedBox(),
                GestureDetector(
                  onTap: _changeSinup,
                  child: Text(
                    type == 0
                        ? locale(context).login
                        : locale(context).register,
                    style: TextStyle(
                      color: Color(0xffff7701),
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Color(0xffff7701),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: type == 0 ? dh(5) : dh(60)),
            ),
            SizedBox(
              height: dh(45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: dp(25)),
                    height: dp(2),
                    width: dp(40),
                    color: Color(0xffe7e7e7),
                  ),
                  Text(
                    locale(context).login_s,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(
                          0xff707070,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: dp(25)),
                    height: dp(2),
                    width: dp(40),
                    color: Color(0xffe7e7e7),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  'images/login/wx.webp',
                  width: dp(30),
                ),
                Image.asset(
                  'images/login/qq.webp',
                  width: dp(30),
                ),
                Image.asset(
                  'images/login/weibo.webp',
                  width: dp(30),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: dh(20)),
            ),
            Wrap(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _checkboxSelected,
                          onChanged: (e) {
                            setState(() {
                              _checkboxSelected = e!;
                            });
                          },
                          activeColor: BaseWidget.defaultColor, //选中时的颜色
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12,
                                height: 1.2,
                              ),
                              text: locale(context).user_1,
                            )),
                      ],
                    )),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 12,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                          text: locale(context).user_2,
                          style: TextStyle(color: Color(0xffff7701)),
                          recognizer: _longPressRecognizer),
                      TextSpan(
                        text: '、',
                      ),
                      TextSpan(
                        text: locale(context).user_3,
                        style: TextStyle(color: Color(0xffff7701)),
                      ),
                      TextSpan(
                        text: locale(context).and,
                      ),
                      TextSpan(
                        text: locale(context).user_4,
                        style: TextStyle(color: Color(0xffff7701)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changePhoneLogin() {
    setState(() {
      type = type == 2 ? 1 : 2;
    });
  }

  void _changeNickNameLogin() {
    setState(() {
      type = type == 3 ? 1 : 3;
    });
  }

  void _changeSinup() {
    setState(() {
      type = type == 0 ? 1 : 0;
    });
  }

  void _forgetPassword() {}

  void _showAreaList() {}
}
