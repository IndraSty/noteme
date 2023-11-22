import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/color_style.dart';
import '../components/screen_size.dart';

// ignore: must_be_immutable
class TaskCard extends StatelessWidget {
  TaskCard({
    super.key,
    required this.time,
    required this.title,
    required this.todoText,
    required this.category,
    required this.isDone,
    required this.onLongPress,
    required this.widget,
  });

  final String time;
  final String title;
  final String todoText;
  final String category;
  bool isDone;
  bool onLongPress;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 130,
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Text(
            time,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: fontColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 130,
          width: width * 0.65,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDone ? primaryColor : boxColor,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDone ? Colors.white : fontColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    todoText,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDone ? Colors.white : fontColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 17,
                        width: 17,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: isDone ? Colors.white : primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDone ? Colors.white : fontColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              onLongPress
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: widget,
                    )
                  : Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
