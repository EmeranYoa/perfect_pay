import 'package:concentric_transition/concentric_transition.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/gen/assets.gen.dart';
import 'package:perfect_pay/src/onboarding/view/pages/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Widget> items = [
    OnboardingItem(
      title: 'Safe Transaction',
      subTitle: "Forgot to bring your wallet when you are shopping?",
      imagePath: Assets.images.a5.keyName,
    ),
    OnboardingItem(
      title: 'Safe Transaction',
      subTitle: "Forgot to bring your wallet when you are shopping?",
      imagePath: Assets.images.a12.keyName,
    ),
    OnboardingItem(
      title: 'Safe Transaction',
      subTitle: "Forgot to bring your wallet when you are shopping?",
      imagePath: Assets.images.a13.keyName,
    )
  ];

  final PageController _pgController = PageController();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pgController.dispose();
    super.dispose();
  }

  void _pgChange(int index) {
    _pgController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
  }

  void _updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            radius: 0,
            verticalPosition: 0.85,
            pageController: _pgController,
            colors: <Color>[Kolor.kPrimary, Kolor.kPrimary, Kolor.kPrimary],
            onChange: (int index) {
              _updateCurrentIndex(index);
            },
            itemCount: items.length,
            itemBuilder: (index) {
              return items[index];
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentIndex == 0
                      ? SizedBox(
                          width: 35.w,
                        )
                      : customIconButton(
                          bgColor: Kolor.kSecondary,
                          icon: Icons.arrow_back_ios,
                          onPressed: () {
                            int i = 0;
                            if (currentIndex > 0) {
                              i -= 1;
                            }
                            _pgChange(i);
                          },
                        ),
                  _dotIndicator(currentIndex, items.length),
                  currentIndex == (items.length - 1)
                      ? SizedBox(
                          width: 35.w,
                        )
                      : customIconButton(
                          bgColor: Kolor.kSecondary,
                          icon: Icons.arrow_forward_ios,
                          onPressed: () {
                            int i = currentIndex;
                            if (currentIndex < items.length) {
                              i += 1;
                            }
                            _pgChange(i);
                          },
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dotIndicator(int index, int length) {
    return DotsIndicator(
      dotsCount: length,
      position: index,
      decorator: DotsDecorator(
        color: Kolor.kWhite,
        activeColor: Kolor.kSecondary,
      ),
    );
  }

  Widget customIconButton(
      {required Color bgColor,
      required IconData icon,
      required void Function()? onPressed,
      Color iconColor = Colors.white}) {
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
