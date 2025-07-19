import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'shared/providers/language_provider.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/providers/auth_provider.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'pages/home/home_page.dart';
import 'features/events/presentation/pages/events_page.dart';
import 'features/tours/presentation/pages/tours_page.dart';
import 'features/shopping/presentation/pages/shopping_page.dart';
import 'features/accommodation/presentation/pages/accommodation_page.dart';
import 'features/ar/presentation/pages/ar_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/profile/presentation/pages/language_demo_page.dart';
import 'features/explore/presentation/pages/category_detail_page.dart';
import 'features/map/presentation/pages/map_page.dart';
import 'features/discovery/presentation/pages/discovery_page.dart';
import 'features/packages/presentation/pages/packages_page.dart';
import 'features/trip_planner/presentation/pages/trip_planner_page.dart';
import 'features/audio_guide/presentation/pages/audio_guide_page.dart';
import 'features/syriagram/presentation/pages/syriagram_page.dart';
import 'features/support/presentation/pages/support_page.dart';
import 'features/admin/presentation/pages/admin_panel_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (optional - will skip if config files are missing)
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
    print('Continuing without Firebase...');
  }

  // Initialize Hive
  await Hive.initFlutter();

  runApp(const SyriaVoyagerApp());
}

class SyriaVoyagerApp extends StatelessWidget {
  const SyriaVoyagerApp({super.key});

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
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,

            // Localization
            locale: languageProvider.currentLocale,
            supportedLocales: const [
              Locale('ar', 'SA'),
              Locale('en', 'US'),
              Locale('fr', 'FR'),
              Locale('ru', 'RU'),
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
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

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
        backgroundColor:
            isDark ? AppConfig.primaryColor : AppConfig.surfaceColor,
        foregroundColor:
            isDark ? AppConfig.syrianWhite : AppConfig.textPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppConfig.heading3.copyWith(
          color: isDark ? AppConfig.syrianWhite : AppConfig.textPrimaryColor,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            isDark ? AppConfig.primaryColor : AppConfig.surfaceColor,
        selectedItemColor: AppConfig.secondaryColor,
        unselectedItemColor:
            isDark ? AppConfig.textLightColor : AppConfig.textSecondaryColor,
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
      scaffoldBackgroundColor:
          isDark ? AppConfig.primaryColor : AppConfig.backgroundColor,
    );
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/auth',
          name: 'auth',
          builder: (context, state) => const AuthPage(),
        ),
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
              path: '/discovery',
              name: 'discovery',
              builder: (context, state) => const DiscoveryPage(),
            ),
            GoRoute(
              path: '/map',
              name: 'map',
              builder: (context, state) => const MapPage(),
            ),
            GoRoute(
              path: '/events',
              name: 'events',
              builder: (context, state) => const EventsPage(),
            ),
            GoRoute(
              path: '/tours',
              name: 'tours',
              builder: (context, state) => const ToursPage(),
            ),
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
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
            GoRoute(
              path: '/language-demo',
              name: 'language-demo',
              builder: (context, state) => const LanguageDemoPage(),
            ),
            GoRoute(
              path: '/category/:category',
              name: 'category-detail',
              builder: (context, state) {
                final category = state.pathParameters['category'] ?? '';
                return CategoryDetailPage(category: category);
              },
            ),
            GoRoute(
              path: '/packages',
              name: 'packages',
              builder: (context, state) => const PackagesPage(),
            ),
            GoRoute(
              path: '/trip-planner',
              name: 'trip-planner',
              builder: (context, state) => const TripPlannerPage(),
            ),
            GoRoute(
              path: '/audio-guide',
              name: 'audio-guide',
              builder: (context, state) => const AudioGuidePage(),
            ),
            GoRoute(
              path: '/syriagram',
              name: 'syriagram',
              builder: (context, state) => const SyriaGramPage(),
            ),
            GoRoute(
              path: '/support',
              name: 'support',
              builder: (context, state) => const SupportPage(),
            ),
            GoRoute(
              path: '/admin',
              name: 'admin',
              builder: (context, state) => const AdminPanelPage(),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              context.go('/');
              break;

            case 1:
              context.go('/discovery');
              break;
            case 2:
              context.go('/map');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: l10n.discovery,
          ),
          BottomNavigationBarItem(icon: const Icon(Icons.map), label: l10n.map),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}
