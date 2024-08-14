import 'dart:io';

import 'package:flutter/material.dart';

class NetworkImageDisplay extends StatelessWidget {
  final List<String> images;

  NetworkImageDisplay({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return SizedBox();

    return Row(
      children: List.generate(images.length > 2 ? 3 : images.length, (index) {
        if (index < 2) {
          // Display the first three images
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Image.network(
              images[index],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          );
        } else {
          // Display the last container with a stack showing the remaining images count
          return Container(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  images[2],
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '+${images.length - 3}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
