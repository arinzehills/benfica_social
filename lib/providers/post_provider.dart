import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchPosts({bool isRefresh = false}) async {
    print('ude run so');
    if (_isLoading) return;

    if (isRefresh) {
      _page = 1;
      _posts = [];
      _hasMore = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      List<Post> newPosts = await  PostService().fetchPost(_page,10);
      print('Post at provider');
      print(newPosts);
      if (newPosts.isNotEmpty) {
        _posts.addAll(newPosts);
        _page++;
      } else {
        _hasMore = false;
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      // Assuming you have a method to delete the post from the server
      // await deletePostFromApi(postId);
      _posts.removeWhere((post) => post.id == postId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
