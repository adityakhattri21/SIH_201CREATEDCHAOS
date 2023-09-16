import 'package:flutter/material.dart';
import 'package:legal_edge/screens/Intern_Ipc_page/post_internships/post_intern.dart';
import 'package:legal_edge/screens/Intern_Ipc_page/utils.dart';
import 'package:legal_edge/screens/main_auth_page.dart';
import 'package:legal_edge/services/apis/internship_api_handler.dart';
import 'package:legal_edge/services/apis/lawyer_api_handler.dart';
import 'package:legal_edge/services/apis/user_api_handler.dart';
import 'package:legal_edge/services/models/internship_model.dart';
import 'package:legal_edge/services/models/lawyer_model.dart';
import 'package:legal_edge/utils/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_colors.dart';
import '../../app_consts/app_constants.dart';
import '../../utils/list_tile.dart';
import '../../utils/posts_card.dart';

class InternshipPage extends StatefulWidget {
  const InternshipPage({super.key});

  @override
  State<InternshipPage> createState() => _InternshipPageState();
}

class _InternshipPageState extends State<InternshipPage> {
  TextEditingController searchController = TextEditingController();
  List<Lawyer> lawyers = [];
  List<Lawyer> users = [];
  bool present = false;
  bool city = false;
  bool courts = false;
  bool cases = false;
  String? userType = '';
  bool showOpps = false;
  List<Internship> opps = [];
  bool loading = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void getLawyers() async {
    lawyers = await LawyerApiHandler.getLawyers();
    setState(() {
      if (lawyers.isNotEmpty) present = true;
    });
  }

  void getUsers() async {
    users = await UserApiHandler.getUser(null);
    setState(() {
      if (lawyers.isNotEmpty) present = true;
    });
  }

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await UserApiHandler.getCurrentUser(prefs.getString("token")!);
    setState(() {
      userType = response['userType'];
      loading = false;
    });
    print(response);
    if (userType == 'lawyer') {
      getAllOpps();
    }
  }

  void searchLawyers(String search) async {
    setState(() {
      lawyers.clear();
    });
    if (cases && search.isNotEmpty) {
      lawyers = await LawyerApiHandler.searchLawyersByCases(search);
      print(lawyers);
      setState(() {
        if (lawyers.isNotEmpty) {
          present = true;
        } else {
          present = false;
        }
      });
    } else if (courts && search.isNotEmpty) {
      lawyers = await LawyerApiHandler.searchLawyersByCourt(search);
      print(lawyers);
      setState(() {
        if (lawyers.isNotEmpty) {
          present = true;
        } else {
          present = false;
        }
      });
    } else if (city && search.isNotEmpty) {
      lawyers = await LawyerApiHandler.searchLawyersByCity(search);
      print(lawyers);
      setState(() {
        if (lawyers.isNotEmpty) {
          present = true;
        } else {
          present = false;
        }
      });
    } else if (cases && search.isNotEmpty) {
      lawyers = await LawyerApiHandler.searchLawyersByCases(search);
      print(lawyers);
      setState(() {
        if (lawyers.isNotEmpty) present = true;
      });
    } else if (search.isNotEmpty) {
      lawyers = await LawyerApiHandler.searchLawyers(search);
      setState(() {
        if (lawyers.isNotEmpty) present = true;
      });
    } else {
      lawyers = await LawyerApiHandler.getLawyers();
      setState(() {
        if (lawyers.isNotEmpty) present = true;
      });
    }
  }

  void getAllOpps() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token')!;
    var res = await InternshipApiHandler.getNewOpps(token);
    setState(() {
      opps = res;
    });
  }

  @override
  void initState() {
    getCurrentUser();
    getLawyers();
    super.initState();
  }

  bool showCyber = false;
  bool showCivil = false;
  bool showFamily = false;
  bool showCorporate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (userType != 'lawyer')
            ? const Text(
                'IPC Sections',
                style: TextStyle(
                  color: AppColorsConstants.tertiaryBlackColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              )
            : const Text(
                'Opportunities',
                style: TextStyle(
                  color: AppColorsConstants.tertiaryBlackColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
        actions: [
          if (userType == 'lawyer')
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PostIntern(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add, size: 26),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (userType == 'lawyer') {
            return getAllOpps();
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (loading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (userType != 'lawyer')
                    ? Column(
                        children: [
                          (!showCyber)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showCyber = true;
                                    });
                                  },
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Some IPC Sections for Cybercrime',
                                            style: TextStyle(
                                              color: AppColorsConstants
                                                  .tertiaryBlackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_outlined,
                                              size: 28)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // height: 100,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showCyber = false;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Some IPC Sections for Cybercrime',
                                                style: TextStyle(
                                                  color: AppColorsConstants
                                                      .tertiaryBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_up_outlined,
                                                  size: 28)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const IPCSections(
                                          title: 'Section 66A',
                                          description:
                                              'Punishment for sending offensive messages through communication services, including social media, and was used to address online harassment and offensive content.',
                                        ),
                                        const IPCSections(
                                            title: 'Section 66C',
                                            description:
                                                'Identity theft, specifically the use of another person\'s identity for fraudulent purposes, often seen in cases of online fraud and impersonation.'),
                                        const IPCSections(
                                            title: 'Section 66D',
                                            description:
                                                'Cheating or fraud where individuals use computer resources or electronic means to impersonate someone else, often leading to financial frauds and scams.'),
                                        const IPCSections(
                                            title: 'Section 43',
                                            description:
                                                'Unauthorized access to computer material, which includes cases of hacking, data breaches, and unauthorized access to computer systems or networks.'),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          (!showCivil)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showCivil = true;
                                    });
                                  },
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Some IPC Sections for Civil Cases',
                                            style: TextStyle(
                                              color: AppColorsConstants
                                                  .tertiaryBlackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_outlined,
                                              size: 28)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // height: 100,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showCivil = false;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Some IPC Sections for Civil Cases',
                                                style: TextStyle(
                                                  color: AppColorsConstants
                                                      .tertiaryBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_up_outlined,
                                                  size: 28)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const IPCSections(
                                          title: 'Section 9',
                                          description:
                                              'Provides protection to individuals who act in good faith under the authority of the law but without proper justification, preventing them from being held liable for civil damages.',
                                        ),
                                        const IPCSections(
                                          title: 'Section 95',
                                          description:
                                              'Renders agreements by way of wager (gambling) void and unenforceable in civil courts, ensuring that gambling-related disputes cannot be legally enforced.',
                                        ),
                                        const IPCSections(
                                          title: 'Section 96',
                                          description:
                                              'Allows individuals to use reasonable force to protect themselves or their property in cases of self-defense, protecting them from civil liability for such actions.',
                                        ),
                                        const IPCSections(
                                          title: 'Section 105',
                                          description:
                                              'Places the burden of proof on the accused to establish that their case falls within exceptions or defenses provided by law, such as the law of self-defense or accident, in civil cases.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          (!showFamily)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showFamily = true;
                                    });
                                  },
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Some IPC Sections for Family Cases',
                                            style: TextStyle(
                                              color: AppColorsConstants
                                                  .tertiaryBlackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_outlined,
                                              size: 28)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // height: 100,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showFamily = false;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Some IPC Sections for Family Cases',
                                                style: TextStyle(
                                                  color: AppColorsConstants
                                                      .tertiaryBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_up_outlined,
                                                  size: 28)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const IPCSections(
                                          title: 'Section 498A',
                                          description:
                                              'This section deals with cases of cruelty and harassment by a husband or his relatives against a married woman, often related to dowry demands.',
                                        ),
                                        const IPCSections(
                                          title: 'Section 306',
                                          description:
                                              'Pertains to cases where someone abets or encourages another person to commit suicide, which can include situations arising from family disputes and mental distress.',
                                        ),
                                        const IPCSections(
                                            title: 'Section 494',
                                            description:
                                                'This section addresses cases of bigamy, where a person marries another individual while their spouse is still alive and the first marriage is subsisting.'),
                                        const IPCSections(
                                            title: 'Section 497',
                                            description:
                                                'Deals with cases of adultery, making it an offense for a man to have sexual relations with the wife of another man without the latter\'s consent.'),
                                      ],
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          (!showCorporate)
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showCorporate = true;
                                    });
                                  },
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Some IPC Sections for Corporate Cases',
                                            style: TextStyle(
                                              color: AppColorsConstants
                                                  .tertiaryBlackColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_outlined,
                                              size: 28)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  // height: 100,
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
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showCorporate = false;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Some IPC Sections for Corporate Cases',
                                                style: TextStyle(
                                                  color: AppColorsConstants
                                                      .tertiaryBlackColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Icon(Icons.arrow_drop_up_outlined,
                                                  size: 28)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const IPCSections(
                                          title: 'Section 420',
                                          description:
                                              'This section deals with cases of cheating and fraud in which a person dishonestly induces another person to deliver property or valuable assets, often relevant in corporate fraud cases.',
                                        ),
                                        const IPCSections(
                                            title: 'Section 406',
                                            description:
                                                'Pertains to cases of criminal breach of trust, where a person entrusted with property or assets for a specific purpose misappropriates or breaches that trust, including instances involving corporate funds or assets.'),
                                        const IPCSections(
                                            title: 'Section 463',
                                            description:
                                                'This section covers offenses related to forgery, including making false documents or electronic records with the intent to harm or deceive, which can be relevant in cases involving forged corporate documents.'),
                                        const IPCSections(
                                            title: 'Section 120B',
                                            description:
                                                'Addresses criminal conspiracy, where two or more individuals agree to commit a criminal act, making it applicable in cases of corporate conspiracies or white-collar crimes involving multiple actors.'),
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(height: size.height * 0.1),
                        ],
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => InternshipsTile(
                            desc: opps[index].desc ?? "",
                            id: opps[index].id ?? "",
                            name: opps[index].name ?? "",
                            email: opps[index].email ?? "",
                            time: opps[index].time ?? "",
                            title: opps[index].heading ?? "",
                          ),
                          itemCount: opps.length,
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 13);
                          },
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
