import 'package:intl/intl.dart';

class ShowDateTimeHelper {
  //created by YYW

  static const String formatMmmDd = "MMM dd";
  static const String formatDdMmmmYy = "dd MMMM, yy";
  static const String formatDMYTime = "dd MMM yyyy - hh:mm a";
  static const String formatDMmmYyyy = "d MMM yyyy";
  static const String formatYyyyMmDdHhMmSs = "yyyy-MM-dd HH:mm:ss";
  static const String formatddMMMyyyyEEEE = "dd MMM yyyy, EEEE";

  static String showTimeFromServer(String serverDateTime) {
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '));
    var timeFormat = '';
    timeFormat = DateFormat('jm')
        .format(DateTime.parse(localDateTime.toString()))
        .toString();
    return timeFormat;
  }

  static String showBookingSuccessTime(String serverDateTime) {
    var localDateTime =
        DateFormat('HH:mm a').parse(serverDateTime.replaceAll('T', ' '));
    var timeFormat = '';
    timeFormat = DateFormat('jm')
        .format(DateTime.parse(localDateTime.toString()))
        .toString();
    return timeFormat;
  }

  static String showCallFinishTime(String serverDateTime) {
    var timeFormat = '';
    if (serverDateTime.isNotEmpty) {
      var localDateTime = DateFormat('HH:mm a dd MM yyyy')
          .parse(serverDateTime.replaceAll('T', ' '));
      timeFormat = DateFormat('jm')
          .format(DateTime.parse(localDateTime.toString()))
          .toString();
    }

    return timeFormat;
  }

  static DateTime getLocalDateTime(String dateTime) {
    var localDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime.replaceAll('T', ' '));
    return localDateTime;
  }

  static String getNameOfDay(String dateTime) {
    print('myDate:${dateTime}');
    var localDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime.replaceAll('T', ' '));
    return DateFormat('EEEE').format(localDateTime);
  }

  static String getNameOfMonth(String dateTime) {
    var localDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime.replaceAll('T', ' '));
    return DateFormat('MMMM').format(localDateTime);
  }

  static String showNewsFeedDateTimeDifference(String serverDateTime) {
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '), true)
        .toLocal()
        .toIso8601String();
    var list = localDateTime.split('.');
    var dateTime = DateTime.parse(list[0]).toLocal();
    var timeDiff = DateTime.now().difference(dateTime.toLocal());
    var dateList = localDateTime.split(' ');
    var dateFormat = '';

    if (timeDiff < const Duration(days: 0, hours: 0, minutes: 0, seconds: 60)) {
      var second = DateTime.now().difference(dateTime).inSeconds;
      dateFormat = '$second ${second > 1 ? 'seconds' : 'second'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 0, minutes: 60, seconds: 0)) {
      var min = DateTime.now().difference(dateTime).inMinutes;
      dateFormat = '$min ${min > 1 ? 'minutes' : 'minute'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 24, minutes: 0, seconds: 0)) {
      var hour = DateTime.now().difference(dateTime).inHours;
      dateFormat = '$hour ${hour > 1 ? 'hours' : 'hour'} ago';
    } else if (timeDiff <
        const Duration(days: 7, hours: 0, minutes: 0, seconds: 0)) {
      var day = DateTime.now().difference(dateTime).inDays;
      dateFormat = '$day ${day > 1 ? 'days' : 'day'} ago';
    } else {
      dateFormat = DateFormat('MMM dd yyyy')
          .format(DateTime.parse(dateList[0]))
          .toString();
    }
    return dateFormat.toString();
  }

  static String showNotificationDateTimeDifference(String serverDateTime) {
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '))
        .toString();
    var list = localDateTime.split('.');
    var dateTime = DateTime.parse(list[0]).toLocal();
    var timeDiff = DateTime.now().difference(dateTime.toLocal());
    var dateList = localDateTime.split(' ');
    var dateFormat = '';

    if (timeDiff < const Duration(days: 0, hours: 0, minutes: 0, seconds: 60)) {
      var second = DateTime.now().difference(dateTime).inSeconds;
      dateFormat = '$second ${second > 1 ? 'seconds' : 'second'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 0, minutes: 60, seconds: 0)) {
      var min = DateTime.now().difference(dateTime).inMinutes;
      dateFormat = '$min ${min > 1 ? 'minutes' : 'minute'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 24, minutes: 0, seconds: 0)) {
      var hour = DateTime.now().difference(dateTime).inHours;
      dateFormat = '$hour ${hour > 1 ? 'hours' : 'hour'} ago';
    } else if (timeDiff <
        const Duration(days: 7, hours: 0, minutes: 0, seconds: 0)) {
      var day = DateTime.now().difference(dateTime).inDays;
      dateFormat = '$day ${day > 1 ? 'days' : 'day'} ago';
    } else {
      dateFormat = DateFormat('MMM dd yyyy')
          .format(DateTime.parse(dateList[0]))
          .toString();
    }
    return dateFormat.toString();
  }

  static String showDateChatTimeDifference(String date) {
    var list = date.split('.');
    var dateTime = DateTime.parse(list[0]);
    var timeDiff = DateTime.now().difference(dateTime);
    var dateList = date.split('T');
    var dateFormat;

    if (timeDiff < const Duration(days: 0, hours: 0, minutes: 0, seconds: 60)) {
      var second = DateTime.now().difference(dateTime).inSeconds;
      dateFormat = '$second ${second > 1 ? 'seconds' : 'second'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 0, minutes: 60, seconds: 0)) {
      var min = DateTime.now().difference(dateTime).inMinutes;
      dateFormat = '$min ${min > 1 ? 'minutes' : 'minute'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 24, minutes: 0, seconds: 0)) {
      var hour = DateTime.now().difference(dateTime).inHours;
      dateFormat = '$hour ${hour > 1 ? 'hours' : 'hour'} ago';
    } else if (timeDiff <
        const Duration(days: 1, hours: 0, minutes: 0, seconds: 0)) {
      var day = DateTime.now().difference(dateTime).inDays;
      dateFormat = '$day ${day > 1 ? 'days' : 'day'} ago';
    } else {
      dateFormat = DateFormat('MMM d, h:mm a')
          .format(DateTime.parse(date.replaceAll('T', ' ')))
          .toString();
    }

    return dateFormat;
  }

  static int getCountDownMinute(String serverDateTime) {
    var serverDatetime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '));
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '))
        .toString();
    var list = localDateTime.split('.');
    var dateTime = DateTime.parse(list[0]).toLocal();
    var timeDiff = DateTime.now().difference(dateTime);
    var dateList = localDateTime.split(' ');
    var dateFormat = '';

    var time = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, 45);
    var diffMinute = DateTime.now().difference(serverDatetime).inMinutes;
    var diffSec = DateTime.now().difference(serverDatetime).inSeconds;
    var countDown = time.difference(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        diffMinute));

    /* print(diffMinute);
    print('${countDown.inMinutes}');*/

    if (diffMinute > 45) {
      return 0;
    }

    return countDown.inMinutes;
  }

  static String dateFormat(String date, String format) {
    // var dateList = date.split(' ');
    return DateFormat(format).format(DateTime.parse(date)).toString();
  }

  static String showDateTimeDifference(String serverDateTime) {
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(serverDateTime.replaceAll('T', ' '), true)
        .toLocal()
        .toIso8601String();
    var list = localDateTime.split('.');
    var dateTime = DateTime.parse(list[0]);
    var timeDiff = DateTime.now().difference(dateTime);
    var dateList = localDateTime.split(' ');
    var dateFormat;

    if (timeDiff < const Duration(days: 0, hours: 0, minutes: 0, seconds: 60)) {
      var second = DateTime.now().difference(dateTime).inSeconds;
      dateFormat = '$second ${second > 1 ? 'seconds' : 'second'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 0, minutes: 60, seconds: 0)) {
      var min = DateTime.now().difference(dateTime).inMinutes;
      dateFormat = '$min ${min > 1 ? 'minutes' : 'minute'} ago';
    } else if (timeDiff <
        const Duration(days: 0, hours: 24, minutes: 0, seconds: 0)) {
      var hour = DateTime.now().difference(dateTime).inHours;
      dateFormat = '$hour ${hour > 1 ? 'hours' : 'hour'} ago';
    } else if (timeDiff <
        const Duration(days: 1, hours: 0, minutes: 0, seconds: 0)) {
      var day = DateTime.now().difference(dateTime).inDays;
      dateFormat = '$day ${day > 1 ? 'days' : 'day'} ago';
    } else {
      dateFormat = DateFormat('dd-MM-yyyy')
          .format(DateTime.parse(dateList[0]))
          .toString();
    }
    return dateFormat.toString();
  }
  

  static bool isToday(String date) {
    print('dfdo${date}}');
    var localDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(date.replaceAll('T', ' '), true)
        .toLocal();
    final day = localDateTime.day;
    final month = localDateTime.month;
    final year = localDateTime.year;
    //print('dfdo${day}+${month}+${year}');

    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  static bool isCurrentDateInRange(
      DateTime currentDate, DateTime startDate, DateTime endDate) {
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

  static String getTime(time) {
    print("kk09${time.toString()}");
    String result = "";

    if (!DateTime.now().difference(time).isNegative) {
      if (DateTime.now().difference(time).inMinutes < 1) {
        result = "a few seconds ago";
      } else if (DateTime.now().difference(time).inMinutes < 60) {
        result = "${DateTime.now().difference(time).inMinutes} minutes ago";
      } else if (DateTime.now().difference(time).inMinutes < 1440) {
        result = DateTime.now().difference(time).inHours > 1
            ? "IN ${DateTime.now().difference(time).inHours} HOURS"
            : "IN ${DateTime.now().difference(time).inHours} HOUR";
      } else if (DateTime.now().difference(time).inMinutes > 1440) {
        result = DateTime.now().difference(time).inDays > 1
            ? "IN ${DateTime.now().difference(time).inDays} DAYS"
            : "IN ${DateTime.now().difference(time).inDays} DAY";
      }
    }
    return result;
  }

  static int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
}
