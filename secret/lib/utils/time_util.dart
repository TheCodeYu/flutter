/// description:
///
/// user: yuzhou
/// date: 2021/6/23
import 'package:intl/intl.dart';

class TimeUtils {
  List<String> getTimeBettwenStartTimeAndEnd(
      {startTime: String, endTime: String, format: String}) {
    List<String> mDateList = List.empty();
    //记录往后每一天的时间搓，用来和最后一天到做对比。这样就能知道什么时候停止了。
    int allTimeEnd = 0;
    //记录当前到个数(相当于天数)
    int currentFlag = 0;
    DateTime startDate = DateTime.parse(startTime);
    DateTime endDate = DateTime.parse(endTime);
    var mothFormatFlag = new DateFormat(format);
    while (endDate.millisecondsSinceEpoch > allTimeEnd) {
      allTimeEnd =
          startDate.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000;
      var dateTime = new DateTime.fromMillisecondsSinceEpoch(
          startDate.millisecondsSinceEpoch + currentFlag * 24 * 60 * 60 * 1000);
      String nowMoth = mothFormatFlag.format(dateTime);
      mDateList.add(nowMoth);
      currentFlag++;
    }
    return mDateList;
  }

  /// 判断是否是闰年
  /// 能被4整除且不能被100整除，或者 能被400整除
  /// @param year
  /// @return
  static bool isLeapYear(int year) {
    bool leapYear = false;
    if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
      leapYear = true;
    }
    return leapYear;
  }

  /// 根据年，月，日，计算总天数
  /// @param year
  /// @param month
  /// @return
  static int getDays(int year, int month, int day) {
    List<int> arr = [31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 30];
    bool leapYear = isLeapYear(year);
    if (leapYear) {
      arr[1] = 29;
    }
    int sum = 0;
    for (int i = 0; i < month - 1; i++) {
      sum += arr[i];
    }
    sum = sum + day;
    return sum;
  }
}
