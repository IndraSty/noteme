import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/secrens/register_screen.dart';
import 'package:noteme/service/auth_service.dart';
import 'package:noteme/service/user_service.dart';
import '../components/color_style.dart';
import '../components/screen_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecureText = true;
  final email = TextEditingController();
  final password = TextEditingController();
  UserService client = UserService();
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'))),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'NoteMe',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Log in to your account',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: fontColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Email Address',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: fontColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: boxColor,
                  ),
                ),
              ),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'youremail@gmail.com',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: fontColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: boxColor,
                  ),
                ),
              ),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'min 8 character',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecureText = !obsecureText;
                      });
                    },
                    icon: obsecureText
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                            size: 20,
                          ),
                  ),
                ),
                obscureText: obsecureText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.15,
            ),
            GestureDetector(
              onTap: () => {
                client.login(context, email.text.trim(), password.text.trim()),
              },
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor),
                child: Center(
                  child: Text(
                    'Log in',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: iconColor,
                    thickness: 0.8,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Atau masuk dengan',
                    style: TextStyle(color: iconColor),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: iconColor,
                    thickness: 0.8,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.08,
            ),
            GestureDetector(
              onTap: () => auth.signInWithGoogle(),
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'Google',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? Tap to",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: fontColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                  child: Text(
                    " Sign Up",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
