import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';

class Indicator extends StatelessWidget {
  final int index;
  final int length;
  final Color dotColor;
  final Color activeDotColor = Kolor.kSecondary;

  Indicator({
    super.key,
    required this.index,
    required this.length,
    this.dotColor = Kolor.kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: length,
      position: index,
      decorator: DotsDecorator(
        color: dotColor,
        activeColor: activeDotColor,
      ),
    );
  }
}
