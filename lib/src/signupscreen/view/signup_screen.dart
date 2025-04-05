import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_pay/common/services/http.dart';
import 'package:perfect_pay/common/utils/helpers.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_loading_indicator.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';
import 'package:perfect_pay/common/widgets/phone_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? profileImage;

  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> selectProfilePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> onSubmit() async {
    if (isLoading) return;

    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      showCustomSnackbar(context, 'Please fill in all required fields.',
          backgroundColor: Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // final httpService =
      //     await HttpService.create(baseUrl: Environment.baseUrl);
      // final response = await httpService
      //     .request(endpoint: "auth/register/client", method: "POST", data: {
      //   "email": emailController.text,
      //   "phone_number": phoneController.text,
      //   "first_name": firstNameController.text,
      //   "last_name": lastNameController.text
      // });

      // created delay to show loading indicator
      await Future.delayed(const Duration(seconds: 10));

      GoRouter.of(context).go('/pin', extra: phoneController.text);
    } on HttpException catch (e) {
      showCustomSnackbar(context, e.message, backgroundColor: Colors.red);
    } catch (e) {
      showCustomSnackbar(context, 'Oops! Something went wrong. Try again.',
          backgroundColor: Colors.red);
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create an Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Fill in the details below to get started.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  // Profile Photo Section
                  Center(
                    child: GestureDetector(
                      onTap: selectProfilePhoto,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Kolor.kDisabled,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : null,
                        child: profileImage == null
                            ? const Icon(Icons.camera_alt,
                                size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: firstNameController,
                    labelText: 'First Name *',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: lastNameController,
                    labelText: 'Last Name *',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'Email *',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  PhoneInputField(
                    controller: phoneController,
                    onChanged: (phone) {
                      // Handle phone number changes
                    },
                  ),
                  const SizedBox(height: 20),
                  // Optional File Uploads
                  Text(
                    'Identity Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  ListTile(
                    leading: const Icon(Icons.file_present),
                    title: const Text('Upload ID Document'),
                    trailing: IconButton(
                      icon: const Icon(Icons.upload),
                      onPressed: () => {},
                    ),
                  ),
                  const Divider(),

                  // Proof of Address Upload
                  ListTile(
                    leading: const Icon(Icons.file_present),
                    title: const Text('Upload Proof of Address'),
                    trailing: IconButton(
                      icon: const Icon(Icons.upload),
                      onPressed: () => {},
                    ),
                  ),
                  const Divider(),

                  SizedBox(height: 40.h),
                  // Submit Button
                  CustomButton(
                    color: Kolor.kPrimary,
                    text: 'Submit',
                    onPressed: onSubmit,
                  ),
                  const SizedBox(height: 20),

                  // Back to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/login');
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 14,
                            color: Kolor.kPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const CustomLoadingIndicator(),
        ],
      ),
    );
  }
}
