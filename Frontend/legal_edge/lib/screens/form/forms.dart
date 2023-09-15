import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legal_edge/services/apis/lawyer_api_handler.dart';
import 'package:legal_edge/services/apis/user_api_handler.dart';
import 'package:legal_edge/utils/posts_card.dart';

import '../../app_consts/app_colors.dart';
import '../../utils/form_utils.dart';
import '../form_page.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int activeStep = 1;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController adhaarController = TextEditingController();
  TextEditingController calendlyLinkController = TextEditingController();
  bool isChecked = false;
  List<String> cases = [];
  List<String> courts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    calendlyLinkController.dispose();
    passController.dispose();
    emailController.dispose();
    adhaarController.dispose();
    addressController.dispose();
    confirmController.dispose();
    genderController.dispose();
    contactController.dispose();
    cityController.dispose();
    postalController.dispose();
    regNoController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EasyStepper(
                activeStep: activeStep,
                lineLength: size.width * 0.22,
                lineThickness: 1,
                lineSpace: 5,
                stepRadius: 20,
                unreachedStepIconColor: Colors.black87,
                unreachedStepBorderColor: Colors.black54,
                unreachedStepTextColor: Colors.black,
                showLoadingAnimation: false,
                steps: const [
                  EasyStep(
                    icon: Icon(Icons.person),
                    title: 'Personal Details',
                    lineText: '',
                  ),
                  EasyStep(
                    icon: Icon(CupertinoIcons.cube_box),
                    title: 'Address Details',
                    lineText: '',
                  ),
                  EasyStep(
                    icon: Icon(CupertinoIcons.star),
                    title: 'Verification',
                  ),
                ],
                // onStepReached: (index) => setState(() => activeStep = index),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    if (activeStep == 1 || activeStep == 0)
                      Column(
                        children: [
                          NewFormFields(
                            controller: fnameController,
                            title: 'First Name',
                            hint: (fnameController.text.isEmpty)
                                ? 'First Name'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: lnameController,
                            title: 'Last Name',
                            hint: (lnameController.text.isEmpty)
                                ? 'Last Name'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: emailController,
                            title: 'Email',
                            hint:
                                (emailController.text.isEmpty) ? 'Email' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: genderController,
                            title: 'Gender',
                            hint: (genderController.text.isEmpty)
                                ? 'Gender'
                                : null,
                          ),
                          const SizedBox(height: 13),
                        ],
                      ),
                    if (activeStep == 2)
                      Column(
                        children: [
                          NewFormFields(
                            controller: contactController,
                            number: true,
                            title: 'Contact',
                            hint: (contactController.text.isEmpty)
                                ? 'Contact'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: cityController,
                            title: 'City',
                            hint: (cityController.text.isEmpty) ? 'City' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: addressController,
                            title: 'State',
                            hint: (addressController.text.isEmpty)
                                ? 'State'
                                : null,
                          ),
                          const SizedBox(height: 10),
                          NewFormFields(
                            controller: postalController,
                            title: 'Postal Code',
                            hint: (postalController.text.isEmpty)
                                ? 'Postal Code'
                                : null,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    if (activeStep == 3)
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage:
                                  const AssetImage('asset/images/avatar3.png'),
                              radius: size.height * 0.075,
                            ),
                          ),
                          NewFormFields(
                            controller: adhaarController,
                            title: 'Adhaar',
                            hint: 'Adhaar',
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: emailController,
                            title: 'Email',
                            hint:
                                (emailController.text.isEmpty) ? 'Email' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: passController,
                            title: 'Password',
                            hint: 'Password',
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: confirmController,
                            title: 'Confirm Password',
                            hint: 'Confirm Password',
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (activeStep != 1) {
                              setState(() {
                                activeStep--;
                              });
                            }
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: AppColorsConstants.tertiaryBlackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (activeStep < 3) {
                              setState(() {
                                activeStep++;
                              });
                            }
                          },
                          child: (activeStep != 3)
                              ? const Text(
                                  'Next',
                                  style: TextStyle(
                                    color:
                                        AppColorsConstants.secondaryPurpleColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    var res =
                                        await UserApiHandler.registerNewUser(
                                      fnameController.text.trim().toString(),
                                      lnameController.text.trim().toString(),
                                      int.parse(contactController.text.trim()),
                                      emailController.text.trim().toString(),
                                      passController.text.trim().toString(),
                                      cityController.text.trim().toString(),
                                      addressController.text.trim().toString(),
                                      postalController.text.trim().toString(),
                                      adhaarController.text.trim().toString(),
                                      genderController.text.trim().toString(),
                                    );
                                    if (res['success'] == false) {
                                      showSnackBar(
                                          context, res['message'].toString());
                                    }
                                  },
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                      color: AppColorsConstants
                                          .secondaryPurpleColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (activeStep == 1)
                      Image.asset(
                        'asset/images/user.png',
                        height: size.height * 0.3,
                      ),
                    if (activeStep == 2)
                      Image.asset(
                        'asset/images/bgaddress.png',
                        height: size.height * 0.3,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  /// Returns the next button.
  Widget _nextStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 < upperBound) {
          setState(() {
            if (enabling == StepEnabling.sequential) {
              ++activeStep2;
              if (reachedStep < activeStep2) {
                reachedStep = activeStep2;
              }
            } else {
              activeStep2 =
                  reachedSteps.firstWhere((element) => element > activeStep2);
            }
          });
        }
      },
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 > 0) {
          setState(() => enabling == StepEnabling.sequential
              ? --activeStep2
              : activeStep2 =
                  reachedSteps.lastWhere((element) => element < activeStep2));
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}

class LawyerFormScreen extends StatefulWidget {
  const LawyerFormScreen({super.key});

  @override
  State<LawyerFormScreen> createState() => _LawyerFormScreen();
}

class _LawyerFormScreen extends State<LawyerFormScreen> {
  int activeStep = 1;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController adhaarController = TextEditingController();
  TextEditingController calendlyLinkController = TextEditingController();
  bool isChecked = false;
  List<String> cases = [];
  List<String> courts = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    calendlyLinkController.dispose();
    passController.dispose();
    emailController.dispose();
    adhaarController.dispose();
    addressController.dispose();
    confirmController.dispose();
    genderController.dispose();
    contactController.dispose();
    cityController.dispose();
    postalController.dispose();
    regNoController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EasyStepper(
                activeStep: activeStep,
                lineLength: size.width * 0.16,
                lineThickness: 1,
                lineSpace: 5,
                stepRadius: 20,
                unreachedStepIconColor: Colors.black87,
                unreachedStepBorderColor: Colors.black54,
                unreachedStepTextColor: Colors.black,
                showLoadingAnimation: false,
                steps: const [
                  EasyStep(
                    icon: Icon(Icons.person_outline),
                    title: 'Personal Details',
                    lineText: '',
                  ),
                  EasyStep(
                    icon: Icon(CupertinoIcons.cube_box),
                    title: 'Address Details',
                    lineText: '',
                  ),
                  EasyStep(
                    icon: Icon(Icons.work_outline),
                    title: 'Lawyer Details',
                    lineText: '',
                  ),
                  EasyStep(
                    icon: Icon(CupertinoIcons.star),
                    title: 'Verification',
                  ),
                ],
                // onStepReached: (index) => setState(() => activeStep = index),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    if (activeStep == 1 || activeStep == 0)
                      Column(
                        children: [
                          NewFormFields(
                            controller: fnameController,
                            title: 'First Name',
                            hint: (fnameController.text.isEmpty)
                                ? 'First Name'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: lnameController,
                            title: 'Last Name',
                            hint: (lnameController.text.isEmpty)
                                ? 'Last Name'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: emailController,
                            title: 'Email',
                            hint:
                                (emailController.text.isEmpty) ? 'Email' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: genderController,
                            title: 'Gender',
                            hint: (genderController.text.isEmpty)
                                ? 'Gender'
                                : null,
                          ),
                          const SizedBox(height: 13),
                        ],
                      ),
                    if (activeStep == 2)
                      Column(
                        children: [
                          NewFormFields(
                            controller: contactController,
                            title: 'Contact',
                            hint: (contactController.text.isEmpty)
                                ? 'Contact'
                                : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: cityController,
                            title: 'City',
                            hint: (cityController.text.isEmpty) ? 'City' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: addressController,
                            title: 'State',
                            hint: (addressController.text.isEmpty)
                                ? 'State'
                                : null,
                          ),
                          const SizedBox(height: 10),
                          NewFormFields(
                            controller: postalController,
                            title: 'Postal Code',
                            hint: (postalController.text.isEmpty)
                                ? 'Postal Code'
                                : null,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    if (activeStep == 3)
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Discription: ',
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 13),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.4,
                                    color: AppColorsConstants.tertiaryBlackColor
                                        .withOpacity(0.6),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: TextField(
                                      maxLines: 6,
                                      controller: descController,
                                      decoration: InputDecoration(
                                        hintText: (descController.text.isEmpty)
                                            ? 'Discription'
                                            : null,
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: calendlyLinkController,
                            title: 'Calendly Link',
                            hint: 'Calendly Link',
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: regNoController,
                            title: 'Registration Number',
                            hint: 'Registration Number',
                          ),
                          const SizedBox(height: 13),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Courts: ',
                                      style: TextStyle(
                                        color: AppColorsConstants
                                            .tertiaryBlackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AddElementDialog(
                                              onAdd: (String element) {
                                                setState(() {
                                                  courts.add(element);
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Add Court',
                                        style: TextStyle(
                                          color: AppColorsConstants
                                              .tertiaryBlackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: courts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.circle_sharp,
                                          size: 13,
                                          color: AppColorsConstants
                                              .tertiaryBlackColor
                                              .withOpacity(0.7),
                                        ),
                                        title: Text(
                                          courts[index],
                                          style: const TextStyle(
                                            color: AppColorsConstants
                                                .tertiaryBlackColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              courts.remove(courts[index]);
                                            });
                                          },
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            size: 18,
                                            color: AppColorsConstants
                                                .tertiaryBlackColor
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    if (activeStep == 4)
                      Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage:
                                  const AssetImage('asset/images/avatar3.png'),
                              radius: size.height * 0.075,
                            ),
                          ),
                          NewFormFields(
                            controller: adhaarController,
                            title: 'Adhaar',
                            hint: 'Adhaar',
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: emailController,
                            title: 'Email',
                            hint:
                                (emailController.text.isEmpty) ? 'Email' : null,
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: passController,
                            title: 'Password',
                            hint: 'Password',
                          ),
                          const SizedBox(height: 13),
                          NewFormFields(
                            controller: confirmController,
                            title: 'Confirm Password',
                            hint: 'Confirm Password',
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (activeStep != 1) {
                              setState(() {
                                activeStep--;
                              });
                            }
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: AppColorsConstants.tertiaryBlackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (activeStep < 4) {
                              setState(() {
                                activeStep++;
                              });
                            }
                          },
                          child: (activeStep != 4)
                              ? const Text(
                                  'Next',
                                  style: TextStyle(
                                    color:
                                        AppColorsConstants.secondaryPurpleColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    var res = await LawyerApiHandler
                                        .registerNewLawyer(
                                      fnameController.text.toString().trim(),
                                      lnameController.text.toString().trim(),
                                      regNoController.text.toString().trim(),
                                      descController.text.toString().trim(),
                                      courts,
                                      int.parse(contactController.text.trim()),
                                      emailController.text.toString().trim(),
                                      passController.text.toString().trim(),
                                      cityController.text.toString().trim(),
                                      addressController.text.toString().trim(),
                                      postalController.text.toString().trim(),
                                      adhaarController.text.toString().trim(),
                                      genderController.text.toString().trim(),
                                    );
                                    if (res['success'] == false) {
                                      showSnackBar(context, res['message']);
                                    }
                                  },
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(
                                      color: AppColorsConstants
                                          .secondaryPurpleColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (activeStep == 1)
                      Image.asset(
                        'asset/images/user.png',
                        height: size.height * 0.3,
                      ),
                    if (activeStep == 2)
                      Image.asset(
                        'asset/images/bgaddress.png',
                        height: size.height * 0.3,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  /// Returns the next button.
  Widget _nextStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 < upperBound) {
          setState(() {
            if (enabling == StepEnabling.sequential) {
              ++activeStep2;
              if (reachedStep < activeStep2) {
                reachedStep = activeStep2;
              }
            } else {
              activeStep2 =
                  reachedSteps.firstWhere((element) => element > activeStep2);
            }
          });
        }
      },
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 > 0) {
          setState(() => enabling == StepEnabling.sequential
              ? --activeStep2
              : activeStep2 =
                  reachedSteps.lastWhere((element) => element < activeStep2));
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}

enum StepEnabling { sequential, individual }
