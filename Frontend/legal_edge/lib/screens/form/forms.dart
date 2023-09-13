// import 'package:cupertino_stepper/cupertino_stepper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class FormsPage extends StatefulWidget {
//   const FormsPage({super.key});

//   @override
//   State<FormsPage> createState() => _FormsPageState();
// }

// class _FormsPageState extends State<FormsPage> {
//   int currentStep = 0;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: Column(
//           children: [
//             // SizedBox(height: size.height * 0.04),
//             Expanded(
//               child: OrientationBuilder(
//                 builder: (BuildContext context, Orientation orientation) {
//                   switch (orientation) {
//                     case Orientation.landscape:
//                       return _buildStepper(StepperType.vertical);
//                     case Orientation.portrait:
//                       return _buildStepper(StepperType.horizontal);
//                     default:
//                       throw UnimplementedError(orientation.toString());
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   CupertinoStepper _buildStepper(StepperType type) {
//     final canCancel = currentStep > 0;
//     final canContinue = currentStep < 3;
//     return CupertinoStepper(
//       type: type,
//       currentStep: currentStep,
//       // onStepTapped: (step) => setState(() => currentStep = step),
//       onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
//       onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
//       //     onStepContinue: () {
//       //   if (currentStep < 3) {
//       //     setState(() {
//       //       currentStep++;

//       //     });
//       //   } else {
//       //     print(currentStep);
//       //   }
//       // },
//       steps: [
//         _buildStep(
//           title: const Text('Personal'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 0,
//           state: currentStep == 0
//               ? StepState.editing
//               : 0 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Container(color: Colors.black),
//         ),
//         _buildStep(
//           title: const Text('Address'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 1,
//           state: currentStep == 1
//               ? StepState.editing
//               : 1 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Container(color: CupertinoColors.systemGrey),
//         ),
//         _buildStep(
//           title: const Text('Verify'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 2,
//           state: currentStep == 2
//               ? StepState.editing
//               : 2 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Container(color: CupertinoColors.systemGrey),
//         ),
//       ],
//     );
//   }

//   Step _buildStep({
//     required Widget title,
//     required Widget subtitle,
//     required Widget child,
//     StepState state = StepState.indexed,
//     bool isActive = false,
//   }) {
//     return Step(
//       label: title,
//       title: title,
//       subtitle: subtitle,
//       state: state,
//       isActive: isActive,
//       content: LimitedBox(
//         maxWidth: 300,
//         maxHeight: 300,
//         child: child,
//       ),
//     );
//   }
// }

// import 'package:cupertino_stepper/cupertino_stepper.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../utils/form_utils.dart';

// class FormsPage extends StatefulWidget {
//   const FormsPage({Key? key}) : super(key: key);

//   @override
//   State<FormsPage> createState() => _FormsPageState();
// }

// class _FormsPageState extends State<FormsPage> {
//   int currentStep = 0;
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController contactController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController regNoController = TextEditingController();
//   TextEditingController descController = TextEditingController();
//   TextEditingController calendlyLinkController = TextEditingController();

//   // Variable to check if it's the final step
//   bool isFinalStep = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: OrientationBuilder(
//           builder: (BuildContext context, Orientation orientation) {
//             switch (orientation) {
//               case Orientation.landscape:
//                 return _buildStepper(StepperType.vertical);
//               case Orientation.portrait:
//                 return _buildStepper(StepperType.horizontal);
//               default:
//                 throw UnimplementedError(orientation.toString());
//             }
//           },
//         ),
//       ),
//     );
//   }

//   CupertinoStepper _buildStepper(StepperType type) {
//     final canCancel = currentStep > 0;
//     final canContinue = currentStep < 2;

//     return CupertinoStepper(
//       type: type,
//       currentStep: currentStep,
//       onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
//       onStepContinue: canContinue
//           ? () => setState(() => ++currentStep)
//           : () => Navigator.of(context).push(
//                 //TODO: Logic to shift pages
//                 MaterialPageRoute(
//                   builder: (context) => FinalPage(),
//                 ),
//               ),
//       steps: [
//         _buildStep(
//           title: const Text('Personal'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 0,
//           state: currentStep == 0
//               ? StepState.editing
//               : 0 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Column(
//             children: [
//               NewFormFields(
//                 controller: nameController,
//                 title: 'Name',
//                 hint: (nameController.text.isEmpty) ? 'Name' : null,
//               ),
//               const SizedBox(height: 13),
//               NewFormFields(
//                 controller: emailController,
//                 title: 'Email',
//                 hint: (emailController.text.isEmpty) ? 'Email' : null,
//               ),
//               const SizedBox(height: 13),
//               NewFormFields(
//                 controller: contactController,
//                 title: 'Contact',
//                 hint: (contactController.text.isEmpty) ? 'Contact' : null,
//               ),
//               const SizedBox(height: 13),
//             ],
//           ),
//         ),
//         _buildStep(
//           title: const Text('Address'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 1,
//           state: currentStep == 1
//               ? StepState.editing
//               : 1 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Container(color: CupertinoColors.systemGrey),
//         ),
//         _buildStep(
//           title: const Text('Verify'),
//           subtitle: const Text('Details'),
//           isActive: currentStep == 2,
//           state: currentStep == 2
//               ? StepState.editing
//               : 2 < currentStep
//                   ? StepState.complete
//                   : StepState.indexed,
//           child: Container(color: CupertinoColors.systemGrey),
//         ),
//       ],
//     );
//   }

//   Step _buildStep({
//     required Widget title,
//     required Widget subtitle,
//     required Widget child,
//     StepState state = StepState.indexed,
//     bool isActive = false,
//   }) {
//     return Step(
//       label: title,
//       title: title,
//       subtitle: subtitle,
//       state: state,
//       isActive: isActive,
//       content: LimitedBox(
//         maxWidth: 300,
//         maxHeight: 300,
//         child: child,
//       ),
//     );
//   }
// }

// // New Page to Navigate to on the Final Step
// class FinalPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text('Final Page'),
//       ),
//       child: Center(
//         child: Text('This is the final page!'),
//       ),
//     );
//   }
// }
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_consts/app_colors.dart';
import '../../utils/form_utils.dart';

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
                            controller: addressController,
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
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: isChecked,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isChecked = !isChecked;
                    //         });
                    //       },
                    //     ),
                    //     const Text(
                    //       'I am a Lawyer',
                    //       style: TextStyle(
                    //         color: AppColorsConstants.tertiaryBlackColor,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 13),
                    // if (isChecked)
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text(
                    //         'Discription: ',
                    //         style: TextStyle(
                    //           color: AppColorsConstants.tertiaryBlackColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Container(
                    //         height: size.height * 0.1,
                    //         width: size.width * 0.68,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             width: 1.4,
                    //             color: AppColorsConstants.tertiaryBlackColor
                    //                 .withOpacity(0.6),
                    //           ),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         child: Center(
                    //           child: Padding(
                    //             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //             child: TextField(
                    //               maxLines: 50,
                    //               controller: descController,
                    //               decoration: InputDecoration(
                    //                 hintText: (descController.text.isEmpty)
                    //                     ? 'Discription'
                    //                     : null,
                    //                 hintStyle: const TextStyle(
                    //                     color: Colors.grey, fontSize: 14),
                    //                 border: InputBorder.none,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // const SizedBox(height: 13),
                    // if (isChecked)
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text(
                    //         'Calendly Link: ',
                    //         style: TextStyle(
                    //           color: AppColorsConstants.tertiaryBlackColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Container(
                    //         height: size.height * 0.1,
                    //         width: size.width * 0.6,
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             width: 1.4,
                    //             color: AppColorsConstants.tertiaryBlackColor
                    //                 .withOpacity(0.6),
                    //           ),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         child: Center(
                    //           child: Padding(
                    //             padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    //             child: TextField(
                    //               maxLines: 10,
                    //               controller: calendlyLinkController,
                    //               decoration: const InputDecoration(
                    //                 hintText: 'Calendly Link',
                    //                 hintStyle: TextStyle(
                    //                   color: Colors.grey,
                    //                   fontSize: 14,
                    //                 ),
                    //                 border: InputBorder.none,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // const SizedBox(height: 13),
                    // if (isChecked)
                    //   FormFields(
                    //     controller: regNoController,
                    //     title: 'Reg No.',
                    //     hint: 'Registration No.',
                    //   ),
                    // const SizedBox(height: 13),
                    // if (isChecked)
                    //   SizedBox(
                    //     width: size.width,
                    //     height: size.height * 0.2,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const Text(
                    //               'Courts: ',
                    //               style: TextStyle(
                    //                 color: AppColorsConstants.tertiaryBlackColor,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 14),
                    //             ElevatedButton(
                    //               onPressed: () {
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (BuildContext context) {
                    //                     return AddElementDialog(
                    //                       onAdd: (String element) {
                    //                         setState(() {
                    //                           courts.add(element);
                    //                         });
                    //                       },
                    //                     );
                    //                   },
                    //                 );
                    //               },
                    //               child: const Text(
                    //                 'Add Court',
                    //                 style: TextStyle(
                    //                   color: AppColorsConstants.tertiaryBlackColor,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Expanded(
                    //           child: ListView.builder(
                    //             physics: const NeverScrollableScrollPhysics(),
                    //             shrinkWrap: true,
                    //             itemCount: courts.length,
                    //             itemBuilder: (BuildContext context, int index) {
                    //               return ListTile(
                    //                 leading: Icon(
                    //                   Icons.circle_sharp,
                    //                   size: 13,
                    //                   color: AppColorsConstants.tertiaryBlackColor
                    //                       .withOpacity(0.7),
                    //                 ),
                    //                 title: Text(
                    //                   courts[index],
                    //                   style: const TextStyle(
                    //                     color: AppColorsConstants.tertiaryBlackColor,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                 ),
                    //                 trailing: GestureDetector(
                    //                   onTap: () {
                    //                     setState(() {
                    //                       courts.remove(courts[index]);
                    //                     });
                    //                   },
                    //                   child: Icon(
                    //                     Icons.remove_circle_outline,
                    //                     size: 18,
                    //                     color: AppColorsConstants.tertiaryBlackColor
                    //                         .withOpacity(0.7),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // const SizedBox(height: 13),
                    // if (isChecked)
                    //   SizedBox(
                    //     width: size.width,
                    //     height: size.height * 0.2,
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const Text(
                    //               'Cases: ',
                    //               style: TextStyle(
                    //                 color: AppColorsConstants.tertiaryBlackColor,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             const SizedBox(width: 14),
                    //             ElevatedButton(
                    //               onPressed: () {
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (BuildContext context) {
                    //                     return AddElementDialog(
                    //                       onAdd: (String element) {
                    //                         setState(() {
                    //                           cases.add(element);
                    //                         });
                    //                       },
                    //                     );
                    //                   },
                    //                 );
                    //               },
                    //               child: const Text(
                    //                 'Add Cases',
                    //                 style: TextStyle(
                    //                   color: AppColorsConstants.tertiaryBlackColor,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         Expanded(
                    //           child: ListView.builder(
                    //             shrinkWrap: true,
                    //             physics: const NeverScrollableScrollPhysics(),
                    //             itemCount: cases.length,
                    //             itemBuilder: (BuildContext context, int index) {
                    //               return ListTile(
                    //                 leading: Icon(
                    //                   Icons.circle_sharp,
                    //                   size: 13,
                    //                   color: AppColorsConstants.tertiaryBlackColor
                    //                       .withOpacity(0.7),
                    //                 ),
                    //                 title: Text(
                    //                   cases[index],
                    //                   style: const TextStyle(
                    //                     color: AppColorsConstants.tertiaryBlackColor,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w400,
                    //                   ),
                    //                 ),
                    //                 trailing: GestureDetector(
                    //                   onTap: () {
                    //                     setState(() {
                    //                       cases.remove(cases[index]);
                    //                     });
                    //                   },
                    //                   child: Icon(
                    //                     Icons.remove_circle_outline,
                    //                     size: 18,
                    //                     color: AppColorsConstants.tertiaryBlackColor
                    //                         .withOpacity(0.7),
                    //                   ),
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),

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
                              : const Text(
                                  'Done',
                                  style: TextStyle(
                                    color:
                                        AppColorsConstants.secondaryPurpleColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
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
