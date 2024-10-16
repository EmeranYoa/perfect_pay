import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      GoRouter.of(context).go('/onboarding');
      /*if (Storage.getBool(Environment.isFirst) == null) {
        GoRouter.of(context).go('/onboarding');
        Storage.setBool(Environment.isFirst, true);
      } else {
        GoRouter.of(context).go('/home');
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.splashscreen.keyName),
              alignment: Alignment.center,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
