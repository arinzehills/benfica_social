import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/widgets/comment_item.dart';
import 'package:benfica_social/widgets/no_items_widget.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
    List<Comment> comments;
    CommentsList({super.key,required this.comments});




  final List<Map<String, dynamic>> commentss = [
    {
      'userImageUrl': 'https://via.placeholder.com/150',
      'userName': 'Marvin McKinney',
      'comment': 'Finally! Congratulations on completing the project.',
      'time': 'today at 6:41',
      'likes': 173,
    },
    // Add more comments here
  ];

  @override
  Widget build(BuildContext context) {
    return 
    comments.isEmpty?SingleChildScrollView(child: const NoItemsWidget(message: "No Comments for this post",)):
    ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return CommentItem(
          userImageUrl: commentss[0]['userImageUrl'],
          userName: commentss[0]['userName'],
          comment: comment.comment,
          time: comment.timestamp,
          likes: commentss[0]['likes'],
        );
      },
    );
  }
}
