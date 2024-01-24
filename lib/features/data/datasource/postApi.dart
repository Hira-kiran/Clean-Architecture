// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/postApi_model.dart';
import 'package:http/http.dart' as http;

class ApiRequests {
  static const _baseUrl = "https://jsonplaceholder.typicode.com";
  static const _endPoint = "/posts";

  List<PostApiModel> postsList = [];
  Future<List<PostApiModel>> postApiMethod() async {
    try {
      Uri postUri = Uri.parse(_baseUrl + _endPoint);
      var response = await http.get(postUri);
      var data = jsonDecode(response.body.toString());
      if (kDebugMode) {
        print(data);
      }
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data) {
          postsList.add(PostApiModel.fromJson(i));
        }
      } else {
        return postsList;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return postsList;
  }
}
