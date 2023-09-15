import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:legal_edge/app_consts/api_consts.dart';

import '../models/post_model.dart';

class PostApiHandler {
  static Future<List<dynamic>> getPostsData() async {
    try {
      var uri = Uri.parse("https://hkmn-dev-new.onrender.com/api/V1/posts");
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      print('data: $data');
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['posts']) {
        temp.add(v);
      }
      return temp;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<Post>> getPosts() async {
    List temp = await getPostsData();
    return Post.postFromSnapshot(temp);
  }

  static Future likePost(String email, String postId) async {
    await http.post(
      Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/post/like/$postId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
        },
      ),
    );
  }

  static Future submitPost(
      String email, String title, String descrition) async {
    await http.post(
      Uri.parse('https://hkmn-dev-new.onrender.com/api/V1/post/create'),
      // Uri.parse('http://172.25.6.77:5000/api/V1/post/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'title': title,
          'userEmail': email,
          'desc': descrition,
        },
      ),
    );
  }

  static Future createPost(
      String time, String title, String description, String token) async {
    var res = await http.post(
      Uri.parse('http://$baseUrl:4000/post/create'),
      // Uri.parse('http://172.25.6.77:5000/api/V1/post/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(
        <String, String>{
          'heading': title,
          'time': time,
          'desc': description,
        },
      ),
    );
    return jsonDecode(res.body);
  }

  static Future<List<dynamic>> getAllPosts(String token) async {
    print('step 0');
    try {
      var uri = Uri.parse("http://$baseUrl:4000/post");
      var res = await http.get(uri, headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      });
      print('step 1');
      var data = jsonDecode(res.body);
      List temp = [];
      print('data: $data');
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['post']) {
        temp.add(v);
      }
      print('done');
      return temp;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<NewPost>> getNewPosts(String token) async {
    List temp = await getAllPosts(token);
    print('new posts got');
    return NewPost.postFromSnapshot(temp);
  }
}
