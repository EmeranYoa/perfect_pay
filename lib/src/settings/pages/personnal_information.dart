import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class ChangePersonalInfoPage extends StatefulWidget {
  final String currentFirstName;
  final String currentLastName;

  const ChangePersonalInfoPage({
    super.key,
    required this.currentFirstName,
    required this.currentLastName,
  });

  @override
  State<ChangePersonalInfoPage> createState() => _ChangePersonalInfoPageState();
}

class _ChangePersonalInfoPageState extends State<ChangePersonalInfoPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String? _errorFirstName;
  String? _errorLastName;

  @override
  void initState() {
    super.initState();

    _firstNameController.text = widget.currentFirstName;
    _lastNameController.text = widget.currentLastName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _savePersonalInfo() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    setState(() {
      _errorFirstName = null;
      _errorLastName = null;
    });

    if (firstName.isEmpty) {
      setState(() => _errorFirstName = 'Le prénom ne peut pas être vide.');
    }
    if (lastName.isEmpty) {
      setState(() => _errorLastName = 'Le nom ne peut pas être vide.');
    }

    if (_errorFirstName != null || _errorLastName != null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change personal information'),
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
                    CustomTextField(
                      controller: _firstNameController,
                      labelText: 'First name *',
                      prefixIcon: Icons.person,
                      errorText: _errorFirstName,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _lastNameController,
                      labelText: 'Last name *',
                      prefixIcon: Icons.person,
                      errorText: _errorLastName,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomButton(
                color: Kolor.kPrimary,
                text: 'Enregistrer',
                onPressed: _savePersonalInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
