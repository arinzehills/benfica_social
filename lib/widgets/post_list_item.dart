import 'package:benfica_social/modals/deleteBottomSheet.dart';
import 'package:benfica_social/models/post.dart';
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/add_comment.dart';
import 'package:benfica_social/screens/post_detail.dart';
import 'package:benfica_social/services/post_service.dart';
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/utils/format_image.dart';
import 'package:benfica_social/widgets/icon_widget.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/myslider.dart';
import 'package:benfica_social/widgets/profile_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatefulWidget {
  final String title;
  final List<String> imageUrls;
  final String description;
  final Post? post;
  final bool showMore;
final void Function()? onLikePost;
  const PostListItem({
    Key? key,
    required this.title,
    required this.post,
    this.onLikePost,
    this.showMore=false,
    this.imageUrls = const [],
    required this.description,
  }) : super(key: key);

  @override
  _PostListItemState createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  bool isDescriptionExpanded = false;
  
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    
    return GestureDetector(
      onTap: () => Get.to(() => PostDetail(post: widget.post!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
        
              // Image carousel or placeholder if empty
              Wrap(
// crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     ProfileUserWidget(userId: authProvider.user.id,containerWidthRatio: 0.7,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: size(context).height * 0.5,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(50)),
                      width: double.infinity,
                      child: widget.post!.imageUrls.isEmpty
                          ? Image.asset(
                              'assets/images/defaultpost.jpg', // Placeholder image asset
                              fit: BoxFit.cover,
                            )
                          : MySlider(imageUrls: widget.imageUrls,)
                    ),
                  ),
                ],
              ),
              
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:30.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // Icons on the right
              Positioned(
                top: 76,
                right: 16,
                child: Column(
                  children: [
                   if(widget.showMore && widget.post!.assignedTo==authProvider.user.id) IconWidget(
                      icon: Icons.more_vert,
                      iconColor: white,
                      onTap: () {
                           showDeleteBottomSheet(context, widget.post!)
                           .then((val) => {
                           Navigator.pop(context),
                           setState(() => {})}
                           );;
                      },
                    ),
                    Constants.topMargin(10),
                    IconWidget(
                      svgImage: 'assets/svg/chatsbubble.svg',
                      onTap: () {
                        Get.to(AddComment(
                          post: widget.post,
                        ));
                      },
                    ),
                  ],
                ),
              ),
              // Like button on the left
              Positioned(
                top: 76,
                left: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4,vertical: 15),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 85, 80, 64)
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      IconWidget(
                        icon: Icons.favorite_border,
                        color: Colors.white,
                        onTap:widget.onLikePost ,
                      ),
                      Constants.topMargin(10),
                     MyText.myText(widget.post!.likes.toString(),color: white),
                     MyText.myText("likes",textSize: MyTextSize.small),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Expandable description section
          Constants.topMargin(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedCrossFade(
              firstChild: Text(
                widget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: Text(widget.description),
              crossFadeState: isDescriptionExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 200),
            ),
          ),
          Constants.topMargin(10),

          if (widget.description.length > 80)
            TextButton(
              onPressed: () {
                setState(() {
                  isDescriptionExpanded = !isDescriptionExpanded;
                });
              },
              child: Text(isDescriptionExpanded ? "View Less" : "View More"),
            ),
        ],
      ),
    );
  }
}
