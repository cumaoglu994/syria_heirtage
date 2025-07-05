import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/config/app_config.dart';
import 'shared/providers/language_provider.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/providers/auth_provider.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/explore/presentation/pages/explore_page.dart';
import 'features/events/presentation/pages/events_page.dart';
import 'features/tours/presentation/pages/tours_page.dart';
import 'features/shopping/presentation/pages/shopping_page.dart';
import 'features/accommodation/presentation/pages/accommodation_page.dart';
import 'features/ar/presentation/pages/ar_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/profile/presentation/pages/language_demo_page.dart';

void main() {
  runApp(const SyrianHeritageApp());
}

class SyrianHeritageApp extends StatelessWidget {
  const SyrianHeritageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
          return MaterialApp.router(
            title: 'Syrian Heritage',
            debugShowCheckedModeBanner: false,

            // Localization
            locale: languageProvider.currentLocale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ar', 'SA'),
              Locale('ru', 'RU'),
              Locale('fr', 'FR'),
              Locale('zh', 'CN'),
              Locale('tr', 'TR'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Theme
            theme: _buildTheme(themeProvider.isDarkMode),
            darkTheme: _buildTheme(true),
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            // Router
            routerConfig: _buildRouter(),
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(bool isDark) {
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

    return baseTheme.copyWith(
      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppConfig.primaryColor,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? AppConfig.primaryColor
            : AppConfig.surfaceColor,
        foregroundColor: isDark
            ? AppConfig.syrianWhite
            : AppConfig.textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConfig.heading3.copyWith(
          color: isDark ? AppConfig.syrianWhite : AppConfig.textPrimaryColor,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? AppConfig.primaryColor
            : AppConfig.surfaceColor,
        selectedItemColor: AppConfig.secondaryColor,
        unselectedItemColor: isDark
            ? AppConfig.textLightColor
            : AppConfig.textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: isDark
            ? AppConfig.primaryColor.withOpacity(0.1)
            : AppConfig.surfaceColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConfig.radiusL),
        ),
        shadowColor: isDark ? Colors.black : Colors.black.withOpacity(0.1),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryColor,
          foregroundColor: AppConfig.syrianWhite,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppConfig.spacingL,
            vertical: AppConfig.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConfig.radiusM),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? AppConfig.primaryColor.withOpacity(0.1)
            : AppConfig.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          borderSide: BorderSide(
            color: isDark
                ? AppConfig.textLightColor
                : AppConfig.textSecondaryColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          borderSide: const BorderSide(color: AppConfig.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConfig.spacingM,
          vertical: AppConfig.spacingM,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppConfig.heading1,
        displayMedium: AppConfig.heading2,
        displaySmall: AppConfig.heading3,
        bodyLarge: AppConfig.body1,
        bodyMedium: AppConfig.body2,
        labelSmall: AppConfig.caption,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: isDark
          ? AppConfig.primaryColor
          : AppConfig.backgroundColor,
    );
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return _MainScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/explore',
              name: 'explore',
              builder: (context, state) => const ExplorePage(),
            ),
            GoRoute(
              path: '/tours',
              name: 'tours',
              builder: (context, state) => const ToursPage(),
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),

            // Additional routes (not in bottom navigation)
            GoRoute(
              path: '/shopping',
              name: 'shopping',
              builder: (context, state) => const ShoppingPage(),
            ),
            GoRoute(
              path: '/accommodation',
              name: 'accommodation',
              builder: (context, state) => const AccommodationPage(),
            ),
            GoRoute(
              path: '/ar',
              name: 'ar',
              builder: (context, state) => const ARPage(),
            ),
            GoRoute(
              path: '/language-demo',
              name: 'language-demo',
              builder: (context, state) => const LanguageDemoPage(),
            ),
          ],
        ),
      ],
    );
  }
}

class _MainScaffold extends StatefulWidget {
  final Widget child;

  const _MainScaffold({required this.child});

  @override
  State<_MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<_MainScaffold> {
  int _currentIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home, label: 'home', route: '/'),
    NavigationItem(icon: Icons.explore, label: 'explore', route: '/explore'),
    NavigationItem(icon: Icons.map, label: 'tours', route: '/tours'),

    NavigationItem(icon: Icons.person, label: 'profile', route: '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: AppConfig.cardShadow),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            context.go(_navigationItems[index].route);
          },
          type: BottomNavigationBarType.fixed,
          items: _navigationItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: _getLocalizedLabel(item.label),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLocalizedLabel(String key) {
    final l10n = AppLocalizations.of(context);
    switch (key) {
      case 'home':
        return l10n?.home ?? 'Home';
      case 'explore':
        return l10n?.explore ?? 'Explore';
      case 'events':
        return l10n?.events ?? 'Events';
      case 'tours':
        return l10n?.tours ?? 'Tours';
      case 'shopping':
        return l10n?.shopping ?? 'Shopping';
      case 'accommodation':
        return l10n?.accommodation ?? 'Accommodation';
      case 'ar':
        return l10n?.ar ?? 'AR';
      case 'profile':
        return l10n?.profile ?? 'Profile';
      default:
        return key;
    }
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
