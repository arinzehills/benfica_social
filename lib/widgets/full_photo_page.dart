
import 'package:benfica_social/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;
  final String? pageTitle;

  FullPhotoPage({Key? key, required this.url, this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorValue,
        title: Text(
          pageTitle ?? 'Full Photo',
          style: TextStyle(color: AppColors.primaryColorTransperent),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
