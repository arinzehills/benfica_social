import 'package:benfica_social/modals/edit_modal.dart';
import 'package:benfica_social/models/user.dart';
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/services/user_service.dart';
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:benfica_social/utils/my_paddings.dart';
import 'package:benfica_social/widgets/icon_widget.dart';
import 'package:benfica_social/widgets/my_button.dart';
import 'package:benfica_social/widgets/my_text.dart';
import 'package:benfica_social/widgets/radial-gradient.dart';
import 'package:benfica_social/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: MyText.myText('Profile Settings'),
      ),
      body: MyPaddings.responsivePaddingHorizontal(context,
          child: FutureBuilder<User?>(
            future:
                UserService().fetchUser(authProvider.user.id),
            builder: (context, snapshot) {
               if (!snapshot.hasData) {
                return buildLoader();
              }
              var fetchedUser = snapshot.data;
              return SingleChildScrollView(
                  child: Column(
                children: [
                  buildHeader(fetchedUser!.username),
                  Constants.topMargin(10),
                  buildUserItem(context,'username',fetchedUser.username),
                  buildUserItem(context,'email',fetchedUser.email),
                  // buildUserItem(''),
                  Constants.topMargin(10),
                  MyButton(
                    placeHolder: 'Logout',
                    pressed: () {
                      authProvider.logout();
                    },
                    widthRatio: 0.67,
                    isOval: true,
                  )
                ],
              ));
            }
          )),
    );
  }

  Widget buildLoader() {
    return Column(children: [Skeleton(height: 200,),Skeleton(),Skeleton(),],);
  }

  Container buildUserItem(context,label,value) {
    return Container(
      margin: EdgeInsets.all(5),
              decoration: roundedBoxDecoration,
              child:  ListTile(
                    title: MyText.myText(value),
                    subtitle: MyText.myText(label,color: Colors.grey,textSize: MyTextSize.small),
                 trailing: GestureDetector(
                  onTap: (){
                      buildEditPopup(context,label).then((onValue)=>setState(()=>{}));

                  },
                   child: const Icon(
                                  Icons.edit,
                                  size: 14,
                        ),
                 )
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
          Align(
            alignment: Alignment.centerLeft,
            child: IconWidget(
              icon: Icons.arrow_back,
              onTap: () => Get.back(),
            ),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
          ),
          Constants.topMargin(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.myText(username,
                  textSize: MyTextSize.medium, align: TextAlign.center),
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
}
