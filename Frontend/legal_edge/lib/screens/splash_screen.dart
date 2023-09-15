import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:legal_edge/app_consts/app_colors.dart';
import 'package:legal_edge/screens/Intern_Ipc_page/internship.dart';
import 'package:legal_edge/screens/LoginPage/login_page.dart';
import 'package:legal_edge/screens/main_auth_page.dart';
import 'package:legal_edge/screens/onboarding/onboard.dart';
import 'package:legal_edge/screens/posts_page.dart';
import 'package:legal_edge/screens/search_lawyer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'messages.dart';
import 'new_post.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String? finalEmail;
  bool allow = false;

  checkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenPresent = prefs.getString('token');
    if (tokenPresent != null && tokenPresent.isNotEmpty) {
      setState(() {
        allow = true;
      });
    }
    print(".......Token:  ..$tokenPresent..");
  }

  @override
  void initState() {
    checkData();
    Timer(
      const Duration(milliseconds: 1000),
      () => (allow)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "asset/icons/logo.png",
                  scale: 2,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Image.asset(
                "asset/images/labelbg.png",
                color: AppColorsConstants.purpleDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final screen = [
  const PostPage(),
  // const MessagesPage(),
  const SearchLawyerPage(),
  const InternshipPage(),
  const SearchLawyerPage(),
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorsConstants.primaryBackgroundColor,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NewPostPage(),
          ),
        ),
        child: const Icon(
          IconlyBold.plus,
          size: 40,
          color: AppColorsConstants.tertiaryBlackColor,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: AppColorsConstants.secondaryPurpleColor,
        unselectedItemColor: AppColorsConstants.textDark,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_open),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
        ],
        // type: BottomNavigationBarType.shifting,
        onTap: onItemTapped,
      ),
      body: screen[selectedIndex],
    );
  }
}
