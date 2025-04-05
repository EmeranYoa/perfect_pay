import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';
import 'package:perfect_pay/common/widgets/custom_field_select.dart';
import 'package:perfect_pay/common/widgets/custom_select_field.dart';
import 'package:perfect_pay/common/widgets/custom_text_field.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  State<KycPage> createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  final TextEditingController _pieceNumberController = TextEditingController();

  String? _selectedPieceType;

  File? _selectedFile;

  String? _errorPieceNumber;
  String? _errorPieceType;
  String? _errorFile;

  final List<String> _pieceTypes = [
    'Carte d\'identité',
    'Passeport',
    'Permis de conduire',
  ];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      // Vous pouvez spécifier les extensions autorisées
      // type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _submitKyc() {
    final pieceNumber = _pieceNumberController.text.trim();
    final pieceType = _selectedPieceType;
    final file = _selectedFile;

    setState(() {
      _errorPieceNumber = null;
      _errorPieceType = null;
      _errorFile = null;
    });

    if (pieceNumber.isEmpty) {
      _errorPieceNumber = 'Le numéro de la pièce est requis.';
    }
    if (pieceType == null) {
      _errorPieceType = 'Le type de la pièce est requis.';
    }
    if (file == null) {
      _errorFile = 'Le fichier de la pièce est requis.';
    }

    if (_errorPieceNumber != null ||
        _errorPieceType != null ||
        _errorFile != null) {
      setState(() {});
      return;
    }

    // TODO: Logique KYC => Upload du fichier, envoi des infos au serveur, etc.
  }

  @override
  void dispose() {
    _pieceNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC - Pièce d\'identité'),
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
                      controller: _pieceNumberController,
                      labelText: 'Numéro de la pièce *',
                      prefixIcon: Icons.article,
                      errorText: _errorPieceNumber,
                    ),
                    SizedBox(height: 16.h),
                    CustomDropdownField<String>(
                      labelText: 'Type de la pièce *',
                      prefixIcon: Icons.list,
                      value: _selectedPieceType,
                      items: _pieceTypes,
                      errorText: _errorPieceType,
                      onChanged: (value) {
                        setState(() {
                          _selectedPieceType = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomFilePickerField(
                      labelText: 'Fichier de la pièce *',
                      file: _selectedFile,
                      prefixIcon: Icons.file_present,
                      errorText: _errorFile,
                      onFilePicked: (file) {
                        setState(() {
                          _selectedFile = file;
                        });
                      },
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: CustomButton(
                color: Kolor.kPrimary,
                text: 'Soumettre',
                onPressed: _submitKyc,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
