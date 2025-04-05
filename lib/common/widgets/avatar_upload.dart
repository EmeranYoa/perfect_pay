import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';

class AvatarUpload extends StatefulWidget {
  final ValueChanged<File?> onImageSelected;
  final String? avatarUrl;

  const AvatarUpload({
    super.key,
    required this.onImageSelected,
    required this.avatarUrl,
  });

  @override
  State<AvatarUpload> createState() => _AvatarUploadState();
}

class _AvatarUploadState extends State<AvatarUpload> {
  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> selectProfilePhoto() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Kolor.kPrimary,
                  ),
                  title: const Text('Prendre une photo'),
                  onTap: () => Navigator.pop(context, 'camera'),
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo,
                    color: Kolor.kPrimary,
                  ),
                  title: const Text('Choisir depuis la galerie'),
                  onTap: () => Navigator.pop(context, 'gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (choice == null) return;

    XFile? pickedFile;
    try {
      if (choice == 'camera') {
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
      } else if (choice == 'gallery') {
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      }

      if (pickedFile != null) {
        setState(() {
          profileImage = File((pickedFile as XFile).path);
        });
        widget.onImageSelected(profileImage);
      }
    } catch (e) {
      debugPrint("Erreur lors de la sélection de l'image : $e");
      widget.onImageSelected(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectProfilePhoto,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.withOpacity(0.5),
        backgroundImage: profileImage != null
            ? FileImage(profileImage!)
            : widget.avatarUrl != null
                ? widget.avatarUrl!.startsWith('https')
                    ? NetworkImage(widget.avatarUrl!)
                    : AssetImage(widget.avatarUrl!)
                : null,
        child: profileImage == null
            ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
            : null,
      ),
    );
  }
}
