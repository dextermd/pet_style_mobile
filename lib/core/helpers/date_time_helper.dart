class DateTimeHelper {
  static String getFormattedDate(DateTime dateTime) {
    String month = dateTime.month < 10 ? '0${dateTime.month}' : '${dateTime.month}';
    String day = dateTime.day < 10 ? '0${dateTime.day}' : '${dateTime.day}';

    return '${dateTime.year}-$month-$day';
  }

  static String getFormattedTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }

  static String getFormattedDateTime(DateTime dateTime) {
    return '${getFormattedDate(dateTime)} ${getFormattedTime(dateTime)}';
  }
}