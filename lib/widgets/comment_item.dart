import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final String userImageUrl;
  final String userName;
  final String comment;
  final String time;
  final int likes;

  CommentItem({
    required this.userImageUrl,
    required this.userName,
    required this.comment,
    required this.time,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
            radius: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Reply",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                          size: 16.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          likes.toString(),
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
