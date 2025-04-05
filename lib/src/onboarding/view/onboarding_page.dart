import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_icon_button.dart';
import 'package:perfect_pay/common/widgets/indicator.dart';
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

  void _pgChange(int index) {
    _pgController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.decelerate);
  }

  void _updateCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _navigateToLogin() {
    GoRouter.of(context).go('/login');
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
            bottom: 5.h,
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
                      : CustomIconButton(
                          bgColor: Kolor.kSecondary,
                          icon: Icons.arrow_back_ios,
                          onPressed: () {
                            int i = currentIndex;
                            if (currentIndex > 0) {
                              i -= 1;
                            }
                            _pgChange(i);
                          },
                        ),
                  Indicator(
                    index: currentIndex,
                    length: items.length,
                  ),
                  CustomIconButton(
                    bgColor: Kolor.kSecondary,
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {
                      int i = currentIndex + 1;

                      if (i == items.length) {
                        _navigateToLogin();
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
}
