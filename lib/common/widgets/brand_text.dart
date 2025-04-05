import 'package:flutter/material.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';

class BrandText extends StatelessWidget {
  final double fontSize;

  const BrandText({
    super.key,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Perfect',
          style: TextStyle(
            fontSize: fontSize,
            color: Kolor.kPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
          ),
        ),
        Text(
          ' Pay',
          style: TextStyle(
            fontSize: fontSize,
            color: Kolor.kTertiary,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
          ),
        ),
      ],
    );
  }
}
