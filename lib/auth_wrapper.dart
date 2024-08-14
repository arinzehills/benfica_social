import 'package:benfica_social/main.dart';
import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:benfica_social/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<AuthProvider>(
        builder: (context, AuthProvider authProvider, child) {
                      
                      if (authProvider.showregScreen) {
                       return RegisterScreen();
                      }
                      else{
                       return  LoginScreen();
                      }
      }
    );
  }
}