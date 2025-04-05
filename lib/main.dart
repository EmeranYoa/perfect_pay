import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:perfect_pay/common/blocs/balance/bloc.dart';
import 'package:perfect_pay/common/blocs/recharge/bloc.dart';
import 'package:perfect_pay/common/utils/app_routes.dart';
import 'package:perfect_pay/common/utils/environment.dart';
import 'package:perfect_pay/common/utils/kstrings.dart';
import 'package:perfect_pay/src/entrypoint/view/bloc/bloc.dart';
import 'package:perfect_pay/src/splashscreen/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env
  await dotenv.load(fileName: Environment.fileName);
  await GetStorage.init();
  Stripe.publishableKey = Environment.stripePublishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: const Size(
        360,
        690,
      ),
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NavigationBloc>(
              create: (context) => NavigationBloc(),
            ),
            BlocProvider<RechargeBloc>(
              create: (context) => RechargeBloc(),
            ),
            BlocProvider<BalanceBloc>(
              create: (context) => BalanceBloc(),
            )
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppText.kAppName,
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: router,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
