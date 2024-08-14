import 'package:intl/intl.dart';

class MyDateFormatter {
  static format(format, datetime) => DateFormat(format).format(datetime);
  static String dateFormatter(
      {required DateTime datetime,
      bool showHours = false,
      showOnlyTime = false}) {
    String dateNow = DateFormat('dd LLLL,yyyy').format(DateTime.now());
    String datetimeFormat = DateFormat('dd LLLL,yyyy').format(datetime);
    final yesterday = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
    //single day comparison
    String dayFormat = DateFormat('dd').format(datetime);

    if (dateNow == datetimeFormat) {
      if (showHours) {
        final differenceInTime = DateTime.now().difference(datetime).inMinutes;
        if (differenceInTime <= 60) {
          return '${differenceInTime} min ago';
        } else {
          final differenceInTime = DateTime.now().difference(datetime).inHours;
          return '${differenceInTime} hours ago';
        }
      }
      return showOnlyTime
          ? "${format('KK:mm a', datetime)}"
          : 'Today at ${format('KK:mm a', datetime)}';
    } else if (format('dd LLLL,yyyy', yesterday) ==
        format('dd LLLL,yyyy', datetime)) {
      return showOnlyTime
          ? "${format('KK:mm a', datetime)}"
          : 'Yesterday at ${format('KK:mm a', datetime)}';
    } else {
      return datetimeFormat;
    }
  }

  static convertFromTimestamp(int timeStamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return dateTime;
  }

  static convertToTimestamp(DateTime dateTime) {
    final DateTime selectedDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );

    // Convert to milliseconds since the Unix epoch (for Node.js)
    final int timestamp = selectedDateTime.millisecondsSinceEpoch;

    print('Selected DateTime: $selectedDateTime');
    print('Timestamp for Node.js: $timestamp');
    return timestamp;
  }
}
