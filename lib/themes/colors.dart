import 'package:flutter/material.dart';

const white =Colors.white;
const black =Colors.black;
class AppColors {
  static const Color primaryColorValue = Color.fromARGB(255, 255, 136, 67); // orange
  static const Color primaryColorTransperent = Color.fromARGB(120, 245, 159, 11); // orange
  static final success = const Color(0xff41f1b6);
static final iconsColor = const Color(0xffC9C4C4);
  static const Color blue=const Color(0xff1477FF);
 static List<Color>? orangeGradient=[primaryColorValue,primaryColorTransperent];
 static List<Color>? orangeGradientTransparent=[primaryColorValue.withOpacity(0.1),primaryColorTransperent];
 static final danger = Color.fromARGB(255, 251, 90, 90);

}