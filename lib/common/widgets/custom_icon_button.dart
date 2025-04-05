import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final Color bgColor;
  final IconData icon;
  final void Function()? onPressed;
  final Color iconColor;

  const CustomIconButton({
    super.key,
    required this.bgColor,
    required this.icon,
    this.onPressed,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Ink(
          decoration: ShapeDecoration(
            color: bgColor,
            shape: const CircleBorder(),
          ),
          child: SizedBox(
            width: 35.w,
            height: 35.h,
            child: IconButton(
              alignment: Alignment.center,
              iconSize: 15.sp,
              icon: Icon(icon),
              color: iconColor,
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
