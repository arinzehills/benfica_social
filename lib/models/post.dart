import 'package:benfica_social/utils/format_image.dart';
import 'package:benfica_social/utils/mydate_formatter.dart';

class Post {
  String id;
  String title;
  String description;
  String imageUrl;
  DateTime createdAt;
  List<Comment> comments;
  List<String> imageUrls=[];
  int likes;
  String status;
  String assignedTo;

Post({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.imageUrls,
    required this.createdAt,
    required this.comments,
    required this.likes,
    required this.status,
    required this.assignedTo,
  });

  // Factory constructor to create a Post object from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    var urls= List<String>.from( json['image_urls'])
    .map((image)=>formatImageUrl(image))
    .toList();
    String assignedTo;
  if (json['assigned_to'] is String) {
    assignedTo = json['assigned_to'];
  } else if (json['assigned_to'] is Map) {
    assignedTo = json['assigned_to']['_id'];
  } else {
    assignedTo = ''; // Default value if assigned_to is neither String nor Map
  }
    return Post(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      imageUrls:urls,
      // imageUrls: json['image_urls'],
      createdAt: DateTime.parse(json['created_at']),
      // comments: [],
      comments: (json['comments'] as List).reversed
          .map((comment) => Comment.fromJson(comment))
          .toList(),
      likes: json['likes'],
      status: json['status'],
      assignedTo:assignedTo,
    );
  }

  // Method to convert a Post object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likes': likes,
      'status': status,
      'assigned_to': assignedTo,
    };
  }
}

class Comment {
  String user;
  String comment;
  String timestamp;

  Comment({
    required this.user,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      user: json['user']??'',
      comment: json['comment']??'',
      timestamp:
      MyDateFormatter.dateFormatter(
          datetime:
              DateTime.parse(json['timestamp'] ?? '2022-11-02 19:10:31.998691'),
        ),
      //  DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'comment': comment,
      // 'timestamp': timestamp.toIso8601String(),
    };
  }
}
