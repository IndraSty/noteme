import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteme/routes/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  Future tokenAuth(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    if (token == null) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future getTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse(listTaskUrl),
      headers: {'Authorization': 'Bearer $token'},
    );
    print('ini status codenya: ${response.statusCode}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data;
    } else {
      throw ("Can't get the Task");
    }
  }

  Future detailTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('$detailTaskUrl$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw ("Can't get the task data");
    }
  }

  Future editTask(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    final response = await http.put(
      Uri.parse(editTaskUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
    } else {
      throw ("Can't Update Your Task");
    }
  }

  Future addTask(BuildContext context, String title, String todo, String time,
      String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    final response = await http.post(
      Uri.parse(addTaskUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'todoText': todo,
        'time': time,
        'category': category
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/task');
    } else {
      throw ('Add new task failed!');
    }
  }
}
