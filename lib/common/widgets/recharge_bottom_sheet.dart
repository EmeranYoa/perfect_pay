import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:perfect_pay/common/blocs/balance/bloc.dart';
import 'package:perfect_pay/common/blocs/balance/event.dart';
import 'package:perfect_pay/common/blocs/recharge/bloc.dart';
import 'package:perfect_pay/common/blocs/recharge/event.dart';
import 'package:perfect_pay/common/blocs/recharge/state.dart';
import 'package:perfect_pay/common/services/http.dart';
import 'package:perfect_pay/common/utils/environment.dart';
import 'package:perfect_pay/common/utils/helpers.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/utils/type.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class RechargeBottomSheet extends StatefulWidget {
  const RechargeBottomSheet({super.key});

  @override
  State<RechargeBottomSheet> createState() => _RechargeBottomSheetState();
}

class _RechargeBottomSheetState extends State<RechargeBottomSheet> {
  late TextEditingController _amountController;
  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();

    // Get the initial state from the BLoC
    final initialState = context.read<RechargeBloc>().state;

    // Initialize controllers with the current values
    _amountController = TextEditingController(
      text: (initialState.amount?.toString() ?? ''),
    );
    _pinController = TextEditingController(
      text: initialState.codePin ?? '',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> submitRecharge(BuildContext context, RechargeState state) async {
    final amount = state.amount;
    final pin = state.codePin;

    if (amount == null || pin == null || state.selectedMethod == null) {
      showCustomSnackbar(context, 'Please fill in all required fields.');
      return;
    }

    if (state.selectedMethod == RechargeMethod.mobile) {
      showCustomSnackbar(context, "This recharge method is not available.");
      return;
    }

    try {
      final httpService =
          await HttpService.create(baseUrl: Environment.baseUrl);

      final response = await httpService.request(
        endpoint: "recharges/card",
        method: "POST",
        data: {
          "amount": amount,
          "pin": pin,
        },
      );

      final responseData = jsonDecode(response.body);

      final secret = responseData["clientSecret"];

      if (secret != null) {
        await _initPaymentSheet(context, secret);
        Navigator.pop(context);
        context.read<RechargeBloc>().add(RechargeSuccess());
        context.read<BalanceBloc>().add(GetBalance());
      }
    } catch (e) {
      showCustomSnackbar(context, e.toString(), backgroundColor: Colors.red);
      context.read<RechargeBloc>().add(RechargeError());
    }
  }

  Future<void> _initPaymentSheet(BuildContext context, String secret) async {
    try {
      // Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secret,
          merchantDisplayName: Environment.appName,
          // If using multiple payment methods, e.g. Apple Pay
          // applePay: const PaymentSheetApplePay(merchantCountryCode: 'US'),
          // googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          appearance: PaymentSheetAppearance(
            primaryButton: PaymentSheetPrimaryButtonAppearance(
                colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: Kolor.kPrimary,
                text: Colors.white,
              ),
              dark: PaymentSheetPrimaryButtonThemeColors(
                background: Kolor.kPrimary,
                text: Colors.white,
              ),
            )),
          ),
          style: ThemeMode.system, // or .dark / .light
        ),
      );

      // Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();

      showCustomSnackbar(context, "Payment completed!");
    } on StripeException catch (e) {
      showCustomSnackbar(context, "Payment canceled",
          backgroundColor: Colors.red);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RechargeBloc, RechargeState>(
      listenWhen: (previous, current) =>
          previous.amount != current.amount ||
          previous.codePin != current.codePin ||
          previous.isLoading != current.isLoading,
      listener: (context, state) {
        final newAmount = state.amount.toString() ?? '';
        if (_amountController.text != newAmount) {
          _amountController.text = newAmount;
        }
        // Same for the pin
        if (_pinController.text != (state.codePin ?? '')) {
          _pinController.text = state.codePin ?? '';
        }

        if (state.isLoading) {
          submitRecharge(context, state);
        }
      },
      child: BlocBuilder<RechargeBloc, RechargeState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<RechargeBloc>().add(ClearRechargeMethod());
                      },
                      icon: const Icon(Icons.close, size: 24),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                // Step indicator
                _buildStepIndicator(context, state),
                const SizedBox(height: 16),

                // Main content for each step
                Expanded(child: _buildStepContent(context, state)),

                // Navigation buttons
                const SizedBox(height: 16),
                _buildButtons(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  // -----------------------------------
  // Step Indicator (3 circles + lines)
  // -----------------------------------
  Widget _buildStepIndicator(BuildContext context, RechargeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStepCircle(
          context,
          stepNumber: 1,
          isActive: state.currentStep == PaymentStep.method,
        ),
        _buildStepLine(context,
            isActive: state.currentStep != PaymentStep.method),
        _buildStepCircle(
          context,
          stepNumber: 2,
          isActive: state.currentStep == PaymentStep.amount,
        ),
        _buildStepLine(context, isActive: state.currentStep == PaymentStep.pin),
        _buildStepCircle(
          context,
          stepNumber: 3,
          isActive: state.currentStep == PaymentStep.pin,
        ),
      ],
    );
  }

  Widget _buildStepCircle(BuildContext context,
      {required int stepNumber, required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? Kolor.kSecondary : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$stepNumber',
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStepLine(BuildContext context, {required bool isActive}) {
    return Container(
      width: 40,
      height: 2,
      color: isActive ? Kolor.kSecondary : Colors.grey[300],
    );
  }

  // -----------------------------------
  // Build Content for each step
  // -----------------------------------
  Widget _buildStepContent(BuildContext context, RechargeState state) {
    switch (state.currentStep) {
      case PaymentStep.method:
        return _buildMethodStep(context, state);
      case PaymentStep.amount:
        return _buildAmountStep(context, state);
      case PaymentStep.pin:
        return _buildPinStep(context, state);
    }
  }

  // Step 1: Choose Payment Method
  Widget _buildMethodStep(BuildContext context, RechargeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'Choose a payment method:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        // Mobile
        InkWell(
          onTap: () {
            context
                .read<RechargeBloc>()
                .add(PaymentMethodChosen(RechargeMethod.mobile));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: (state.selectedMethod == RechargeMethod.mobile)
                  ? Kolor.kSecondary.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: (state.selectedMethod == RechargeMethod.mobile)
                    ? Kolor.kSecondary
                    : Colors.grey[300]!,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_iphone,
                    color: (state.selectedMethod == RechargeMethod.mobile)
                        ? Kolor.kSecondary
                        : Colors.black54),
                const SizedBox(width: 10),
                Text(
                  'Mobile',
                  style: TextStyle(
                    fontSize: 16,
                    color: (state.selectedMethod == RechargeMethod.mobile)
                        ? Kolor.kSecondary
                        : Colors.black87,
                  ),
                ),
                const Spacer(),
                if (state.selectedMethod == RechargeMethod.mobile)
                  Icon(Icons.check_circle, color: Kolor.kSecondary),
              ],
            ),
          ),
        ),
        // Card
        InkWell(
          onTap: () {
            context
                .read<RechargeBloc>()
                .add(PaymentMethodChosen(RechargeMethod.card));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (state.selectedMethod == RechargeMethod.card)
                  ? Kolor.kSecondary.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: (state.selectedMethod == RechargeMethod.card)
                    ? Kolor.kSecondary
                    : Colors.grey[300]!,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.credit_card,
                    color: (state.selectedMethod == RechargeMethod.card)
                        ? Kolor.kSecondary
                        : Colors.black54),
                const SizedBox(width: 10),
                Text(
                  'Card',
                  style: TextStyle(
                    fontSize: 16,
                    color: (state.selectedMethod == RechargeMethod.card)
                        ? Kolor.kSecondary
                        : Colors.black87,
                  ),
                ),
                const Spacer(),
                if (state.selectedMethod == RechargeMethod.card)
                  Icon(Icons.check_circle, color: Kolor.kSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Step 2: Enter Amount
  Widget _buildAmountStep(BuildContext context, RechargeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'How much do you want to recharge?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _amountController,
          labelText: 'Recharge Amount *',
          hintText: 'e.g. 50.00',
          prefixIcon: Icons.money,
          filled: true,
          keyboardType: TextInputType.number,
          onChange: (value) {
            final parsed = int.tryParse(value);
            if (parsed != null) {
              context.read<RechargeBloc>().add(AmountEntered(parsed));
            }
          },
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter the exact amount you want to add to your balance.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // Step 3: Enter Code Pin
  Widget _buildPinStep(BuildContext context, RechargeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'Enter your PIN to confirm:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _pinController,
          labelText: 'PIN *',
          obscureText: true,
          filled: true,
          hintText: '******',
          prefixIcon: Icons.key,
          keyboardType: TextInputType.number,
          onChange: (value) {
            context.read<RechargeBloc>().add(CodePinEntered(value));
          },
        ),
        const SizedBox(height: 8),
        const Text(
          'For security, please do not share your PIN.',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // -----------------------------------
  // Buttons (Back, Next, Confirm)
  // -----------------------------------
  Widget _buildButtons(BuildContext context, RechargeState state) {
    final isFirstStep = state.currentStep == PaymentStep.method;
    final isLastStep = state.currentStep == PaymentStep.pin;

    final isLoading = state.isLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isFirstStep ? Colors.grey[300] : Colors.white,
            foregroundColor: isFirstStep ? Colors.grey : Kolor.kSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: isFirstStep ? 0 : 1,
          ),
          onPressed: isFirstStep
              ? null
              : () => context.read<RechargeBloc>().add(PreviousStepEvent()),
          child: const Text('Back'),
        ),

        // Next or Confirm
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kolor.kSecondary,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            if (isLoading) return;
            if (isLastStep) {
              // Submit final data
              context.read<RechargeBloc>().add(SubmitRecharge());
              // Navigator.pop(context); // close the bottom sheet
            } else {
              if (state.selectedMethod == RechargeMethod.mobile) {
                showCustomSnackbar(
                    context, 'This payment method is not available.',
                    backgroundColor: Colors.green);
                return;
              }
              // Move to next step
              context.read<RechargeBloc>().add(NextStepEvent());
            }
          },
          child: Text(isLoading
              ? 'Processing...'
              : isLastStep
                  ? 'Confirm'
                  : 'Next'),
        ),
      ],
    );
  }
}
