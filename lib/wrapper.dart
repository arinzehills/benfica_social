import 'package:benfica_social/auth_wrapper.dart';
import 'package:benfica_social/main.dart';
import 'package:benfica_social/navigation/home_page_navigation.dart';
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthProvider>(
        builder: (context, AuthProvider authProvider, child) {

                      if (!authProvider.authenticated) {
                       return AuthWrapper();
                      }
                      else{
                       return  HomePageNavigation();
                      }
      }
    );
  }
}