import 'package:flutter/material.dart';

class MyPaddings{
  
  static Padding responsivePadding(context,{child}){
double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isTablet = screenWidth > 600;
  return Padding(padding:EdgeInsets.all(isTablet? 80.0:15.0),child: child,);
  }
   static responsivePaddingHorizontal(context,{child}){
double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  bool isTablet = screenWidth > 600;
  return Padding(padding:EdgeInsets.symmetric(horizontal:isTablet? 80.0:10.0),child: child,);
  }
}