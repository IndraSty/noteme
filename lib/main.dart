import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteme/authentication/authentication_controller.dart';
import 'package:noteme/constant/color_constant.dart';
import 'package:noteme/screens/add_new_task.dart';
import 'package:noteme/screens/bot_navbar.dart';
import 'package:noteme/screens/homepage.dart';
import 'package:noteme/screens/notes_screen.dart';
import 'package:noteme/screens/profile.dart';
import 'package:noteme/screens/sign_in.dart';
import 'package:noteme/screens/sign_up.dart';
import 'package:noteme/screens/splash_screen.dart';
import 'package:noteme/screens/task_screen.dart';
import 'package:noteme/screens/welcome_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const BottomNavbarScreen(
        selectedIndex: 0,
      ),
    );
  }
}
