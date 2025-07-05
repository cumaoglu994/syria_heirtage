import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';

  Locale _currentLocale = const Locale('en', 'US');

  // Desteklenen diller
  final Map<String, Locale> _supportedLocales = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', 'SA'),
    'ru': const Locale('ru', 'RU'),
    'fr': const Locale('fr', 'FR'),
    'zh': const Locale('zh', 'CN'),
    'tr': const Locale('tr', 'TR'),
  };

  // Dil isimleri
  final Map<String, String> _languageNames = {
    'en': 'English',
    'ar': 'العربية',
    'ru': 'Русский',
    'fr': 'Français',
    'zh': '中文',
    'tr': 'Türkçe',
  };

  // Bayrak emojileri
  final Map<String, String> _languageFlags = {
    'en': '🇺🇸',
    'ar': '🇸🇦',
    'ru': '🇷🇺',
    'fr': '🇫🇷',
    'zh': '🇨🇳',
    'tr': '🇹🇷',
  };

  LanguageProvider() {
    _initializeLanguage();
  }

  void _initializeLanguage() {
    // Sistem dilini al
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    final systemLanguageCode = systemLocale.languageCode;

    // Eğer sistem dili destekleniyorsa onu kullan, yoksa İngilizce
    if (_supportedLocales.containsKey(systemLanguageCode)) {
      _currentLocale = _supportedLocales[systemLanguageCode]!;
    } else {
      _currentLocale = const Locale('en', 'US');
    }

    print('Initialized with language: ${_currentLocale.languageCode}');
    notifyListeners();
  }

  Locale get currentLocale => _currentLocale;

  Map<String, Locale> get supportedLocales => _supportedLocales;

  String getCurrentLanguageCode() {
    return _currentLocale.languageCode;
  }

  bool isRTL() {
    return _currentLocale.languageCode == 'ar';
  }

  String getLanguageName(String languageCode) {
    return _languageNames[languageCode] ?? languageCode;
  }

  String getLanguageFlag(String languageCode) {
    return _languageFlags[languageCode] ?? '🌐';
  }

  Future<void> setLanguage(String languageCode) async {
    if (_supportedLocales.containsKey(languageCode)) {
      _currentLocale = _supportedLocales[languageCode]!;
      print('Language changed to: $languageCode');
      notifyListeners();
    } else {
      print('Unsupported language code: $languageCode');
    }
  }

  // Desteklenen dillerin listesini döndür
  List<String> getSupportedLanguageCodes() {
    return _supportedLocales.keys.toList();
  }

  // Mevcut dilin adını döndür
  String getCurrentLanguageName() {
    return getLanguageName(_currentLocale.languageCode);
  }

  // Mevcut dilin bayrağını döndür
  String getCurrentLanguageFlag() {
    return getLanguageFlag(_currentLocale.languageCode);
  }
}
