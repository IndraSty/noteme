import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/url.dart';
import 'package:http/http.dart' as http;

import '../secrens/bot_navbar.dart';

class UserService {
  Future<void> register(BuildContext context, String name, String email,
      String password, String gender) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'gender': gender
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      throw ('Register failed!');
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      String refreshToken = response.headers['set-cookie']!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('refreshToken', refreshToken);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavbarScreen(selectedIndex: 0)));
    } else {
      throw ('Username or Password wrong');
    }
  }
}
