import 'dart:ui';

import 'package:benfica_social/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
 const  IconWidget({super.key,this.icon,this.svgImage, this.color,this.iconColor,this.onTap});
  final IconData? icon;
  final String? svgImage;
  final Color? color;
  final Color? iconColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        width: 40,
        height: 40,
      decoration: BoxDecoration(color:color?? const Color.fromARGB(255, 85, 80, 64).withOpacity(0.1),borderRadius: BorderRadius.circular(50)),
          child: Center(child:svgImage!=null?SvgPicture.asset(svgImage ?? 'assets/svg/chatsbubble.svg',
                height: 18,
                fit: BoxFit.fill,
                color: white,
): Icon(icon??Icons.more_vert,color: iconColor,)),
      ),
    );
  }
}