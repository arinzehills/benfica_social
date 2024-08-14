import 'package:flutter/material.dart';

class MyTextSize{
  static  double xxbig=32.0;
  static  double xbig=26.0;
  static  double big=20.0;
  static  double medium=16;
  static  double normal=14;
  static  double small=12;
}
class MyFontFamily{
  static  String bungeeInline='BungeeInline';
  static  String bestoom='Bestoom';
}
class MyText{
    static Widget errorText(String error) {
    return Text(
      error,
      style: TextStyle(color: Colors.red),
    );
  }
  static Widget myText(text, {type,double textSize=14.0, italize = false, color, maxLines, align,withPadding=true,fontFamily}) =>
      Padding(
        padding:  EdgeInsets.symmetric(vertical:withPadding? 2.0:0),
        child: Text(
          text ?? 'text',
          maxLines: maxLines,
          textAlign: align,
          style: TextStyle(
          fontFamily:fontFamily ,
              fontStyle: italize ? FontStyle.italic : null,
              overflow: TextOverflow.ellipsis,
              color: color??Colors.black,
              fontWeight:
                  type == MyTextSize.big|| type == MyTextSize.medium ? FontWeight.w600 : null,
              fontSize: textSize
                          ),
        ),
      );
}