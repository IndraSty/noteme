import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../components/color_style.dart';
import '../components/screen_size.dart';
import '../routes/url.dart';
import '../widgets/container_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> users = {};

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
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
      });
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');
      http.delete(
        Uri.parse(logoutUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      Navigator.pushReplacementNamed(context, '/login');
      print('Logout Berhasil');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: fontColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: bodyColor,
        elevation: 0,
      ),
      backgroundColor: bodyColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 128,
              width: 128,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              users['data']['name'],
              style: GoogleFonts.poppins(
                color: fontColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              users['data']['email'],
              style: GoogleFonts.poppins(
                color: fontColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ContainerItem(
              width: width,
              icon: Icons.person_2_outlined,
              text: 'Akun Saya',
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerItem(
              width: width,
              icon: Icons.location_on_outlined,
              text: 'Lokasi Saya',
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerItem(
              width: width,
              icon: Icons.notifications_outlined,
              text: 'Notifikasi',
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerItem(
              width: width,
              icon: Icons.bookmark_outline_rounded,
              text: 'Whistlist',
            ),
            const SizedBox(
              height: 20,
            ),
            ContainerItem(
              width: width,
              icon: Icons.help_outline,
              text: 'Support',
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerItem(
              width: width,
              icon: Icons.list_alt_sharp,
              text: 'Syarat & Ketentuan',
            ),
            const SizedBox(
              height: 5,
            ),
            ContainerItem(
              width: width,
              icon: Icons.help_outline,
              text: 'Bantuan',
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 43,
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.redAccent)),
              child: Row(
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    size: 16,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () => logout(),
                    child: SizedBox(
                      width: width * 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logout',
                            style: GoogleFonts.poppins(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: Color(0xffA9A7A7),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
