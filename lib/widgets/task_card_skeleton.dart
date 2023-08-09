import 'package:flutter/material.dart';

import '../constant/screen_size.dart';

Widget taskCardSkeleton() {
  return Row(
    children: [
      Container(
        height: 130,
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
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
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 25,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 15,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
