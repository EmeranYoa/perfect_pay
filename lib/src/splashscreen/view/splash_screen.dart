import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/common/services/storage.dart';
import 'package:perfect_pay/common/utils/environment.dart';
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
    await Future.delayed(const Duration(milliseconds: 3000), () async {
      if (await Storage.getBool(Environment.isFirst) == false) {
        GoRouter.of(context).go('/onboarding');
        Storage.setBool(Environment.isFirst, true);
      } else {
        final token = await Storage.getString(Environment.tokenKey);
        // GoRouter.of(context).go('/login');
        // return;
        //TODO: check if token is valid
        if (token == null) {
          GoRouter.of(context).go('/login');
          return;
        }
        GoRouter.of(context).go('/home');
      }
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
