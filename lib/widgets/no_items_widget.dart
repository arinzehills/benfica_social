
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:flutter/material.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget(
      {Key? key,
      this.message,
      this.isComingSoon = false,
      this.showButton = false})
      : super(key: key);
  final bool isComingSoon, showButton;
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 230,
      padding: EdgeInsets.symmetric(vertical: 20),
      // color: Colors.red,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(46, 255, 134, 20),
            Color.fromARGB(46, 255, 134, 20),
          ], begin: Alignment.bottomCenter)),
      child: Column(
        children: [
          Image.asset('assets/images/default.png',height: 100,),
          SizedBox(
            height: 10,
          ), isComingSoon ? SizedBox() : MyText.myText(message ?? 'No Items',color: AppColors.primaryColorValue),
          SizedBox(
            height: 10,
          ),
          if (showButton)
            MyButton(
                placeHolder: isComingSoon ? "Coming Soon" : "Start",
                pressed: () {},
                isOval: true,
                widthRatio: 0.5,
                isGradientButton: true,
                gradientColors: AppColors.orangeGradient)
        ],
      ),
    );
  }
}
