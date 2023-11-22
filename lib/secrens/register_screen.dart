import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/secrens/login_screen.dart';
import 'package:noteme/service/user_service.dart';

import '../components/color_style.dart';
import '../components/screen_size.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserService client = UserService();
  bool obsecureText1 = true;
  bool obsecureText2 = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  ValueNotifier<String> genderNotifier = ValueNotifier<String>('Male');

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create your account',
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
                  'Fullname',
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
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'your name',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fullname harus diisi';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
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
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'youremail@gmail.com',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email harus diisi';
                      }
                      if (!value.contains('@')) {
                        return 'Email tidak valid';
                      }
                      // Return null jika validasi berhasil
                      return null;
                    },
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
                  'Your Gender',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: fontColor,
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: genderNotifier.value,
                  onChanged: (String? newValue) {
                    setState(() {
                      genderNotifier.value = newValue!;
                    });
                  },
                  items: <String>['Male', 'Female']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                ),
                const Divider(
                  color: boxColor,
                  thickness: 1,
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
                  child: TextFormField(
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
                            obsecureText1 = !obsecureText1;
                          });
                        },
                        icon: obsecureText1
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password harus diisi';
                      }
                      if (value.length < 8) {
                        return 'Password harus memiliki panjang minimal 8 karakter';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                        return 'Password harus mengandung minimal satu huruf besar';
                      }
                      return null;
                    },
                    obscureText: obsecureText1,
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
                  'Confirm Password',
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
                  child: TextFormField(
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
                            obsecureText2 = !obsecureText2;
                          });
                        },
                        icon: obsecureText2
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password harus diisi';
                      }
                      if (value.length < 8) {
                        return 'Password harus memiliki panjang minimal 8 karakter';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                        return 'Password harus mengandung minimal satu huruf besar';
                      }

                      return null;
                    },
                    obscureText: obsecureText2,
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
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      client.register(
                        context,
                        name.text.trim(),
                        email.text.trim(),
                        password.text.trim(),
                        genderNotifier.value,
                      );
                    }
                  },
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: primaryColor),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? Tap to",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: fontColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        " Sign In",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
