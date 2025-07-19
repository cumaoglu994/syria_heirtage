import 'package:flutter/material.dart';

class AppConfig {
  // App Colors - Syria Voyager Theme
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep Blue
  static const Color secondaryColor = Color(0xFFD4AF37); // Syrian Gold
  static const Color accentColor = Color(0xFF009639); // Syrian Green
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color successColor = Color(0xFF10B981);
  static const Color textPrimaryColor = Color(0xFF1F2937);
  static const Color textSecondaryColor = Color(0xFF6B7280);
  static const Color textLightColor = Color(0xFF9CA3AF);

  // Syrian Heritage Colors
  static const Color syrianGold = Color(0xFFD4AF37);
  static const Color syrianRed = Color(0xFFCE1126);
  static const Color syrianGreen = Color(0xFF009639);
  static const Color syrianBlack = Color(0xFF000000);
  static const Color syrianWhite = Color(0xFFFFFFFF);
  static const Color syrianBeige = Color(0xFFF5F5DC);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient syrianGradient = LinearGradient(
    colors: [syrianRed, syrianGreen, syrianGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFF7931E), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static TextStyle get heading1 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
    fontFamily: 'Cairo',
  );

  static TextStyle get heading2 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'Cairo',
  );

  static TextStyle get heading3 => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'Cairo',
  );

  static TextStyle get body1 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
    fontFamily: 'Cairo',
  );

  static TextStyle get body2 => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
    fontFamily: 'Cairo',
  );

  static TextStyle get caption => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textLightColor,
    fontFamily: 'Cairo',
  );

  // Arabic Text Styles
  static TextStyle get arabicHeading1 => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimaryColor,
    fontFamily: 'NotoKufiArabic',
  );

  static TextStyle get arabicHeading2 => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    fontFamily: 'NotoKufiArabic',
  );

  static TextStyle get arabicBody1 => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
    fontFamily: 'NotoKufiArabic',
  );

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // App Information
  static const String appName = 'Syria Voyager';
  static const String appNameAr = 'سوريا الساحرة';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Comprehensive Syrian Tourism App';
  static const String appDescriptionAr = 'تطبيق سياحي شامل لسوريا';

  // API Configuration
  static const String baseUrl = 'https://api.syriavoyager.com';
  static const String apiVersion = '/v1';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Firebase Configuration
  static const String firebaseProjectId = 'syria-voyager';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';
  static const String firebaseAppId = 'YOUR_FIREBASE_APP_ID';
  static const String firebaseMessagingSenderId = 'YOUR_SENDER_ID';

  // Map Configuration
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const double defaultMapZoom = 12.0;
  static const double maxMapZoom = 18.0;
  static const double minMapZoom = 5.0;

  // Image Configuration
  static const String imageBaseUrl = 'https://images.syriavoyager.com';
  static const int maxImageSize = 1024;
  static const double imageQuality = 0.8;

  // Cache Configuration
  static const Duration cacheDuration = Duration(days: 7);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // Offline Configuration
  static const int maxOfflineCities = 5;
  static const int maxOfflineDataSize = 500 * 1024 * 1024; // 500MB

  // Notification Configuration
  static const String notificationChannelId = 'syria_voyager_channel';
  static const String notificationChannelName = 'Syria Voyager';
  static const String notificationChannelDescription =
      'Syria Voyager app notifications';

  // QR Code Configuration
  static const int qrCodeSize = 200;
  static const String qrCodeData = 'syria_voyager_ticket';

  // AR Configuration
  static const double arDetectionDistance = 10.0; // meters
  static const int arMaxObjects = 50;

  // Payment Configuration
  static const String currency = 'SYP';
  static const String paymentGateway = 'syrian_payment_switch';
  static const String stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';

  // Audio Guide Configuration
  static const String audioBaseUrl = 'https://audio.syriavoyager.com';
  static const Duration audioCacheDuration = Duration(days: 30);
  static const int maxAudioCacheSize = 200 * 1024 * 1024; // 200MB

  // Social Media
  static const String facebookUrl = 'https://facebook.com/syriavoyager';
  static const String instagramUrl = 'https://instagram.com/syriavoyager';
  static const String twitterUrl = 'https://twitter.com/syriavoyager';
  static const String youtubeUrl = 'https://youtube.com/syriavoyager';
  static const String tiktokUrl = 'https://tiktok.com/@syriavoyager';

  // Support & Contact
  static const String supportEmail = 'support@syriavoyager.com';
  static const String supportPhone = '+963-11-123-4567';
  static const String websiteUrl = 'https://syriavoyager.com';
  static const String ministryEmail = 'tourism@syria.gov.sy';
  static const String ministryPhone = '+963-11-123-4568';

  // Emergency Numbers
  static const String emergencyPolice = '112';
  static const String emergencyAmbulance = '110';
  static const String emergencyFire = '113';
  static const String touristPolice = '+963-11-123-4568';
  static const String touristHotline = '+963-11-123-4569';

  // Tourist Information
  static const String visaInfoUrl = 'https://syriavoyager.com/visa';
  static const String weatherApiUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String weatherApiKey = 'YOUR_WEATHER_API_KEY';

  // Content Categories
  static const List<String> siteCategories = [
    'archaeological',
    'religious',
    'museums',
    'parks',
    'beaches',
    'markets',
    'castle',
    'natural',
    'cultural',
    'entertainment',
  ];

  // Supported Languages
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'ar', 'name': 'العربية', 'nativeName': 'العربية'},
    {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    {'code': 'fr', 'name': 'Français', 'nativeName': 'Français'},
    {'code': 'ru', 'name': 'Русский', 'nativeName': 'Русский'},
  ];

  // Default Settings
  static const String defaultLanguage = 'ar';
  static const bool defaultDarkMode = false;
  static const bool defaultNotifications = true;
  static const bool defaultLocationServices = true;
  static const bool defaultOfflineMode = false;
}
