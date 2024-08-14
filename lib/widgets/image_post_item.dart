import 'package:benfica_social/modals/deleteBottomSheet.dart';
import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

class ImagePostItem extends StatefulWidget {
  final String imageUrl;
  final double height;
  final Post? post;
void Function()? onClose;
  ImagePostItem(
      {required this.imageUrl,this.onClose, required this.post, required this.height});

  @override
  State<ImagePostItem> createState() => _ImagePostItemState();
}

class _ImagePostItemState extends State<ImagePostItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.height,
          // width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: widget.imageUrl.isEmpty
                  ? AssetImage('assets/images/defaultpost.jpg')
                  : NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconWidget(
            icon: Icons.more_vert,
            color: Colors.grey.withOpacity(0.5),
            iconColor: white,
            onTap: widget.onClose,
          ),
        ),
      ],
    );
  }
}
