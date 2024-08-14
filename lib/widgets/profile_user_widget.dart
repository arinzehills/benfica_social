
import 'package:benfica_social/models/user.dart';
import 'package:benfica_social/screens/profile_screen.dart';
import 'package:benfica_social/services/user_service.dart';
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/widgets/my_cachednetwork_image.dart';
import 'package:benfica_social/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUserWidget extends StatefulWidget {
  const ProfileUserWidget(
      {Key? key,
      required this.userId,
      this.comment,
      this.subTitle,
      this.imageUrl,
      this.imageHeight,
      this.imageWidth,
      this.headerFontSize = 17,
      this.containerWidthRatio = 0.85,
      this.skeltonWidth,
      this.tileGap,
      this.subTitleColor,
      this.isUtilityType = false,
      this.isCircular = true,
      this.isUserSubtitle = false,
      this.withGapBwText = false,
      this.showbgColor = true})
      : super(key: key);
  final String userId;
  final String? comment;
  final String? subTitle;
  final subTitleColor;
  final bool isCircular;
  final String? imageUrl;
  final containerWidthRatio;
  final double? imageHeight;
  final double? tileGap;
  final double? imageWidth;
  final double? skeltonWidth;
  final double? headerFontSize;
  final bool isUtilityType;
  final bool isUserSubtitle;
  final bool showbgColor;
  final bool withGapBwText;

  @override
  State<ProfileUserWidget> createState() => _ProfileUserWidgetState();
}

class _ProfileUserWidgetState extends State<ProfileUserWidget> {
  late User? user;
  bool loading = false;
  @override
  void initState() {
    print(widget.userId);
    _getUserFromNet();
  }

  _getUserFromNet() async {
    setState(() => {loading = true});
    Future.delayed(const Duration(seconds: 4));
    var value = await UserService().fetchUser(widget.userId);
    
    setState(() => user = value);
    setState(() => {loading = false});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0.6,
        bottom: 0.9,
      ),
      child: Container(
        // color: Colors.red,
        width: size(context).width * widget.containerWidthRatio,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: loading
              ? null
              : widget.showbgColor
                  ? Colors.black.withOpacity(0.01)
                  : null,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: _buildProfile(loading),
      ),
    );
  }

  Widget _buildProfile(loading) => loading || user == null
      ? Row(children: [
          Skeleton(
              width: widget.skeltonWidth ?? 50,
              height: widget.skeltonWidth ?? 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                width:
                    size(context).width * (widget.containerWidthRatio - 0.25),
              ),
              Skeleton(
                width:
                    size(context).width * (widget.containerWidthRatio - 0.35),
              ),
              widget.skeltonWidth == null
                  ? Skeleton(width: 80, height: 12)
                  : SizedBox(),
            ],
          ),
        ])
      : ListTile(
          // shape: RoundedRectangleBorder(
          //   side: BorderSide(width: 0.5, color: myhomepageBlue),
          // ),
          onTap: (() => Get.to(UserProfileScreen(userId: user!.id))),
          horizontalTitleGap: widget.tileGap,
          leading: GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.isCircular ? 50 : 10)),
              child: MyCachedNetworkImage(
                isProfile: true,
                height: widget.imageHeight ?? (widget.isUtilityType
                        ? 35
                        : 50),
                width: widget.imageWidth ?? (widget.isUtilityType
                        ? 35
                        : 50),
                imgUrl: widget.imageUrl ??
                    user!.profilePicture ??
                    'https://res.cloudinary.com/djsk1t9zp/image/upload/v1666397804/Books/haqv1lanbute2lb55w69.png',
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.comment ?? user!.username,
                overflow: TextOverflow.fade,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.headerFontSize != 17
                        ? widget.headerFontSize
                        : 14),
              ),
              SizedBox(height: widget.withGapBwText ? 10 : null),
              Text(
                (widget.isUserSubtitle
                    ? '${user!.username}, ${widget.subTitle}'
                    : widget.subTitle ?? 'February 21, 2022'),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: widget.subTitleColor ?? Colors.grey, fontSize: 13),
              ),
            ],
          ),
        );
}
