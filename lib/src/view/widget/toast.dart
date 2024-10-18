import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
toastInfo({
  required String msg,
  Color backgroundColor = AppColors.primaryText,
  Color textColor = AppColors.primaryBackground,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 8,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14,
  );
}

toastError({
  required String msg,
  Color backgroundColor = AppColors.primaryStatusError,
  Color textColor = AppColors.whiteText,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 8,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 14,
  );
}
