import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    required this.color,
    required this.textColor,
    required this.ringColor,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  final Color color;
  final Color textColor;
  final Color ringColor;
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: ringColor,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
