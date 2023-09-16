import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:legal_edge/screens/LoginPage/login_page.dart';
import 'package:legal_edge/screens/profile_page/profile_page.dart';
import 'package:legal_edge/services/apis/post_api_handler.dart';
import 'package:legal_edge/services/auth/auth_services.dart';
import 'package:legal_edge/services/models/user_model.dart';
import 'package:legal_edge/utils/posts_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_consts/app_colors.dart';
import '../../services/apis/user_api_handler.dart';
import '../../services/models/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];
  List<NewPost> newPosts = [];
  List<String> likedBy = [];
  bool present = false;
  String? profilPic = FirebaseAuth.instance.currentUser?.photoURL;
  // final User user = FirebaseAuth.instance.currentUser!;

  void getPosts() async {
    posts = await PostApiHandler.getPosts();
    print('post: ${posts}');
    setState(() {
      if (posts.isNotEmpty) present = true;
    });
  }

  void getAllPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    newPosts = await PostApiHandler.getNewPosts(token);
    print('new post: ${newPosts}');
    setState(() {
      if (newPosts.isNotEmpty) present = true;
    }); //TODO : ye dekhna hai....
  }

  UserModle? userData;
  void getUser(String email) async {
    userData = await UserApiHandler.getUserByEmail(email);
    setState(() {});
  }

  void logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    setState(() {});
  }

  @override
  void initState() {
    getAllPosts();
    // getPosts();//Original get post from the previous version
    // print(user.email);
    // getUser(user.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.072,
        backgroundColor: AppColorsConstants.primaryBackgroundColor,
        elevation: 5,
        leading: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ProfilePage(
            //     userData: userData!,
            //   ),
            // ));
          },
          child: const CircleAvatar(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png'),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AuthServices().logOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.exit_to_app_outlined),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'LegalEdge',
          style: TextStyle(
            color: AppColorsConstants.tertiaryBlackColor,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: (present)
          ? RefreshIndicator(
              onRefresh: () async {
                getPosts();
                getAllPosts();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //TODO: add the get posts logic
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        // itemCount: posts.length,
                        itemCount: newPosts.length,
                        itemBuilder: (context, index) {
                          print(newPosts[index].title);
                          return RedditPostWidget(
                            email: newPosts[index].email ?? "",
                            id: newPosts[index].id!,
                            profilePhoto: newPosts[index].photoUrl,
                            // post: newPosts[index],
                            title: newPosts[index].title ?? "",
                            author: newPosts[index].name ?? "",
                            description: newPosts[index].desc ?? "",
                            time: newPosts[index].time ?? "",
                            // email: posts[index].email ?? "",
                            // id: posts[index].id!,
                            // profilePhoto: posts[index].profileP,
                            // post: posts[index],
                            // title: posts[index].title ?? "",
                            // author: posts[index].name ?? "",
                            // description: posts[index].description ?? "",
                            // time: posts[index].time ?? "",
                            // likedBy: posts[index].likedBy!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                getPosts();
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
