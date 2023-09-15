import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:legal_edge/app_consts/app_colors.dart';
import 'package:legal_edge/screens/messages.dart';
import 'package:legal_edge/screens/onboarding/onboard.dart';
import 'package:legal_edge/screens/posts_page.dart';
import 'package:legal_edge/screens/search_lawyer_page.dart';
import 'package:legal_edge/screens/sign_in.dart';
import 'package:legal_edge/screens/splash_screen.dart';
import 'package:legal_edge/services/models/user_model.dart';
import 'new_post.dart';
import 'onboarding/onboarding_first.dart';

class MainAuthPage extends StatelessWidget {
  const MainAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const OnBoarding();
          }
        },
      ),
    );
  }
}

final User user = FirebaseAuth.instance.currentUser!;
UserModle? userData;
