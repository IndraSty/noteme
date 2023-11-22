import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:noteme/routes/url.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late String token;
  late String name;
  late int expire = 0;

  Future<void> updateToken() async {
    final currentDate = DateTime.now().millisecondsSinceEpoch;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshToken = prefs.getString('refreshToken')!;

    if (expire * 1000 < currentDate) {
      final response = await http.get(
        Uri.parse(tokenUrl),
        headers: {'Cookie': refreshToken},
      );

      final data = jsonDecode(response.body);
      token = data['accessToken'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('updateToken', token);

      final decodedToken = JwtDecoder.decode(token);
      name = decodedToken['name'];
      expire = decodedToken['expire'];

      print(name);
      print(expire);
    } else {
      return;
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
