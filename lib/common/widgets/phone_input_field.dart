import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String initialCountry;
  final ValueChanged<String>? onChanged;

  final List<Country> supportedCountries = countries
      .where((country) =>
          country.code == 'CM' || country.code == 'FR' || country.code == 'US')
      .toList();

  PhoneInputField({
    super.key,
    required this.controller,
    this.initialCountry = 'CM',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      showDropdownIcon: true,
      keyboardType: TextInputType.phone,
      initialCountryCode: initialCountry,
      countries: supportedCountries,
      showCountryFlag: true,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2.0,
          ),
        ),
      ),
      onChanged: (phone) {
        controller.text = phone.completeNumber;
        if (onChanged != null) {
          onChanged!(phone.completeNumber);
        }
      },
    );
  }
}
