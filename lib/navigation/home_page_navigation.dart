
import 'package:benfica_social/main.dart';
import 'package:benfica_social/screens/homepage.dart';
import 'package:benfica_social/screens/profile_screen.dart';
import 'package:benfica_social/shared/shared_styles.dart';
import 'package:benfica_social/themes/colors.dart';
import 'package:benfica_social/widgets/radial-gradient.dart';
import 'package:benfica_social/widgets/upload_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/svg.dart';


class HomePageNavigation extends StatefulWidget {
  final int? index;

  const HomePageNavigation({Key? key, this.index}) : super(key: key);

  @override
  State<HomePageNavigation> createState() => HomePageationState();
}

class HomePageationState extends State<HomePageNavigation>
    with SingleTickerProviderStateMixin { 

  final PageStorageBucket _bucket = PageStorageBucket();
  late AnimationController _popup_animation_controller;
  bool get isForwardAnimation =>
      _popup_animation_controller.status == AnimationStatus.forward ||
      _popup_animation_controller.status == AnimationStatus.completed;
  late int _selectedIndex = widget.index ?? 0;
  bool showuploadPopup = false, loading = false;

  @override
  void initState() {
    _popup_animation_controller = AnimationController(
      value: 0,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 1000),
      vsync: this,
    )..addStatusListener((status) => {setState(() {})});
  }

  @override
  void dispose() {
    _popup_animation_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[
      Homepage(),
      // Purchased(),
     UserProfileScreen()
    ];
    return Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: Stack(
            children: [
              pages[_selectedIndex],
              showuploadPopup
                  ? Positioned(
                      bottom: 40,
                      right: size(context).width * 0.3,
                      left: size(context).width * 0.3,
                      child: uploadPopUp(_popup_animation_controller))
                  : SizedBox(),
            ],
          ),
        ),
          bottomNavigationBar: BottomAppBar(
          color: AppColors.primaryColorValue.withOpacity(0.07),
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.e,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bottomNavIcon(
                    number: 0,
                    name: 'Home',
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  bottomNavIcon(
                      name: 'Profile',
                      number: 1,
                      svgImage: 'assets/svg/profileicon.svg'),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            isForwardAnimation
                ? _popup_animation_controller.reverse()
                : _popup_animation_controller.forward();
            setState(() {
              showuploadPopup = !showuploadPopup;
            });
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => CreateRecord()));
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(15),
            child: SvgPicture.asset(
                !showuploadPopup
                    ? 'assets/svg/addicon.svg'
                    : 'assets/svg/arrowdown.svg',
                height: 20,
                fit: BoxFit.scaleDown,
                color: Colors.white,
                semanticsLabel: 'A red up arrow'),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.primaryColorValue,AppColors.primaryColorTransperent])),
          ),
        ));
  }

  Widget bottomNavIcon({
    name,
    number,
    svgImage,
  }) {
    return IconButton(
        // minWidth: 1,
        onPressed: () {
          setState(() {
            _selectedIndex = number;
          });
        },
        icon: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RadiantGradientMask(
            isGrey: _selectedIndex == number ? false : true,
            child: SvgPicture.asset(svgImage ?? 'assets/svg/homeicon.svg',
                height: 18,
                fit: BoxFit.fill,
                color: AppColors.iconsColor,
                semanticsLabel: 'A red up arrow'),
          ),
          _selectedIndex == number
              ? Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(name,
                      style: TextStyle(
                        color:
                            _selectedIndex == 0 ? AppColors.blue : Colors.grey,
                      )),
                )
              : SizedBox()
        ]));
  }
}
