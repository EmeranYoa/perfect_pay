import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/brand_text.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/phone_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phController = TextEditingController();

  /*late HttpService httpService;*/
  bool isPhoneValid = false;

  /*@override
  void initState() {
    super.initState();
    _initHttpService();
  }

  Future<void> _initHttpService() async {
    httpService = await HttpService.create(baseUrl: Environment.baseUrl);
  }
*/
  void onNextPressed() {
    GoRouter.of(context).push('/pin', extra: phController.text);
  }

  void onSignUpPressed() {
    GoRouter.of(context).push('/signup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Sign in to continue to your account.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 40.h),
              BrandText(fontSize: 35.0.sp),
              SizedBox(height: 50.h),

              Expanded(
                child: Column(
                  children: [
                    PhoneInputField(
                      controller: phController,
                      onChanged: (phone) {
                        setState(() {
                          isPhoneValid = phone.length >= 10;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              // Action Button
              CustomButton(
                color: isPhoneValid ? Kolor.kPrimary : Kolor.kDisabled,
                text: "Next",
                onPressed: isPhoneValid ? onNextPressed : () {},
              ),
              SizedBox(height: 5.h),
              // Sign Up Section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: onSignUpPressed,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 14,
                            color: Kolor.kPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        // Redirige vers la page d'aide
                      },
                      child: const Text(
                        "Need help? Contact support",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
