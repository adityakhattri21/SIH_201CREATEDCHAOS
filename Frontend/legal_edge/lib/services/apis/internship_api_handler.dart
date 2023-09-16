import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:legal_edge/app_consts/api_consts.dart';
import 'package:legal_edge/services/models/internship_model.dart';

class InternshipApiHandler {
  static Future<List<dynamic>> getAllInternships(String token) async {
    try {
      Uri uri = Uri.parse("http://$baseUrl:4000/job/all");
      var res = await http.get(uri, headers: <String, String>{
        'Authorization': token,
      });
      var data = jsonDecode(res.body);
      List temp = [];
      print('data: $data');
      if (res.statusCode != 200) {
        throw data["message"];
      }
      print('hewe');
      for (var v in data['posts']) {
        temp.add(v);
      }
      print('done');
      return temp;
    } catch (e) {
      log("An error occured $e.");
      throw e.toString();
    }
  }

  static Future<List<Internship>> getNewOpps(String token) async {
    List temp = await getAllInternships(token);
    print('new internships got');
    return Internship.oppsFromSnapshot(temp);
  }

  static Future<Internship> getOpps(String token, String postId) async {
    Uri url = Uri.parse('http://$baseUrl:4000/job/single/$postId');
    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': token,
      },
    );
    var res = jsonDecode(response.body);
    print(res);
    return Internship.fromJson(res['post']);
  }

  static Future postOpportunity(
    String token,
    String title,
    String desc,
    String responsibilities,
    String qualifications,
    String offers,
  ) async {
    Uri uri = Uri.parse('http://$baseUrl:4000/job/create');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(
        {
          "heading": title,
          "desc": desc,
          "responsibility": responsibilities,
          "qualifications": qualifications,
          "offers": offers,
        },
      ),
    );
    var res = jsonDecode(response.body);
    return res;
  }

  static Future applyTo(String token, String postId) async {
    Uri url = Uri.parse('http://$baseUrl:4000/job/apply');
    var res = await http.post(
      url,
      headers: <String, String>{
        "Authorization": token,
      },
      body: {
        "internId": postId,
      },
    );
    var response = jsonDecode(res.body);
    return response;
  }
}
