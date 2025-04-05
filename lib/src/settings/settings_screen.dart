import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/helpers.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/avatar_upload.dart';
import 'package:perfect_pay/src/settings/pages/change_email_address.dart';
import 'package:perfect_pay/src/settings/pages/change_password.dart';
import 'package:perfect_pay/src/settings/pages/change_pin.dart';
import 'package:perfect_pay/src/settings/pages/kyc.dart';
import 'package:perfect_pay/src/settings/pages/language.dart';
import 'package:perfect_pay/src/settings/pages/personnal_information.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String avatarUrl = 'assets/images/1.png';

  final List<Map<String, dynamic>> parametresGroups = [
    {
      'label': 'Paramètre',
      'items': [
        {
          'title': 'Langue',
          'icon': Boxicons.bx_world,
          'page': const LanguePage(),
        },
        {
          'title': 'Devise',
          'icon': Boxicons.bx_dollar,
          'page': null,
        },
      ],
    },
    {
      'label': 'Compte',
      'items': [
        {
          'title': 'Téléphone',
          'icon': Boxicons.bx_phone,
          'page': null,
        },
        {
          'title': 'Adresse email',
          'icon': Boxicons.bx_envelope,
          'page': const ChangeEmailPage(
            currentEmail: "L8N1H@example.com",
          ),
        },
        {
          'title': 'Personnal information',
          'icon': Boxicons.bx_user,
          'page': const ChangePersonalInfoPage(
              currentFirstName: "Emeran", currentLastName: "Youa"),
        },
      ],
    },
    {
      'label': 'Sécurité',
      'items': [
        {
          'title': 'KYC',
          'icon': Boxicons.bx_id_card,
          'page': const KycPage(),
        },
        {
          'title': 'Changer mot de passe',
          'icon': Boxicons.bx_lock_alt,
          'page': const ChangePasswordPage(),
        },
        {
          'title': 'Changer PIN',
          'icon': Boxicons.bx_key,
          'page': const ChangePinPage(),
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarUpload(
                onImageSelected: (File? imageFile) {},
                avatarUrl: avatarUrl,
              ),
              SizedBox(height: 10.h),
              // 2. Nom de l’utilisateur
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),

              // 3. Liste des groupes
              ...parametresGroups.map((group) {
                return _buildGroupTile(context, group);
              }),

              SizedBox(height: 20.h),

              Card(
                margin: EdgeInsets.only(bottom: 10.h),
                elevation: 0,
                shadowColor: Colors.transparent,
                color: Colors.grey.withOpacity(0.1),
                child: ListTile(
                  leading: Icon(
                    Boxicons.bx_log_out,
                    size: 24.sp,
                    color: Kolor.kPrimary,
                  ),
                  title: Text(
                    'Se déconnecter',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  trailing: Icon(
                    Boxicons.bx_chevron_right,
                    size: 24.sp,
                  ),
                  onTap: () {
                    // TODO: Implementer la logique de deconnexion
                  },
                ),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupTile(BuildContext context, Map<String, dynamic> group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group['label'],
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),

        // Liste d'items
        Card(
          margin: EdgeInsets.only(bottom: 10.h),
          elevation: 0,
          shadowColor: Colors.transparent,
          color: Colors.grey.withOpacity(0.1),
          child: Column(
            children:
                (group['items'] as List<Map<String, dynamic>>).map((item) {
              return ListTile(
                leading: Icon(
                  item['icon'],
                  size: 24.sp,
                  color: Kolor.kPrimary,
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(fontSize: 14.sp),
                ),
                trailing: Icon(
                  Boxicons.bx_chevron_right,
                  size: 24.sp,
                ),
                onTap: () {
                  if (item['title'].toLowerCase() == "devise") {
                    showCustomSnackbar(context,
                        "Cette fonctionnalité n'est pas encore disponible.",
                        backgroundColor: Kolor.kTertiary);
                    return;
                  }

                  if (item['title'].toLowerCase() == "téléphone") {
                    showCustomSnackbar(context,
                        "Vous ne pouvez pas modifier votre numéro de téléphone.",
                        backgroundColor: Kolor.kTertiary);
                    return;
                  }

                  if (item['title'].toLowerCase() == "adresse email") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => item['page'],
                      ),
                    );

                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => item['page'],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
