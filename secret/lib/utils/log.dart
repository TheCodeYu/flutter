/// description:日志处理类
///
/// user: yuzhou
/// date: 2021/6/7

class Log {
  //环境标志位
  static const bool isRelease = const bool.fromEnvironment("dart.vm.product");

  static void debug(String tag, Object message) {
    if (!isRelease) _printLog(tag, '[Debug]', message);
  }

  static void info(String tag, Object message) {
    _printLog(tag, '[info]', message);
  }

  static void error(String tag, Object message) {
    _printLog(tag, '[error]', message);
  }

  ///[todo]:存储到数据库或者传递到后台
  static void _printLog(String tag, String level, Object message) {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer..write(level)..write(tag)..write(': ')..write(message);
    print(stringBuffer);
  }
}
