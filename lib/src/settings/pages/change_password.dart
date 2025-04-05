import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _errorOldPassword;
  String? _errorNewPassword;
  String? _errorConfirmPassword;

  void _saveNewPassword() {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Réinitialiser les erreurs
    setState(() {
      _errorOldPassword = null;
      _errorNewPassword = null;
      _errorConfirmPassword = null;
    });

    // Validation basique
    if (oldPassword.isEmpty) {
      _errorOldPassword = 'Veuillez saisir l\'ancien mot de passe';
    }
    if (newPassword.isEmpty) {
      _errorNewPassword = 'Veuillez saisir le nouveau mot de passe';
    }
    if (confirmPassword.isEmpty) {
      _errorConfirmPassword = 'Veuillez confirmer le nouveau mot de passe';
    } else if (newPassword.isNotEmpty && newPassword != confirmPassword) {
      _errorConfirmPassword = 'Les mots de passe ne correspondent pas';
    }

    if (_errorOldPassword != null ||
        _errorNewPassword != null ||
        _errorConfirmPassword != null) {
      setState(() {});
      return;
    }

    // TODO: Logique de sauvegarde du nouveau mot de passe (API, DB, etc.)
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change password'),
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
                    // Ancien mot de passe
                    CustomTextField(
                      controller: _oldPasswordController,
                      labelText: 'Ancien mot de passe *',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      errorText: _errorOldPassword,
                    ),
                    SizedBox(height: 16.h),

                    // Nouveau mot de passe
                    CustomTextField(
                      controller: _newPasswordController,
                      labelText: 'Nouveau mot de passe *',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      errorText: _errorNewPassword,
                    ),
                    SizedBox(height: 16.h),

                    // Confirmation mot de passe
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirmer le mot de passe *',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      errorText: _errorConfirmPassword,
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
                onPressed: _saveNewPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
