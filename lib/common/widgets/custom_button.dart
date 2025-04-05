/* custom button widgets: params: color, text, onPressed */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      required this.color,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      elevation: 5,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 40.h,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
