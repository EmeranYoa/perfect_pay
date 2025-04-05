import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  String? _errorOldPin;
  String? _errorNewPin;
  String? _errorConfirmPin;

  void _saveNewPin() {
    final oldPin = _oldPinController.text.trim();
    final newPin = _newPinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    setState(() {
      _errorOldPin = null;
      _errorNewPin = null;
      _errorConfirmPin = null;
    });

    if (oldPin.isEmpty) {
      _errorOldPin = 'Veuillez saisir l\'ancien PIN';
    }
    if (newPin.isEmpty) {
      _errorNewPin = 'Veuillez saisir le nouveau PIN';
    } else if (newPin.length < 6) {
      _errorNewPin = 'Le PIN doit contenir au moins 4 chiffres';
    }
    if (confirmPin.isEmpty) {
      _errorConfirmPin = 'Veuillez confirmer le nouveau PIN';
    } else if (newPin.isNotEmpty && newPin != confirmPin) {
      _errorConfirmPin = 'Les PIN ne correspondent pas';
    }

    if (_errorOldPin != null ||
        _errorNewPin != null ||
        _errorConfirmPin != null) {
      setState(() {});
      return;
    }

    // TODO: Logique de sauvegarde du PIN (API, DB, etc.)
  }

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change PIN'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ancien PIN
                    CustomTextField(
                      controller: _oldPinController,
                      labelText: 'Ancien PIN *',
                      prefixIcon: Icons.pin,
                      // On peut utiliser TextInputType.number pour un PIN
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      errorText: _errorOldPin,
                    ),
                    SizedBox(height: 16.h),

                    // Nouveau PIN
                    CustomTextField(
                      controller: _newPinController,
                      labelText: 'Nouveau PIN *',
                      prefixIcon: Icons.pin_outlined,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      errorText: _errorNewPin,
                    ),
                    SizedBox(height: 16.h),

                    // Confirmation PIN
                    CustomTextField(
                      controller: _confirmPinController,
                      labelText: 'Confirmer le PIN *',
                      prefixIcon: Icons.pin_outlined,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      errorText: _errorConfirmPin,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomButton(
                color: Kolor.kPrimary,
                text: 'Enregistrer',
                onPressed: _saveNewPin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
