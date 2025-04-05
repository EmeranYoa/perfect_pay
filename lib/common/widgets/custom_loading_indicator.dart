import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: SizedBox(
          width: 100.w,
          height: 100.w,
          child: LoadingIndicator(
            indicatorType: Indicator.pacman,
            colors: [Kolor.kPrimary, Kolor.kSecondary, Kolor.kTertiary],
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
