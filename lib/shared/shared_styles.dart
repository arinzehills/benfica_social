
import 'package:benfica_social/themes/colors.dart';
import 'package:flutter/material.dart';

Size size(context) => MediaQuery.of(context).size;

var textFieldDecoration =  InputDecoration(
  filled: true,
  fillColor: AppColors.primaryColorValue.withOpacity(0.19),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10.0),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(10.0),
  ),
);

   final myBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      offset: const Offset(
        5.0,
        5.0,
      ),
      blurRadius: 50.0,
      spreadRadius: 2.0,
    ),
  ];
  final roundedBoxDecoration=BoxDecoration(
              color: white,
              boxShadow: myBoxShadow,
              borderRadius: BorderRadius.circular(10));