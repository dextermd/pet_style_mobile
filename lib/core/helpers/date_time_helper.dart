import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getFormattedDate(DateTime dateTime) {
    String month =
        dateTime.month < 10 ? '0${dateTime.month}' : '${dateTime.month}';
    String day = dateTime.day < 10 ? '0${dateTime.day}' : '${dateTime.day}';

    return '${dateTime.year}-$month-$day';
  }

  static String getFormattedTime(DateTime dateTime) {
    String hour = dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}';
    String minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';

    return '$hour:$minute';
  }

  static String getFormattedDateTime(DateTime dateTime) {
    return '${getFormattedDate(dateTime)} ${getFormattedTime(dateTime)}';
  }

  static String getFormattedDateFromString(String date) {
    final DateTime dateTime = DateTime.parse(date);
    return getFormattedDate(dateTime);
  }

  static String getMonthName(DateTime dateTime, String locale) {
    initializeDateFormatting(locale, '');
    String month = DateFormat.MMMM(locale).format(dateTime);
    return month[0].toUpperCase() + month.substring(1).toLowerCase();
  }

  static String getDay(DateTime dateTime) {
    return dateTime.day.toString();
  }

  static String getAge(DateTime birthDate) {
    final DateTime now = DateTime.now();
    final int age = now.year - birthDate.year;
    final int month = now.month - birthDate.month;
    final int day = now.day - birthDate.day;

    if (month < 0 || (month == 0 && day < 0)) {
      return (age - 1).toString();
    }

    return age.toString();
  }

  static DateTime getDateTimeWidthTimeSlot(DateTime date, String timeSlot) {
    final List<String> timeSlotList = timeSlot.split(':');

    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(timeSlotList[0]),
      int.parse(timeSlotList[1]),
    );
  }
}
