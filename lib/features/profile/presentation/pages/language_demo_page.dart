import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/providers/language_provider.dart';
import '../../../../core/config/app_config.dart';

class LanguageDemoPage extends StatelessWidget {
  const LanguageDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Language Demo'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Language Info
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Language', style: AppConfig.heading3),
                    const SizedBox(height: AppConfig.spacingM),
                    Row(
                      children: [
                        Text(
                          languageProvider.getCurrentLanguageFlag(),
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: AppConfig.spacingM),
                        Text(
                          languageProvider.getCurrentLanguageName(),
                          style: AppConfig.heading2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConfig.spacingL),

            // Localized Text Examples
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Localized Text Examples', style: AppConfig.heading3),
                    const SizedBox(height: AppConfig.spacingM),
                    _buildLocalizedTextRow('App Title', l10n.appTitle),
                    _buildLocalizedTextRow('App Subtitle', l10n.appSubtitle),
                    _buildLocalizedTextRow('Home', l10n.home),
                    _buildLocalizedTextRow('Explore', l10n.explore),
                    _buildLocalizedTextRow('Events', l10n.events),
                    _buildLocalizedTextRow('Tours', l10n.tours),
                    _buildLocalizedTextRow('Shopping', l10n.shopping),
                    _buildLocalizedTextRow('Accommodation', l10n.accommodation),
                    _buildLocalizedTextRow('Profile', l10n.profile),
                    _buildLocalizedTextRow('AR Experience', l10n.ar),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConfig.spacingL),

            // Language Selection
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Change Language', style: AppConfig.heading3),
                    const SizedBox(height: AppConfig.spacingM),
                    ...languageProvider.getSupportedLanguageCodes().map((
                      languageCode,
                    ) {
                      final isSelected =
                          languageProvider.getCurrentLanguageCode() ==
                          languageCode;

                      return ListTile(
                        leading: Text(
                          languageProvider.getLanguageFlag(languageCode),
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(
                          languageProvider.getLanguageName(languageCode),
                          style: AppConfig.body1.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check, color: AppConfig.primaryColor)
                            : null,
                        onTap: () {
                          languageProvider.setLanguage(languageCode);
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalizedTextRow(String label, String localizedText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConfig.spacingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppConfig.caption.copyWith(
                color: AppConfig.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Text(localizedText, style: AppConfig.body1)),
        ],
      ),
    );
  }
}
