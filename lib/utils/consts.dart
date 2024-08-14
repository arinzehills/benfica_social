import 'dart:math';
import 'package:benfica_social/themes/colors.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';

class Constants {
  //App related strings
  static String appName = 'Riswom';

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  static Widget topMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(top: margin),
    );
  }

  static Widget leftMargin(double margin) {
    return Container(
      margin: EdgeInsets.only(left: margin),
    );
  }

  static Widget errorText(String error) {
    return Text(
      error,
      style: TextStyle(color: Colors.red),
    );
  }

  static showSnackbarMessage(message, context, {color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color ?? AppColors.primaryColorValue,
        content: Text(message ?? 'Logged In Successfully')));
  }
   static showTaost({msg,  bgcolor}) {
    return showStyledToast(
      backgroundColor: bgcolor??AppColors.blue,
        // gravity: position ?? ToastGravity.TOP,
         child: Text(msg??'Awesome styled toast'),
    context: ToastProvider.context,);
  }
  
}
