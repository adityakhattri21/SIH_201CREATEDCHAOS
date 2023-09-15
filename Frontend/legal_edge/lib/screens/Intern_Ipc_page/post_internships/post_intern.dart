import 'package:flutter/material.dart';
import 'package:legal_edge/services/apis/internship_api_handler.dart';
import 'package:legal_edge/utils/posts_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_consts/app_colors.dart';
import '../../../utils/form_utils.dart';

class PostIntern extends StatefulWidget {
  const PostIntern({super.key});

  @override
  State<PostIntern> createState() => _PostInternState();
}

class _PostInternState extends State<PostIntern> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController respoController = TextEditingController();
  TextEditingController qualiController = TextEditingController();
  TextEditingController offerController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    respoController.dispose();
    qualiController.dispose();
    offerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Post Opportunity',
          style: TextStyle(
            color: AppColorsConstants.tertiaryBlackColor.withOpacity(0.8),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString('token')!;
                var res = await InternshipApiHandler.postOpportunity(
                  token,
                  titleController.text.trim().toString(),
                  descController.text.trim().toString(),
                  respoController.text.trim().toString(),
                  qualiController.text.trim().toString(),
                  offerController.text.trim().toString(),
                );
                if (res['success']) {
                  Navigator.of(context).pop();
                } else {
                  showSnackBar(context, res['message']);
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: AppColorsConstants.purpleDark.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 13),
                    NewFormFields(
                      controller: titleController,
                      title: 'Opportunity',
                      hint: 'Opportunity',
                    ),
                    const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' About Us: ',
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.4,
                              color: AppColorsConstants.tertiaryBlackColor
                                  .withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: TextField(
                                controller: descController,
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                maxLength: 250,
                                decoration: const InputDecoration(
                                  hintText: 'About Us',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' Responsibilities: ',
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.4,
                              color: AppColorsConstants.tertiaryBlackColor
                                  .withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: TextField(
                                controller: respoController,
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                maxLength: 250,
                                decoration: const InputDecoration(
                                  hintText: 'Responsibilities',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' Qualifications: ',
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.4,
                              color: AppColorsConstants.tertiaryBlackColor
                                  .withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: TextField(
                                controller: qualiController,
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                maxLength: 250,
                                decoration: const InputDecoration(
                                  hintText: 'Qualifications',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          ' What We Offer: ',
                          style: TextStyle(
                            color: AppColorsConstants.tertiaryBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.4,
                              color: AppColorsConstants.tertiaryBlackColor
                                  .withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: TextField(
                                controller: offerController,
                                keyboardType: TextInputType.text,
                                maxLines: 5,
                                maxLength: 250,
                                decoration: const InputDecoration(
                                  hintText: 'What We Offer',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
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
}
