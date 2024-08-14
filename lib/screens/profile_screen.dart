import 'package:benfica_social/modals/deleteBottomSheet.dart';
import 'package:benfica_social/models/user.dart';
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/post_detail.dart';
import 'package:benfica_social/screens/settings_screen.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:benfica_social/services/user_service.dart';
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/utils/get_random.dart';
import 'package:benfica_social/utils/my_paddings.dart';
import 'package:benfica_social/widgets/icon_widget.dart';
import 'package:benfica_social/widgets/image_post_item.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_navigate.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  String? userId;
  UserProfileScreen({this.userId});
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool loading = false;

  final List<Map<String, dynamic>> posts = [
    {"imageUrl": "https://picsum.photos/200/300", "height": 200.0},
    {"imageUrl": "https://picsum.photos/200/300", "height": 150.0},
    {"imageUrl": "https://picsum.photos/200/300", "height": 250.0},
    {"imageUrl": "https://picsum.photos/200/300", "height": 100.0},
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    // print(authProvider.user);
// return Container();
    return Scaffold(
      appBar: AppBar(
        title: MyText.myText('Profile Settings'),
      ),
      body: MyPaddings.responsivePaddingHorizontal(
        context,
        child: FutureBuilder<User?>(
            future:
                UserService().fetchUser(widget.userId ?? authProvider.user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return buildLoader();
              }
              var fetchedUser = snapshot.data;
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Header
                      buildHeader(fetchedUser!.username),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              suffixIcon: Icon(
                                Icons.person_add,
                                color: white,
                                size: 20,
                              ),
                              placeHolder: fetchedUser!.followers
                                      .contains(authProvider.user.id)
                                  ? "Unfollow"
                                  : 'Follow',
                              loadingState: loading,
                              pressed: () async {
                                setState(() => loading = true);
                                var res = await UserService().followUser();
                                setState(() => loading = false);
                              },
                              widthRatio: 0.4,
                              isOval: true,
                            ),
                            MyButton(
                              suffixIcon: SvgPicture.asset(
                                'assets/svg/chatsbubble.svg',
                                height: 10,
                              ),
                              placeHolder: 'Message',
                              textColor: black,
                              color: white,
                              pressed: () {},
                              widthRatio: 0.4,
                              isOval: true,
                            ),
                          ],
                        ),
                      ),
                      // Statistics
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buildAnalyticsItem("followers",
                                  fetchedUser!.totalFollowers, context),
                              buildAnalyticsItem(
                                  "Likes", fetchedUser.totalLikes, context),
                              buildAnalyticsItem("Posts",
                                  fetchedUser.posts.length.toString(), context),
                            ],
                          )),
                      // User Posts Grid
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: fetchedUser.posts.length,
                          itemBuilder: (context, index) {
                            var userPosts = fetchedUser.posts[index];
                            return GestureDetector(
                              onTap: () => Get.to(PostDetail(post: userPosts)),
                              child: ImagePostItem(
                                  imageUrl: userPosts.imageUrls.length < 1
                                      ? ''
                                      : userPosts.imageUrls.first,
                                  height: getRandom(),
                                  post: userPosts,
                                  onClose: () {
                                    showDeleteBottomSheet(context, userPosts)
                                        .then((val) => setState(() => {}));
                                  }),
                            );
                          },
                          // staggeredTileBuilder: (index) => StaggeredGridTile.fit(crossAxisCellCount: 1,child: Container(),),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildLoader() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Skeleton(
            height: size(context).height * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                height: 50,
                width: size(context).width * 0.32,
              ),
              Skeleton(
                height: 50,
                width: size(context).width * 0.32,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                height: 50,
                width: size(context).width * 0.22,
              ),
              Skeleton(
                height: 50,
                width: size(context).width * 0.22,
              ),
              Skeleton(
                height: 50,
                width: size(context).width * 0.22,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                height: 100,
                width: size(context).width * 0.39,
              ),
              Skeleton(
                height: 100,
                width: size(context).width * 0.39,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Skeleton(
                height: 100,
                width: size(context).width * 0.39,
              ),
              Skeleton(
                height: 100,
                width: size(context).width * 0.39,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildHeader(username) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: myBoxShadow,
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWidget(
                icon: Icons.arrow_back,
              ),
              IconWidget(
                onTap: () {
                  MyNavigate.navigatejustpush(SettingsScreen(), context);
                },
                icon: Icons.settings,
              ),
            ],
          ),
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          ),
          Constants.topMargin(11),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.myText(username,
                  textSize: MyTextSize.big, align: TextAlign.center),
              Icon(
                Icons.verified,
                color: AppColors.primaryColorTransperent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildAnalyticsItem(label, value, context) => Container(
        width: size(context).width * 0.25,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: white,
            boxShadow: myBoxShadow,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            MyText.myText(value,
                textSize: MyTextSize.medium, type: MyTextSize.big),
            MyText.myText(label,
                textSize: MyTextSize.small, color: AppColors.iconsColor),
          ],
        ),
      );
}
