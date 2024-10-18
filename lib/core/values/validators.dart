import 'package:intl/intl.dart';

abstract class Validator {
  const Validator();

  bool validate(String str);
}

class EmptyValidator extends Validator {
  const EmptyValidator();

  @override
  bool validate(String str) {
    return true;
  }
}

class NameValidator extends Validator {
  @override
  bool validate(String str) {
    return true;
  }
}

class DateValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.isEmpty) {
      return false;
    }
    final RegExp dateRegExp = RegExp(r'^\d{2}\.\d{2}\.\d{4}$');
    if (!dateRegExp.hasMatch(str)) {
      return false;
    }

    final dateFormat = DateFormat('dd.MM.yyyy');
    DateTime inputDate;

    try {
      inputDate = dateFormat.parseStrict(str);
      final minDate = DateTime(1900, 1, 1);
      if (inputDate.isBefore(minDate)) {
        return false;
      }
      return true;
    } on FormatException {
      return false;
    }
  }
}

class EmailValidator extends Validator {
  @override
  bool validate(String str) {
    if (str.isEmpty) {
      return false;
    }
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
        .hasMatch(str)) {
      return true;
    }
    return false;
  }
}
