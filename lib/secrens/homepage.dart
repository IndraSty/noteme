import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/routes/url.dart';
import 'package:noteme/service/auth_service.dart';
import 'package:noteme/service/task_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/color_style.dart';
import '../components/screen_size.dart';
import '../components/text_style.dart';
import '../widgets/task_card.dart';
import 'bot_navbar.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onLongPress = false;
  String token = '';
  String name = '';
  int expire = 0;
  Map<String, dynamic> users = {};
  TaskService client = TaskService();
  AuthService auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshToken();
    getUser();
    // client.getTask();
  }

  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String refreshToken = prefs.getString('refreshToken')!;
    final response = await http.get(
      Uri.parse(tokenUrl),
      headers: {'Cookie': refreshToken},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedToken = jsonDecode(response.body);
      setState(() {
        token = decodedToken['accessToken'];
      });
      // Save the token using SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', token);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> getUser() async {
    await auth.updateToken();
    // Retrieve the token using SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse(getUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        users = jsonDecode(response.body);
        name = users['data']['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: title1,
                          ),
                          const Icon(
                            Icons.waving_hand_rounded,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                      Text(
                        'Welcome back!',
                        style: subtitle3,
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 24,
                  color: iconColor,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              cardPercent(context),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Schedule",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: fontColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.58,
                child: FutureBuilder(
                  future: client.getTask(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var task = snapshot.data!;

                      return ListView.builder(
                        itemCount: task.length,
                        itemBuilder: (context, index) {
                          var taskId = task[index]['id'];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/detailTask',
                                  arguments: taskId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TaskCard(
                                time: task[index]['time'],
                                title: task[index]['title'],
                                todoText: task[index]['todoText'],
                                category: task[index]['category'],
                                isDone: task[index]['isDone'],
                                onLongPress: onLongPress,
                                widget: Container(),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardPercent(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 120,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Get started with',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              "today's Task",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavbarScreen(
                            selectedIndex: 1,
                          )),
                );
              },
              child: Container(
                width: 95,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'View task',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5, color: Colors.white),
          ),
          child: Center(
            child: Text(
              '0%',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
