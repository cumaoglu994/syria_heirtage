import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/providers/language_provider.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../../core/config/app_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileSettings),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConfig.spacingL),
        children: [
          _buildSection(
            context,
            title: l10n.profileLanguage,
            icon: Icons.language,
            children: [_buildLanguageSelector(context)],
          ),
          const SizedBox(height: AppConfig.spacingL),
          _buildSection(
            context,
            title: l10n.profileNotifications,
            icon: Icons.notifications,
            children: [
              _buildSwitchTile(
                context,
                title: 'Push Notifications',
                subtitle: 'Receive notifications about events and updates',
                value: true,
                onChanged: (value) {
                  // TODO: Implement notification settings
                },
              ),
              _buildSwitchTile(
                context,
                title: 'Email Notifications',
                subtitle: 'Receive email updates',
                value: false,
                onChanged: (value) {
                  // TODO: Implement email notification settings
                },
              ),
            ],
          ),
          const SizedBox(height: AppConfig.spacingL),
          _buildSection(
            context,
            title: l10n.profilePrivacy,
            icon: Icons.privacy_tip,
            children: [
              _buildListTile(
                context,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                icon: Icons.policy,
                onTap: () {
                  // TODO: Navigate to privacy policy
                },
              ),
              _buildListTile(
                context,
                title: 'Terms of Service',
                subtitle: 'Read our terms of service',
                icon: Icons.description,
                onTap: () {
                  // TODO: Navigate to terms of service
                },
              ),
            ],
          ),
          const SizedBox(height: AppConfig.spacingL),
          _buildSection(
            context,
            title: l10n.profileHelp,
            icon: Icons.help,
            children: [
              _buildListTile(
                context,
                title: 'FAQ',
                subtitle: 'Frequently asked questions',
                icon: Icons.question_answer,
                onTap: () {
                  // TODO: Navigate to FAQ
                },
              ),
              _buildListTile(
                context,
                title: 'Contact Support',
                subtitle: 'Get help from our support team',
                icon: Icons.support_agent,
                onTap: () {
                  // TODO: Navigate to contact support
                },
              ),
            ],
          ),
          const SizedBox(height: AppConfig.spacingL),
          _buildSection(
            context,
            title: l10n.profileAbout,
            icon: Icons.info,
            children: [
              _buildListTile(
                context,
                title: 'App Version',
                subtitle: '1.0.0',
                icon: Icons.app_settings_alt,
                onTap: null,
              ),
              _buildListTile(
                context,
                title: 'Developer',
                subtitle: 'Syrian Heritage Team',
                icon: Icons.developer_mode,
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppConfig.primaryColor),
                const SizedBox(width: AppConfig.spacingM),
                Text(
                  title,
                  style: AppConfig.heading3.copyWith(
                    color: AppConfig.textPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConfig.spacingM),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: languageProvider.getSupportedLanguageCodes().map((
        languageCode,
      ) {
        final isSelected =
            languageProvider.getCurrentLanguageCode() == languageCode;

        return ListTile(
          leading: Text(
            languageProvider.getLanguageFlag(languageCode),
            style: const TextStyle(fontSize: 24),
          ),
          title: Text(
            languageProvider.getLanguageName(languageCode),
            style: AppConfig.body1.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: AppConfig.body1),
      subtitle: Text(subtitle, style: AppConfig.caption),
      value: value,
      onChanged: onChanged,
      activeColor: AppConfig.primaryColor,
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppConfig.primaryColor),
      title: Text(title, style: AppConfig.body1),
      subtitle: Text(subtitle, style: AppConfig.caption),
      trailing: onTap != null ? const Icon(Icons.arrow_forward_ios) : null,
      onTap: onTap,
    );
  }
}
