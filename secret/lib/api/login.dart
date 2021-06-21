/// description:登陆注册API
///
/// user: yuzhou
/// date: 2021/6/21
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:secret/utils/dioUtil.dart';

var dio = DioUtil.dio;
// 登录接口，登录成功后返回用户信息
login(user, pwd, BuildContext context) async {
  var r = await dio.post('/login',
      data: {
        "username": user,
        "password": pwd,
        "product": "com.mychip.crm",
        "code": 5,
        "uuid": 213333
      },
      options: Options(extra: {"noCache": false, "context": context}));
  return r.data;
}
