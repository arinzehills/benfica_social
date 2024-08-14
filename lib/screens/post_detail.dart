import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:benfica_social/utils/my_paddings.dart';
import 'package:benfica_social/widgets/comment_list.dart';
import 'package:benfica_social/widgets/no_items_widget.dart';
import 'package:benfica_social/widgets/post_list_item.dart';
import 'package:benfica_social/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key,required this.post});
  final Post post;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  void initState() {
    initPost();
    super.initState();
  }
  initPost()async{await PostService().getPost();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
            widget.post.title,
            style: TextStyle(color: Colors.black),
          ),
      ),
      body:   RefreshIndicator(
        onRefresh: () async{
          setState(() {
            
          });
        },
        child: FutureBuilder<Post?>(
                      future: PostService().getPost(postId: widget.post.id),
          builder: (context, snapshot) {
                        // if(!snapshot.hasData) return buildLoader();
                        // Post latestPost=snapshot.data!;
            return MyPaddings.responsivePadding(
                context,
              child: Column(
                  children: [
                    PostListItem(
                      showMore: true,
                      imageUrls: widget.post.imageUrls,
                      post:!snapshot.hasData?widget.post: snapshot.data!,title: widget.post.title, description: widget.post.description,
                    onLikePost: () async{
                            await PostService().likePost(postId: widget.post.id);
                          //  latestPost = (await PostService().getPost(postId: widget.post.id))!;
                                  setState(() =>{});
                     
                    },),
                     Expanded(child:!snapshot.hasData? SingleChildScrollView(child: buildLoader()): CommentsList(comments:snapshot.data!.comments))
                      
                  ],
            
              ),
            );
          }
        ),
      ),
    );
  }

  Column buildLoader() {
    return Column(
                      children: [
                        Skeleton(height: 150,),
                        Skeleton(height: 50,),
                        Skeleton(height: 50,),
                        Skeleton(height: 50,),
                      ],
                    );
  }
}