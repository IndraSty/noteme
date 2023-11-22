<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:noteme/secrens/bot_navbar.dart';
import 'package:noteme/secrens/login_screen.dart';
import 'package:noteme/secrens/register_screen.dart';
import 'package:noteme/secrens/task_detail.dart';
import 'package:noteme/widgets/add_task.dart';
import 'package:firebase_core/firebase_core.dart';
=======
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

>>>>>>> 75d05f9b86c7e77e973131dbd695befd4b9b6428
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
=======
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationController()));
>>>>>>> 75d05f9b86c7e77e973131dbd695befd4b9b6428
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/homepage': (context) => const BottomNavbarScreen(
              selectedIndex: 0,
            ),
        '/task': (context) => const BottomNavbarScreen(
              selectedIndex: 1,
            ),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const BottomNavbarScreen(
              selectedIndex: 3,
            ),
        '/detailTask': (context) => const TaskDetail(),
        '/addTask': (context) => const AddTask()
      },
      // home: const BottomNavbarScreen(
      //   selectedIndex: 0,
      // ),
      home: const LoginScreen(),
=======
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
>>>>>>> 75d05f9b86c7e77e973131dbd695befd4b9b6428
    );
  }
}
