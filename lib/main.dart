import 'package:flutter/material.dart';
import 'package:noteme/secrens/bot_navbar.dart';
import 'package:noteme/secrens/login_screen.dart';
import 'package:noteme/secrens/register_screen.dart';
import 'package:noteme/secrens/task_detail.dart';
import 'package:noteme/widgets/add_task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
