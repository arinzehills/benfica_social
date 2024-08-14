import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/providers/post_provider.dart';
import 'package:benfica_social/screens/login_screen.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:benfica_social/wrapper.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();

  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
          ChangeNotifierProvider(
      create: (_) => PostProvider(),)
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ToastProvider(child: Wrapper()),
    );
  }
}
