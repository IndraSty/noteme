import 'package:flutter/material.dart';
import 'package:noteme/screens/notes_screen.dart';
import 'package:noteme/screens/profile.dart';
import 'package:noteme/screens/task_screen.dart';

import '../constant/color_constant.dart';
import 'homepage.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TaskScreen(),
    NotesScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          enableFeedback: false,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: iconColor,
          selectedIconTheme: const IconThemeData(
            color: primaryColor,
            size: 26,
          ),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline_rounded,
                ),
                label: 'Task'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.music_note_outlined,
                ),
                label: 'Notes'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                ),
                label: 'Profile'),
          ]),
    );
  }
}
