import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:secret/configs/global_config.dart';
import 'package:secret/utils/common_utils.dart';

/// description:网络请求封装
///
/// user: yuzhou
/// date: 2021/6/20

///[CacheObject] 缓存策略
class CacheObject {
  CacheObject(this.response)
      : timeStamp = DateTime.now().microsecondsSinceEpoch;
  Response response;

  ///缓存创建时间
  int timeStamp;

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  //将请求uri作为缓存的key
  @override
  int get hashCode => response.realUri.hashCode;
}

///[NetCache] 使用拦截器实现的缓存策略
class NetCache extends Interceptor {
  ///[todo] 暂时存在内存中为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  void delete(String key) {
    cache.remove(key);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!GlobalConfig.application.cacheConfig.enable)
      return handler.next(options);
    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;

    ///如果是下拉刷新，先删除相关缓存
    if (refresh) {
      if (options.extra["list"] == true) {
        ///若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return handler.next(options);
    }
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        ///若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            GlobalConfig.application.cacheConfig.maxAge) {
          return handler.resolve(cache[key]!.response);
        } else {
          ///若已过期则删除缓存，继续向服务器请求
          delete(key);
        }
      }
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    ///错误状态不缓存
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (GlobalConfig.application.cacheConfig.enable) _saveCache(response);

    handler.next(response);
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      /// 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == GlobalConfig.application.cacheConfig.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }
}

class MyInterceptor extends Interceptor {
  ///只放行200的响应
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("response:$response");
    CommonUtils.cancelDismiss();
    if (response.data['code'] == 200) {
      handler.next(response);
    } else {
      if (response.data['code'] == 401) {
      } else if (response.data['code'] == 500) {}
      //BuildContext context = response.requestOptions.extra['context'];
      //CommonUtils.showToast(response.data['msg']);
      //handler.
    }
    CommonUtils.showToast(response.data['msg']);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("DioError:${err.error}");
    CommonUtils.cancelDismiss();
    CommonUtils.showToast(err.error.toString());
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// 设置用户token（可能为null，代表未登录）

    options.headers['Authorization'] = GlobalConfig.getToken();
    print(
        "options:${options.extra.toString()} ${options.data.toString()} ${options.headers.toString()}");
    super.onRequest(options, handler);
  }
}

class DioUtil {
  static MyInterceptor myInterceptor = MyInterceptor();
  static Dio dio =
      Dio(BaseOptions(baseUrl: 'http://192.168.2.7:8080', sendTimeout: 10));

  static void init() {
    ///添加缓存插件
    dio.interceptors.add(GlobalConfig.netCache);

    ///自定义处理器
    dio.interceptors.add(myInterceptor);

    // /// 设置用户token（可能为null，代表未登录）
    // dio.options.headers[HttpHeaders.authorizationHeader] =
    //     GlobalConfig.application.token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (!GlobalConfig.isRelease) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY 10.1.10.250:8888";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }
}
