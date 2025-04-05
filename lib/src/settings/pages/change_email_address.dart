import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class ChangeEmailPage extends StatefulWidget {
  final String currentEmail;

  const ChangeEmailPage({super.key, required this.currentEmail});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final TextEditingController emailController = TextEditingController();

  String? errorText;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.currentEmail;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _saveNewEmail() {
    final newEmail = emailController.text.trim();

    if (newEmail.isEmpty || !newEmail.contains('@')) {
      setState(() {
        errorText = 'Veuillez saisir une adresse e-mail valide.';
      });
      return;
    }

    setState(() {
      errorText = null;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change email address'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  controller: emailController,
                  labelText: 'New email address *',
                  keyboardType: TextInputType.emailAddress,
                  errorText: errorText,
                  prefixIcon: Icons.email,
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                color: Kolor.kPrimary,
                text: 'Enregistrer',
                onPressed: _saveNewEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
