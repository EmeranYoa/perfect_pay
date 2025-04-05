import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfect_pay/common/utils/kcolors.dart';
import 'package:perfect_pay/common/widgets/custom_button.dart';

class LanguePage extends StatefulWidget {
  const LanguePage({super.key});

  @override
  State<LanguePage> createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  final List<String> _languages = ['Français', 'Anglais', 'Espagnol'];

  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Changer de langue',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final language = _languages[index];

                  final bool isSelected = (language == _selectedLanguage);

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 16.h,
                      ),
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Kolor.kPrimary.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Nom de la langue
                          Text(
                            language,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Kolor.kSecondary
                                  : Colors.black87,
                            ),
                          ),
                          // Icone pour montrer l'état sélectionné
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: Kolor.kSecondary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              color: Kolor.kPrimary,
              text: 'Enregistrer',
              onPressed: () {
                // TODO: Gérer la sauvegarde ou l'application de la langue
                Navigator.pop(context, _selectedLanguage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
