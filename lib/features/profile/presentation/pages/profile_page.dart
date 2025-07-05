import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_config.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConfig.spacingL),
        child: Column(
          children: [
            // Profile Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConfig.radiusL),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.spacingL),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppConfig.primaryColor,
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: AppConfig.syrianWhite,
                      ),
                    ),
                    const SizedBox(width: AppConfig.spacingL),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Guest User',
                            style: AppConfig.heading2.copyWith(
                              color: AppConfig.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: AppConfig.spacingS),
                          Text(
                            'guest@example.com',
                            style: AppConfig.body2.copyWith(
                              color: AppConfig.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConfig.spacingL),

            // Profile Options
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    context,
                    icon: Icons.person,
                    title: l10n.profilePersonalInfo,
                    subtitle: 'Manage your personal information',
                    onTap: () {
                      // TODO: Navigate to personal info page
                    },
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.bookmark,
                    title: l10n.profileMyBookings,
                    subtitle: 'View your booking history',
                    onTap: () {
                      // TODO: Navigate to bookings page
                    },
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.favorite,
                    title: l10n.profileMyFavorites,
                    subtitle: 'Your saved places and tours',
                    onTap: () {
                      // TODO: Navigate to favorites page
                    },
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.rate_review,
                    title: l10n.profileMyReviews,
                    subtitle: 'Your reviews and ratings',
                    onTap: () {
                      // TODO: Navigate to reviews page
                    },
                  ),
                  const SizedBox(height: AppConfig.spacingL),
                  _buildProfileOption(
                    context,
                    icon: Icons.settings,
                    title: l10n.profileSettings,
                    subtitle: 'App settings and preferences',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      );
                    },
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.help,
                    title: l10n.profileHelp,
                    subtitle: 'Get help and support',
                    onTap: () {
                      // TODO: Navigate to help page
                    },
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.language,
                    title: 'Language Demo',
                    subtitle: 'Test localization features',
                    onTap: () {
                      context.go('/language-demo');
                    },
                  ),
                  const SizedBox(height: AppConfig.spacingL),
                  _buildProfileOption(
                    context,
                    icon: Icons.logout,
                    title: l10n.profileLogout,
                    subtitle: 'Sign out of your account',
                    onTap: () {
                      // TODO: Implement logout
                      _showLogoutDialog(context);
                    },
                    isDestructive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : AppConfig.primaryColor,
        ),
        title: Text(
          title,
          style: AppConfig.body1.copyWith(
            color: isDestructive ? Colors.red : AppConfig.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppConfig.caption.copyWith(
            color: AppConfig.textSecondaryColor,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement logout logic
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
