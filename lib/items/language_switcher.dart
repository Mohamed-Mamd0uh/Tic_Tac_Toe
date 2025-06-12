import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/localization/local_controller.dart';
import 'package:tic_tac_toe/theme/colors.dart';
import 'package:tic_tac_toe/theme/text_strings.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  void _showLanguageDialog(BuildContext context) {
    final LocalController localController = Get.find<LocalController>();

    Get.dialog(
      Dialog(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                MTexts.changeLanguage.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _LanguageOption(
                language: MTexts.english.tr,
                onTap: () {
                  localController.changeLang('en_US');
                  Get.back();
                },
                isSelected: Get.locale?.languageCode == 'en',
              ),
              const SizedBox(height: 10),
              _LanguageOption(
                language: MTexts.arabic.tr,
                onTap: () {
                  localController.changeLang('ar_AR');
                  Get.back();
                },
                isSelected: Get.locale?.languageCode == 'ar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showLanguageDialog(context),
      icon: const Icon(Icons.translate, color: Colors.white),
      tooltip: MTexts.language.tr,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final VoidCallback onTap;
  final bool isSelected;

  const _LanguageOption({
    required this.language,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? primaryColorLight : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
