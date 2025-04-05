import 'package:flutter/material.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:pinput/pinput.dart';

class OtpInputField extends StatelessWidget {
  final ValueChanged<String> onCompleted;
  final TextEditingController controller;

  const OtpInputField({
    super.key,
    required this.onCompleted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Kolor.kPrimary),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey.shade200,
      ),
    );

    return Pinput(
      length: 5,
      controller: controller,
      focusNode: FocusNode(),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (pin) {
        if (pin == null || pin.length < 5) {
          return 'Enter a valid 5-digit code';
        }
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}
