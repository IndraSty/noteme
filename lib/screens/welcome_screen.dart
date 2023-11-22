import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteme/constant/screen_size.dart';
import 'package:noteme/screens/sign_in.dart';
import 'package:noteme/screens/sign_up.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/color_constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int activeIndex = 0;
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
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: imagesSlider.length,
              itemBuilder: (context, index, realIndex) {
                final images = imagesSlider[index];
                final title = titleDesk[index];
                final subtitle = subTitleDesk[index];
                return buildImage(images, index, title, subtitle);
              },
              options: CarouselOptions(
                  height: height * 0.54,
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
            ),
            // Container(
            //   height: 271,
            //   width: width,
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //     image: AssetImage('assets/images/welcome1.png'),
            //     fit: BoxFit.cover,
            //   )),
            // ),
            Positioned(
              bottom: height * 0.2,
              child: Container(
                width: width,
                child: Center(child: buildIndicator()),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: Container(
                        width: width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                              builder: (context) => const SignInScreen()));
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
          ],
        ),
      ),
    );
  }

  final imagesSlider = [
    'assets/images/welcome4.png',
    'assets/images/welcome1.png',
    'assets/images/welcome2.png',
  ];
  final titleDesk = [
    'Track your Progress',
    'Manage your task',
    'Manage your time',
  ];
  final subTitleDesk = [
    'when you track your progress you have facts, not subjective reflections. We often overestimate how often we do things, but tracing eliminates this.',
    'Welcome to a world that enable you plan, schedule your task and meet all your targets easily',
    'Creating an environment that enables you plan and excercise conscious control of time spent on activities, to increase effectiveness, eficiency, and productivity.',
  ];

  Widget buildImage(String images, int index, String title, String subtitle) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 271,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(images),
            fit: BoxFit.cover,
          )),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: fontColor,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: fontColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imagesSlider.length,
        effect: const ExpandingDotsEffect(
          dotWidth: 7,
          dotHeight: 5,
          activeDotColor: primaryColor,
        ),
      );
}
