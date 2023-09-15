import 'package:flutter/material.dart';
import 'package:legal_edge/services/apis/internship_api_handler.dart';
import 'package:legal_edge/services/models/internship_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_constants.dart';

class OppsDetails extends StatefulWidget {
  final String name;
  final String id;
  final String email;
  final String time;
  final String title;
  final String desc;
  const OppsDetails(
      {super.key,
      required this.name,
      required this.id,
      required this.email,
      required this.time,
      required this.title,
      required this.desc});

  @override
  State<OppsDetails> createState() => _OppsDetailsState();
}

class _OppsDetailsState extends State<OppsDetails> {
  Internship? opps;
  bool loading = true;

  void getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    var res = await InternshipApiHandler.getOpps(token, widget.id);
    setState(() {
      opps = res;
      loading = false;
    });
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(right: 13, left: 13),
              child: (loading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  AppConstantsProfile.defaultAvatar),
                              radius: 22,
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.email,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Opening : ${widget.title}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '● About Us',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.desc,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '● Key Responsibilities',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${opps?.responsibility}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '● Qualifications',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${opps?.qualifications}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '● What We Offer:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${opps?.offers}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: size.height * 0.1),
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
                                height: size.height * 0.065,
                                // width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 111, 66, 193),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Apply Now',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
