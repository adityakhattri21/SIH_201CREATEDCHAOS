import 'package:flutter/material.dart';
import 'package:legal_edge/services/apis/post_api_handler.dart';
import 'package:legal_edge/services/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_colors.dart';
import '../../app_consts/app_constants.dart';
import '../../services/apis/comment_api_handler.dart';
import '../../utils/input_field.dart';
import '../../utils/profile_utils.dart';

class IndividualPost extends StatefulWidget {
  const IndividualPost({super.key, required this.postId});
  final String postId;

  @override
  State<IndividualPost> createState() => _IndividualPostState();
}

class _IndividualPostState extends State<IndividualPost> {
  TextEditingController comment = TextEditingController();
  // List<Comment> comments = [];
  bool present = false;
  late NewPost postDetails;
  bool loading = true;
  // final user = FirebaseAuth.instance.currentUser;

  // void getComments() async {
  //   comments = await CommentApiHandler.getComments(widget.id);
  //   setState(() {
  //     if (comments.isNotEmpty) present = true;
  //   });
  // }

  // void addComment(String userEmail) async {
  //   if (comment.text.isNotEmpty) {
  //     CommentApiHandler.postComment(
  //         widget.id, comment.text.toString().trim(), userEmail);
  //   } else {
  //     //TODO: Add a snackbar to fill the comment
  //   }
  // }

  void getPostData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    postDetails = await PostApiHandler.getPostById(token, widget.postId);
    setState(() {
      loading = false;
    });
    print(postDetails);
  }

  @override
  void initState() {
    // getComments();
    getPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FocusNode focusNode = FocusNode();

    return Scaffold(
      backgroundColor: AppColorsConstants.primaryBackgroundColor,
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          // getComments();
          getPostData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: (!loading)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  AppConstantsProfile.defaultAvatar,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postDetails.name!,
                                style: const TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.05,
                                ),
                              ),
                              Text(
                                postDetails.time!,
                                style: TextStyle(
                                  color: AppColorsConstants.tertiaryBlackColor
                                      .withOpacity(0.7),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.05,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        postDetails.title!,
                        style: const TextStyle(
                          color: AppColorsConstants.tertiaryBlackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.05,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        postDetails.desc!,
                        style: const TextStyle(
                          color: AppColorsConstants.tertiaryBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.05,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // const CustomDivider(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Flexible(
                      //       flex: 1,
                      //       child: IconButton(
                      //         icon: const Icon(Icons.thumb_up),
                      //         onPressed: () {},
                      //       ),
                      //     ),
                      //     Flexible(
                      //       flex: 1,
                      //       child: IconButton(
                      //         icon: const Icon(Icons.comment),
                      //         onPressed: () => focusNode.requestFocus(),
                      //       ),
                      //     ),
                      //     Flexible(
                      //       flex: 1,
                      //       child: IconButton(
                      //         icon: const Icon(Icons.share),
                      //         onPressed: () {},
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const CustomDivider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InputField(
                            hinttext: 'Comment here',
                            focus: focusNode,
                            controller: comment,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              // addComment(user!.email!);
                              // comment.clear();
                            },
                            child: const Icon(Icons.send),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: size.width * 0.93,
                      //   child:
                      // (present)
                      //     ? Expanded(
                      //         child: ListView.builder(
                      //           reverse: true,
                      //           shrinkWrap: true,
                      //           physics: const NeverScrollableScrollPhysics(),
                      //           itemCount: comments.length,
                      //           itemBuilder: (context, index) {
                      //             return Padding(
                      //               padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      //               child: Container(
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white70,
                      //                   borderRadius: BorderRadius.circular(15),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.3),
                      //                       spreadRadius: 2,
                      //                       blurRadius: 4,
                      //                       offset: const Offset(0, 2),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Column(
                      //                     children: [
                      //                       GestureDetector(
                      //                         onTap: () {},
                      //                         child: Row(
                      //                           children: [
                      //                             CircleAvatar(
                      //                               backgroundImage: NetworkImage(
                      //                                   comments[index]
                      //                                           .profilePic ??
                      //                                       AppConstantsProfile
                      //                                           .defaultAvatar),
                      //                               radius: 16,
                      //                             ),
                      //                             const SizedBox(width: 8.0),
                      //                             SizedBox(
                      //                               width: size.width * 0.7,
                      //                               child: Column(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   Text(
                      //                                     comments[index].userName!,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 14.0,
                      //                                       fontWeight:
                      //                                           FontWeight.bold,
                      //                                     ),
                      //                                   ),
                      //                                   Text(
                      //                                     comments[index].time!,
                      //                                     style: const TextStyle(
                      //                                       fontSize: 10.0,
                      //                                       color: Colors.grey,
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ],
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: Align(
                      //                           alignment: Alignment.centerLeft,
                      //                           child: Text(
                      //                             comments[index].comment!,
                      //                             style: TextStyle(
                      //                               fontSize: 14.0,
                      //                               color: AppColorsConstants
                      //                                   .tertiaryBlackColor
                      //                                   .withOpacity(0.8),
                      //                               fontWeight: FontWeight.w500,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       )
                      //     :
                      // const Center(child: CircularProgressIndicator()),
                      // )
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
