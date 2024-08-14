import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:benfica_social/screens/add_post.dart';
import 'package:benfica_social/widgets/icon_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget uploadPopUp(_controller) {
  return AnimatedBuilder(
    animation: _controller,
    builder: (context, child) => FadeScaleTransition(
      animation: _controller,
      child: child,
    ),
    child: Visibility(
      visible: _controller.status != AnimationStatus.dismissed,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 200,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 15,
                    blurRadius: 17,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Post',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                 IconWidget( 
                        icon: Icons.add,
                        onTap: () {
                          Get.to(AddPost());
                        }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}