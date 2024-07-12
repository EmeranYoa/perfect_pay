import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/src/entrypoint/view/entry_point_page.dart';
import 'package:perfect_pay/src/onboarding/view/onboarding_page.dart';
import 'package:perfect_pay/src/splashscreen/view/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: <RouteBase> [
    GoRoute(
        path: "/",
        builder: (context, state) => const SplashScreen()
    ),
    GoRoute(
        path: "/onboarding",
        builder: (context, state) => const OnboardingPage()
    ),
    GoRoute(
        path: "/home",
        builder: (context, state) => const EntryPointPage()
    )
  ]
);

GoRouter get router => _router;