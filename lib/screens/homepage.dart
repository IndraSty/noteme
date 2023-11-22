import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/constant/color_constant.dart';
import 'package:noteme/constant/screen_size.dart';
import 'package:noteme/constant/text_style.dart';
import 'package:noteme/screens/bot_navbar.dart';

import '../widgets/task_card.dart';
import '../widgets/task_card_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  bool onLongPress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data();
                String? fullName = data!['fullname'] as String?;
                String? name = fullName?.split(' ').first;

                return Row(
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
                                  'Hi, ${name ?? " "} ',
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
                );
              } else {
                return appBarSkeleton();
              }
            },
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
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('task')
                        .snapshots(),
                    builder: (context, snapshot) {
                      final document = snapshot.data?.docs;

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return taskCardSkeleton();
                      }

                      return ListView.builder(
                        itemCount: document!.length,
                        itemBuilder: ((context, index) {
                          final data =
                              document[index].data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TaskCard(
                              time: data['time'],
                              title: data['title'],
                              todoText: data['todoText'],
                              category: data['category'],
                              isDone: data['isDone'],
                              onLongPress: onLongPress,
                              widget: Container(),
                            ),
                          );
                        }),
                      );
                    }),
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

Widget appBarSkeleton() {
  return Row(
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 15,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      )
    ],
  );
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
