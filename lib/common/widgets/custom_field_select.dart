import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFilePickerField extends StatelessWidget {
  final String labelText;
  final File? file;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? errorText;
  final void Function(File?) onFilePicked;

  const CustomFilePickerField({
    super.key,
    required this.labelText,
    required this.file,
    required this.onFilePicked,
    this.prefixIcon,
    this.suffixIcon = Icons.upload_file,
    this.errorText,
  });

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      final selected = File(result.files.single.path!);
      onFilePicked(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? file!.path.split('/').last : 'Aucun fichier sélectionné';

    return InkWell(
      onTap: () => _pickFile(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: Icon(suffixIcon),
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
          errorText: errorText,
        ),
        child: Text(
          fileName,
          style: TextStyle(
            fontSize: 14.sp,
            color: (file == null) ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}
