import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/color_style.dart';

class ContainerItem extends StatelessWidget {
  const ContainerItem({
    super.key,
    required this.width,
    required this.text,
    required this.icon,
  });

  final double width;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                      color: fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xffA9A7A7),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
