import 'package:flutter/material.dart';
import 'package:legal_edge/screens/opportunity_details/details_opps.dart';

import '../../app_consts/app_colors.dart';
import '../../app_consts/app_constants.dart';

class IPCSections extends StatelessWidget {
  final String title;
  final String description;
  const IPCSections(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '● $title',
          style: const TextStyle(
            color: AppColorsConstants.tertiaryBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            description,
            style: const TextStyle(
              color: AppColorsConstants.tertiaryBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class InternshipsTile extends StatelessWidget {
  final String name;
  final String id;
  final String email;
  final String time;
  final String title;
  final String desc;
  const InternshipsTile(
      {super.key,
      required this.name,
      required this.email,
      required this.time,
      required this.title,
      required this.desc,
      required this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          //TODO indvidual post page
          MaterialPageRoute(
            builder: (context) => OppsDetails(
                name: name,
                id: id,
                email: email,
                time: time,
                title: title,
                desc: desc),
          ),
        );
      },
      child: Container(
        width: size.width * 0.98,
        // height: 100,
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
          padding: const EdgeInsets.all(8.0).copyWith(top: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(AppConstantsProfile.defaultAvatar),
                        radius: 22,
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // var res = await AuthServices.login(email, pass);
                        // if (res['success'] == true) {
                        //   SharedPreferences prefs =
                        //       await SharedPreferences.getInstance();
                        //   setState(() {
                        //     prefs.setString("token", res['token'].toString());
                        //   });
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => const MainPage(),
                        //     ),
                        //   );
                        //   print(prefs.getString("token"));
                        // } else {
                        //   // showSnackBar(context, res['message']);
                        // }
                      },
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 111, 66, 193),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Apply Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
