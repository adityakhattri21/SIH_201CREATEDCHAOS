import 'dart:convert';
import 'dart:developer';

import 'package:legal_edge/services/models/lawyer_model.dart';
import 'package:http/http.dart' as http;

class LawyerApiHandler {
  static Future<List<dynamic>> getLawyerData() async {
    try {
      var uri = Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/lawyers');
      // var uri = Uri.parse('http://172.25.6.77:5000/api/v1/lawyers');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['lawyers']) {
        temp.add(v);
      }
      return temp;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<dynamic>> getLawyer(String? id) async {
    try {
      var uri =
          Uri.parse('https://hkmn-dev-new.onrender.com/api/v1/lawyers/$id');
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

  static Future<List<Lawyer>> getLawyers() async {
    List temp = await getLawyerData();
    print(temp);
    return Lawyer.lawyersFromSnapshot(temp);
  }

  static Future<List<Lawyer>> searchLawyers(String search) async {
    try {
      var uri = Uri.https(
          'hkmn-dev-new.onrender.com', '/api/v1/lawyers', {'name': search});
      // var uri = Uri.parse('http://172.25.6.77:5000/api/v1/lawyers');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['lawyers']) {
        temp.add(v);
      }
      return Lawyer.lawyersFromSnapshot(temp);
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<Lawyer>> searchLawyersByCity(String search) async {
    try {
      var uri = Uri.https(
          'hkmn-dev-new.onrender.com', '/api/v1/lawyers', {'city': search});
      // var uri = Uri.parse('http://172.25.6.77:5000/api/v1/lawyers');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['lawyers']) {
        temp.add(v);
      }
      return Lawyer.lawyersFromSnapshot(temp);
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<Lawyer>> searchLawyersByCases(String search) async {
    try {
      var uri = Uri.https(
          'hkmn-dev-new.onrender.com', '/api/v1/lawyers', {'cases': search});
      // var uri = Uri.parse('http://172.25.6.77:5000/api/v1/lawyers');
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['lawyers']) {
        temp.add(v);
      }
      return Lawyer.lawyersFromSnapshot(temp);
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<Lawyer>> searchLawyersByCourt(String court) async {
    try {
      var uri = Uri.https(
          'hkmn-dev-new.onrender.com', '/api/v1/lawyers', {'courts': court});
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List temp = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data['lawyers']) {
        temp.add(v);
      }
      return Lawyer.lawyersFromSnapshot(temp);
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future registerLawyer(
    String? profilePic,
    String? calendlyLink,
    String? name,
    String? email,
    String? address,
    String? city,
    String? regNo,
    List<String?>? cases,
    List<String?>? courts,
    String? contact,
    String? discription,
  ) async {
    await http.post(
      Uri.parse('https://hkmn-dev-new.onrender.com/api/V1/lawyer/register'),
      // Uri.parse('http://172.25.6.77:5000/api/V1/lawyer/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "url": profilePic,
          "name": name,
          "email": email,
          "city": city,
          "address": address,
          "regNo": regNo,
          "cases": cases,
          "courts": courts,
          "contact": contact,
          "desc": discription,
          "calendly": calendlyLink,
        },
      ),
    );
  }

  static Future registerNewLawyer(
    String? firstName,
    String? lastName,
    String? regId,
    String? bio,
    List<String?> courts,
    int? contact,
    String? email,
    String? password,
    String? city,
    String? state,
    String? postalCode,
    String? aadharNumber,
    String? gender,
  ) async {
    Uri uri = Uri.parse('http://192.168.1.6:4000/user/create');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          "userType": "lawyer",
          "firstName": firstName,
          "lastName": lastName,
          "regId": regId,
          "bio": bio,
          "courts": courts,
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
    // print('success');
    print(response.statusCode);
    print(response.body);
    return jsonDecode(response.body);
  }
}
