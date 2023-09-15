import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:legal_edge/app_consts/api_consts.dart';
import 'package:legal_edge/utils/posts_card.dart';

import '../models/user_model.dart';

class UserApiHandler {
  static Future<List<dynamic>> getUserData() async {
    try {
      var uri = Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/users');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        temp.add(v);
      }
      return temp;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<dynamic> getUser(String? id) async {
    try {
      var uri = Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/user/$id');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw data['message'];
      }
      return data;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<UserModle> getUserById(String id) async {
    var userData = getUser(id);
    return UserModle.userfromSnapshot(userData);
  }

  static Future<UserModle> getAllUsers() async {
    var userData = getUserData();
    return UserModle.userfromSnapshot(userData);
  }

  static Future<UserModle> getUserByEmail(String email) async {
    try {
      var uri = Uri.parse(
          'https://hkmn-dev-new.onrender.com/api/v1/user/find/$email');
      print(uri);
      var res = await http.get(uri);
      print('res: $res');
      var data = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw data["message"];
      }
      UserModle user = UserModle.fromjson(data["user"]);
      return user;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
    // try {
    //   var uri = Uri.parse('http://192.168.149.50:5000/api/v1/user/find/$email');
    //   // var uri = Uri.parse(
    //   //     'https://hkmn-dev-new.onrender.com/api/v1/user/find/$email');
    //   var res = await http.get(uri);
    //   var data = jsonDecode(res.body);
    //   if (res.statusCode != 200) {
    //     throw data['message'];
    //   }
    //   print('data: $data');
    //   print(User.fromjson(data));
    //   return User.fromjson(data);
    // } catch (e) {
    //   log("An error occured $e.");
    //   throw e.toString();
    // }
  }

  static Future registerUser(
      String name, String email, String number, String profilePicUrl) async {
    print('register');
    await http.post(
      Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/user/register'),
      // Uri.parse('http://172.25.6.77:5000/api/V1/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "url": profilePicUrl,
          "name": name,
          "email": email,
          "contact": number,
          "role": "User",
        },
      ),
    );
  }

  static Future registerNewUser(
    String? firstName,
    String? lastName,
    int? contact,
    String? email,
    String? password,
    String? city,
    String? state,
    String? postalCode,
    String? aadharNumber,
    String? gender,
  ) async {
    Uri uri = Uri.parse('http://$baseUrl:4000/user/create');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "userType": "user",
          "firstName": firstName,
          "lastName": lastName,
          "contact": contact,
          "email": email,
          "password": password,
          "city": city,
          "state": state,
          "postalCode": postalCode,
          "aadharNumber": aadharNumber,
          "gender": gender,
        },
      ),
    );
    print('success');
    print(response.statusCode);
    print(response.body);
    var res = jsonDecode(response.body);
    return res;
  }

  static Future getCurrentUser(String token) async {
    Uri uri = Uri.parse('http://$baseUrl:4000/user/me');
    var res = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": token,
      },
    );
    var response = jsonDecode(res.body);
    return response;
  }
}
