import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:perfect_pay/common/models/auth_model.dart';
import 'package:perfect_pay/common/services/http.dart';
import 'package:perfect_pay/common/services/storage.dart';
import 'package:perfect_pay/common/utils/environment.dart';
import 'package:perfect_pay/common/utils/helpers.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/brand_text.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_loading_indicator.dart';
import 'package:perfect_pay/common/widgets/otp_input_field.dart';

class OTPLoginScreen extends StatefulWidget {
  const OTPLoginScreen({super.key});

  @override
  State<OTPLoginScreen> createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isPinCompleted = false;
  bool isLoading = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> onNextPressed(BuildContext context, String phoneNumber) async {
    if (isLoading) return;

    if (otpController.text.isEmpty) {
      showCustomSnackbar(context, 'Please enter the pin.',
          backgroundColor: Colors.red);
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      final httpService =
          await HttpService.create(baseUrl: Environment.baseUrl);

      final response = await httpService.request(
        endpoint: "auth/login",
        method: "POST",
        data: {
          "phone_number": phoneNumber,
          "pin": otpController.text,
        },
      );

      final responseData = jsonDecode(response.body);

      final authModel = AuthModel.fromJson(responseData);

      if (authModel.accessToken.isEmpty) {
        showCustomSnackbar(context, 'Login Failed.',
            backgroundColor: Colors.red);
        return;
      }

      Storage.setString(Environment.tokenKey, authModel.accessToken);
      // Navigate to home screen
      GoRouter.of(context).go('/home');
    } on HttpException catch (_) {
      showCustomSnackbar(context, 'Please verify your credentials.',
          backgroundColor: Colors.red);
    } catch (e) {
      showCustomSnackbar(context, e.toString(), backgroundColor: Colors.red);
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onOtpCompleted(String otp) {
    setState(() {
      isPinCompleted = otp.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = GoRouterState.of(context).extra as String;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandText(fontSize: 35.0.sp),
                  SizedBox(height: 40.h),
                  const Text(
                    'Enter PIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'To continue with your account, you must verify your pin. Please enter the pin of this account $phoneNumber.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 50.h),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              OtpInputField(
                                controller: otpController,
                                onCompleted: onOtpCompleted,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    color: isPinCompleted ? Kolor.kPrimary : Kolor.kDisabled,
                    text: "Login",
                    onPressed: isPinCompleted
                        ? () {
                            onNextPressed(context, phoneNumber);
                          }
                        : () {},
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const CustomLoadingIndicator()
        ],
      ),
    );
  }
}
