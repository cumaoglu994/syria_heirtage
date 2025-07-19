import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_config.dart';

/// Authentication page (login/register/guest/language)
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConfig.spacingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.travel_explore,
                  size: 72,
                  color: AppConfig.primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Syria Voyager',
                  style: AppConfig.heading2.copyWith(
                    color: AppConfig.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'سوريا الساحرة',
                  style: AppConfig.arabicHeading2.copyWith(
                    color: AppConfig.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Email login
                ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: const Text('Sign in with Email'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: AppConfig.primaryColor,
                  ),
                  onPressed: () {
                    // TODO: Implement email login
                  },
                ),
                const SizedBox(height: 16),
                // Phone login
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text('Sign in with Phone'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: AppConfig.accentColor,
                  ),
                  onPressed: () {
                    // TODO: Implement phone login
                  },
                ),
                const SizedBox(height: 16),
                // Google login
                OutlinedButton.icon(
                  icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                  label: const Text('Sign in with Google'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () {
                    // TODO: Implement Google login
                  },
                ),
                const SizedBox(height: 8),
                // Facebook login
                OutlinedButton.icon(
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  label: const Text('Sign in with Facebook'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () {
                    // TODO: Implement Facebook login
                  },
                ),
                const SizedBox(height: 24),
                // Guest login
                TextButton(
                  child: const Text('Continue as Guest'),
                  onPressed: () {
                    context.go('/');
                  },
                ),
                const SizedBox(height: 24),
                // Language selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.language, size: 20),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: 'ar',
                      items: const [
                        DropdownMenuItem(value: 'ar', child: Text('العربية')),
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'fr', child: Text('Français')),
                        DropdownMenuItem(value: 'ru', child: Text('Русский')),
                      ],
                      onChanged: (lang) {
                        // TODO: Change app language
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Register link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      child: const Text('Register'),
                      onPressed: () {
                        // TODO: Implement registration
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
