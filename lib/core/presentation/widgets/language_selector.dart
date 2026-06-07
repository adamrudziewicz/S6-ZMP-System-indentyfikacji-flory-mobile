import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../../../../main.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          Localizations.localeOf(context).languageCode.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
            fontSize: 14,
          ),
        ),
      ),
      onSelected: (String langCode) {
        MyApp.setLocale(context, Locale(langCode));
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'pl',
          child: Text('PL', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const PopupMenuItem<String>(
          value: 'en',
          child: Text('EN', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
