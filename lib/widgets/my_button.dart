
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lottie/lottie.dart';

class MyButton extends StatelessWidget {
  String placeHolder;
  double? widthRatio;
  double? height;
  bool isOval;
  bool withBorder;
  bool isGradientButton;
  bool loadingState;
  bool disabled;
  List<Color>? gradientColors;
  final VoidCallback pressed;
  Widget? child;
  Widget? suffixIcon ;
  Color? color;
  Color? textColor;
  String? fontFamily;
  double? fontSize;

  MyButton({
    required this.placeHolder,
    this.child,
    this.isOval = false,
    this.withBorder = false,
    this.disabled = false,
    this.height,
    this.fontSize,
    this.widthRatio,
    this.isGradientButton = false,
    this.loadingState = false,
    this.color=AppColors.primaryColorValue,
    this.textColor,
    this.fontFamily,
    this.suffixIcon,
    this.gradientColors,
    required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: TextButton(
        onPressed: loadingState || disabled ? null : pressed,
        style: TextButton.styleFrom(
          // disabledColor: Colors.orange,
          // disabledTextColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isOval ? 80.0 : 0.0)),
          padding: const EdgeInsets.all(0.0),
        ),
        child: Ink(
          width: MediaQuery.of(context).size.width * (widthRatio ?? 0.9),
          height: height ?? 50,
          decoration: BoxDecoration(
            color: color == null
                ? null
                : disabled || loadingState
                    ? color!.withOpacity(0.4)
                    : color,
            border: withBorder ? Border.all(color: Colors.white) : null,
            gradient: gradientColors != null
                ? LinearGradient(
                    colors: gradientColors!,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.all(Radius.circular(isOval ? 30 : 8)),
          ),
          child: loadingState
              ? Center(
                  child: Lottie.asset('assets/lottie/circleloader.json',
                      height: 220, width: 220),
                )
              : Container(
                  constraints: const BoxConstraints(
                      minWidth: 88.0,
                      minHeight: 36.0), // min sizes for Material buttons
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      suffixIcon??SizedBox(),
                      Constants.leftMargin(suffixIcon != null ? 6 : 0),
                      MyText.myText(
                        placeHolder,
                        // type: 'Normal',
                        fontFamily: fontFamily,
                        color:textColor?? Colors.white,
                      ),
                      Constants.leftMargin(child != null ? 12 : 0),
                      child ?? SizedBox(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
