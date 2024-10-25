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
    return '${dateTime.hour}:${dateTime.minute}';
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
    return DateFormat.MMMM(locale).format(dateTime); // Localized month name
  }

  static String getDay(DateTime dateTime) {
    return dateTime.day.toString();
  }
}
