import 'dart:io';
import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class PostService extends BaseService {

  PostService() {
    initialize();
  }
  Future<http.Response> addPost({
    required String title,
    required String description,
    List<File>? images,
  }) async {
    var user = await getuserFromStorage();

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/posts'));

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.headers['x-access-token'] = user!.token!;

    // Add image files to the request
    if (images != null && images.isNotEmpty) {
      for (var image in images) {
        var fileName = path.basename(image.path);

        request.files.add(await http.MultipartFile.fromPath(
          'images', // The key name for the image array
          image.path,
          filename: fileName,
        ));
      }
    }

    var response = await request.send();

    return await http.Response.fromStream(response);
  }
Future<http.Response> updatePost({
  required String id,
  required String title,
  required String description,
  List<File>? images,
}) async {
  var user = await getuserFromStorage();

  var url = Uri.parse('$baseUrl/posts/updatePost/$id');

  var request = http.MultipartRequest('POST', url);
  
  request.headers['x-access-token'] = user!.token!;
  request.fields['title'] = title;
  request.fields['description'] = description;

  // If images are needed, you can add them similarly as shown above
  if (images != null && images.isNotEmpty) {
    for (var image in images) {
      var fileName = path.basename(image.path);
      request.files.add(await http.MultipartFile.fromPath(
        'images', 
        image.path,
        filename: fileName,
      ));
    }
  }

  var response = await request.send();
  print("response at backend");
  print(response);
  return await http.Response.fromStream(response);
}

  Future<List<Post>> fetchPost(page, limit) async {
    try {
      var user = await getuserFromStorage();
      List<Post> _posts = [];
      var postsRes =
          await get('posts?page=$page&limit=10&token=${user!.token}');
      _posts.addAll((postsRes['posts'] as List<dynamic>)
          .map((postJson) => Post.fromJson(postJson))
          .toList());
      return _posts;
    } catch (e) {
      print("ERROR from post");
      Constants.showTaost(msg:resolveException(e)?? 'Error');
      print(e);
      return [];
    }
  }
Future  likePost({postId}) async {
    await getuserFromStorage();
    try {
       var postsRes =
          await post('posts/$postId/like',{});
           Constants.showTaost(msg:postsRes['message']?? 'Liked successfully');
    } catch (e) {
      print("Error" + e.toString());
      Constants.showTaost(msg:resolveException(e)?? 'Error in commenting check connection');
      return null;
    }
  }
  Future addComment({postId, comment}) async {
    var user = await getuserFromStorage();
    try {
      var postsRes = await post(
          'posts/${postId}/comments', {"comment": comment});
      print(postsRes);
      Constants.showTaost(msg: 'Commented successfully');
      Get.back();
    } catch (e) {
      Constants.showTaost(msg:resolveException(e)?? 'Error in commenting check connection');
    }
  }
  Future<Post?> getPost({postId}) async {
    await getuserFromStorage();

    try {
       var postsRes =
          await get('posts/$postId');
     return Post.fromJson(postsRes);
    } catch (e) {
      print("Error"+e.toString());
      Constants.showTaost(msg:resolveException(e)?? 'Error in commenting check connection');
      return null;
    }
  }
  Future  deletePost({postId}) async {
    await getuserFromStorage();
    try {
       var postsRes =
          await delete('posts/$postId');
           Constants.showTaost(msg:postsRes['message']?? 'Deleted successfully');
           Get.back();
    } catch (e) {
      print("Error" + e.toString());
      Constants.showTaost(msg:resolveException(e)?? 'Error in commenting check connection');
      return null;
    }
  }
}
