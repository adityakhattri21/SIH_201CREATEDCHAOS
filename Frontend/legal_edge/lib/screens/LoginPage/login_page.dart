import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:legal_edge/screens/form/forms.dart';
import 'package:legal_edge/screens/form_page.dart';
import 'package:legal_edge/screens/splash_screen.dart';
import 'package:legal_edge/services/auth/auth_services.dart';
import 'package:legal_edge/utils/posts_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController _pnumber = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(right: 30, left: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.05),
                Image.asset(
                  "asset/images/labelbg.png",
                  height: size.height * 0.11,
                  color: AppColorsConstants.purpleDark,
                ),
                SizedBox(height: size.height * 0.01),
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColorsConstants.textDark,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "With Legal Edge, unlock legal advise at your fingertips.",
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColorsConstants.textDark,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextFormField(
                      cursorColor: AppColorsConstants.purpleDark,
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColorsConstants.purpleDark),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFCCCCCC)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      " Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColorsConstants.textDark,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 7),
                    TextFormField(
                      cursorColor: AppColorsConstants.purpleDark,
                      onChanged: (value) {
                        pass = value;
                        // add value here for the email
                      },
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppColorsConstants.purpleDark),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFCCCCCC)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () async {
                    var res = await AuthServices.login(email, pass);
                    if (res['success'] == true) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      setState(() {
                        prefs.setString("token", res['token'].toString());
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                      print(prefs.getString("token"));
                    } else {
                      showSnackBar(context, res['message']);
                    }
                  },
                  child: Container(
                    height: size.height * 0.067,
                    // width: size.width * 0.65,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 111, 66, 193),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t have an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        ' Signup',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 253, 126, 20),
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FormScreen()));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.075,
                            width: size.height * 0.075,
                            decoration: const BoxDecoration(
                              color: AppColorsConstants.purpleLight,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.person_outline,
                                size: 35,
                              ),
                            ),
                          ),
                          const Text('User'),
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => const FormScreen()));
                    //   },
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         height: size.height * 0.075,
                    //         width: size.height * 0.075,
                    //         decoration: const BoxDecoration(
                    //           color: AppColorsConstants.purpleLight,
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Center(
                    //           child: Image.asset(
                    //             'asset/icons/notary.png',
                    //             height: 43,
                    //             // scale: 0.5,
                    //             fit: BoxFit.contain,
                    //           ),
                    //         ),
                    //       ),
                    //       const Text('Notary'),
                    //     ],
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LawyerFormScreen()));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.075,
                            width: size.height * 0.075,
                            decoration: const BoxDecoration(
                              color: AppColorsConstants.purpleLight,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'asset/icons/lawyer.png',
                                height: 43,
                                // scale: 0.5,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const Text('Lawyer'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
