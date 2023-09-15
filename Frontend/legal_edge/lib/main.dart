import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:legal_edge/screens/LoginPage/login_page.dart';
import 'package:legal_edge/screens/form/forms.dart';
import 'package:legal_edge/screens/main_auth_page.dart';
import 'package:legal_edge/screens/posts_page.dart';
import 'package:legal_edge/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_consts/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyACMClGpjlLPknRiM7MijokmjX3jXf_dMM',
      appId: '1:275560008515:android:50b532fe33a1255c493df6',
      messagingSenderId: '275560008515',
      projectId: 'hackman-56feb',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor:
              AppColorsConstants.primaryBackgroundColor.withOpacity(0.2),
        ),
      ),
      routes: {
        "/posts": (context) => const PostPage(),
      },
      // home: const FormScreen(),
      // home: const LoginPage(),
      home: const SplashScreenPage(),
      // home: const MainAuthPage(), //Legal Edge Og
    );
  }
}
