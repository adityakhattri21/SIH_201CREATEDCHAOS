import 'package:flutter/material.dart';
import 'package:legal_edge/screens/LoginPage/login_page.dart';
import 'package:legal_edge/services/auth/auth_services.dart';
import 'package:legal_edge/services/models/lawyer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_colors.dart';
import '../../app_consts/app_constants.dart';
import '../../services/apis/user_api_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = true;
  late String userType;
  late dynamic lawyer;
  late dynamic user;
  late List<dynamic> courts;
  late List<dynamic> appliedAt;
  late List<dynamic> internPosts;

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await UserApiHandler.getCurrentUser(prefs.getString("token")!);
    setState(() {
      userType = response['userType'];
      if (userType == 'lawyer') {
        lawyer = response['userData'];
        courts = response['userData']['courts'];
        appliedAt = response['userData']['appliedAt'];
        internPosts = response['userData']['internPosts'] ?? [];
        loading = false;
      } else {
        user = response['userData'];
        loading = false;
      }
    });
    print(response);
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsConstants.primaryBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        // elevation: 2,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColorsConstants.tertiaryBlackColor,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (userType == 'lawyer')
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: AppColorsConstants
                                .secondaryPurpleColor
                                .withOpacity(0.2),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                AppConstantsProfile.defaultAvatar,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          lawyer['firstName'] + ' ' + lawyer['lastName'],
                          style: const TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.05,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lawyer['email'],
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor
                                .withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.05,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          lawyer['bio'],
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor
                                .withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.05,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location: ',
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor
                                      .withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.05,
                                ),
                              ),
                              Text(
                                lawyer['city'] + ' ,' + lawyer['state'],
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor
                                      .withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.05,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            AuthServices().logOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColorsConstants.secondaryPurpleColor
                                  .withOpacity(0.3),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.logout_outlined),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                      color:
                                          AppColorsConstants.tertiaryBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.05,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Applied At:',
                              style: TextStyle(
                                color: AppColorsConstants.tertiaryBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: size.height * 0.35,
                          child: ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: size.width * 0.98,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0)
                                      .copyWith(left: 13, right: 13),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            appliedAt[index]['opening']
                                                ['heading'],
                                            style: const TextStyle(
                                              color: AppColorsConstants
                                                  .tertiaryBlackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            appliedAt[index]['appliedAt'],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        appliedAt[index]['opening']['desc'],
                                        style: const TextStyle(
                                          color: AppColorsConstants
                                              .tertiaryBlackColor,
                                          fontSize: 14,
                                          // fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Text('${appliedAt[index]}'),
                            itemCount: appliedAt.length,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Opportunities Created:',
                              style: TextStyle(
                                color: AppColorsConstants.tertiaryBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (internPosts.isNotEmpty)
                          SizedBox(
                            height: size.height * 0.35,
                            child: ListView.builder(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: size.width * 0.98,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0)
                                        .copyWith(left: 13, right: 13),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              internPosts[index]['heading'],
                                              style: const TextStyle(
                                                color: AppColorsConstants
                                                    .tertiaryBlackColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              internPosts[index]['createdAt'],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          internPosts[index]['desc'],
                                          style: const TextStyle(
                                            color: AppColorsConstants
                                                .tertiaryBlackColor,
                                            fontSize: 14,
                                            // fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Text('${appliedAt[index]}'),
                              itemCount: internPosts.length,
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: AppColorsConstants
                                .secondaryPurpleColor
                                .withOpacity(0.2),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                AppConstantsProfile.defaultAvatar,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user['firstName'] + ' ' + user['lastName'],
                          style: const TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.05,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user['email'],
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor
                                .withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.05,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Location: ',
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor
                                      .withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.05,
                                ),
                              ),
                              Text(
                                user['city'] + ' ,' + user['state'],
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor
                                      .withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.05,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            AuthServices().logOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: size.height * 0.06,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColorsConstants.secondaryPurpleColor
                                  .withOpacity(0.3),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.logout_outlined),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                      color:
                                          AppColorsConstants.tertiaryBlackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.05,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
