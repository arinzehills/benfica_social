import 'package:benfica_social/models/post.dart';

class User {
  String id;
  String username;
  String email;
  String? token;
  String profilePicture;
List<String> followers;
List<Map<String,dynamic>> populatedFollowers;
  String? totalFollowers;
  String? totalLikes;
  List<Post> posts;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.followers,
     this.populatedFollowers=const [],
    this.token,
    required this.totalFollowers,
    this.totalLikes,
    required this.posts,
  });

  // Factory constructor to create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    List<Map<String,dynamic>> populatedFollowers=[];
    json['populatedFollowers']?.forEach((option) {
      populatedFollowers.add(option);
    });
    return User(
      id: json['_id'],
      username: json['username'],
      totalFollowers: json['totalFollowers']??"",
      totalLikes: json['totalLikes']??"",
      email: json['email'],
      token:json['token'],
      profilePicture: json['profile_picture']??"",
      followers: List<String>.from(json['followers']),
      // followers: followers,
      populatedFollowers: populatedFollowers,
      // posts: []
      posts:json['posts'] == null?[]: ( json['posts'] as List)
          .map((post) => Post.fromJson(post))
          .toList(),
    );
  }

  // Method to convert a User object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'profile_picture': profilePicture,
      'followers': followers,
      'posts': posts.map((post) => post.toJson()).toList(),
    };
  }
}
