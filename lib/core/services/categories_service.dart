import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../config/app_config.dart';

class CategoriesService {
  static List<Map<String, dynamic>> getCategories(AppLocalizations l10n) {
    return [
      {
        'icon': Icons.architecture,
        'name': l10n.categoriesArchaeological,
        'color': AppConfig.syrianGold,
        'route': '/category_detail',
        'category': 'Archaeological',
        'description': 'Ancient ruins and historical sites',
        'count': 45,
      },
      {
        'icon': Icons.museum,
        'name': l10n.categoriesMuseums,
        'color': AppConfig.syrianRed,
        'route': '/category_detail',
        'category': 'Museums',
        'description': 'Cultural and historical museums',
        'count': 23,
      },
      {
        'icon': Icons.church,
        'name': l10n.categoriesMosques,
        'color': AppConfig.syrianGreen,
        'route': '/category_detail',
        'category': 'Religious',
        'description': 'Mosques, churches and religious sites',
        'count': 67,
      },
      {
        'icon': Icons.park,
        'name': l10n.categoriesParks,
        'color': AppConfig.primaryColor,
        'route': '/category_detail',
        'category': 'Parks',
        'description': 'Public parks and gardens',
        'count': 34,
      },
      {
        'icon': Icons.beach_access,
        'name': l10n.categoriesBeaches,
        'color': AppConfig.secondaryColor,
        'route': '/category_detail',
        'category': 'Beaches',
        'description': 'Coastal areas and beaches',
        'count': 18,
      },
      {
        'icon': Icons.store,
        'name': l10n.categoriesMarkets,
        'color': AppConfig.accentColor,
        'route': '/category_detail',
        'category': 'Markets',
        'description': 'Traditional markets and souks',
        'count': 29,
      },
    ];
  }

  static List<Map<String, dynamic>> getFeaturedCategories(
    AppLocalizations l10n,
  ) {
    final allCategories = getCategories(l10n);
    // Return first 4 categories for featured section
    return allCategories.take(4).toList();
  }

  static Map<String, dynamic>? getCategoryByType(
    String categoryType,
    AppLocalizations l10n,
  ) {
    final categories = getCategories(l10n);
    try {
      return categories.firstWhere(
        (category) => category['category'] == categoryType,
      );
    } catch (e) {
      return null;
    }
  }
}
