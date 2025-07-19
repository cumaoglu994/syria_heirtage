import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../core/config/app_config.dart';
import '../core/services/categories_service.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(l10n),
            const SizedBox(height: AppConfig.spacingL),
            _buildCategoriesSection(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConfig.spacingL),
      decoration: BoxDecoration(
        gradient: AppConfig.syrianGradient,
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
        boxShadow: AppConfig.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.categories,
            style: AppConfig.heading2.copyWith(
              color: AppConfig.syrianWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.spacingS),
          Text(
            'Discover Syria\'s diverse cultural heritage through different categories',
            style: AppConfig.body1.copyWith(
              color: AppConfig.syrianWhite.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(AppLocalizations l10n) {
    final categories = CategoriesService.getCategories(l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Explore Categories', style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppConfig.spacingM,
            mainAxisSpacing: AppConfig.spacingM,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              icon: category['icon'] as IconData,
              name: category['name'] as String,
              color: category['color'] as Color,
              route: category['route'] as String,
              category: category['category'] as String,
              description: category['description'] as String,
              count: category['count'] as int,
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String name,
    required Color color,
    required String route,
    required String category,
    required String description,
    required int count,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: InkWell(
        onTap: () {
          if (route == '/category_detail') {
            context.go('$route?category=$category');
          } else {
            context.go(route);
          }
        },
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
        child: Container(
          padding: const EdgeInsets.all(AppConfig.spacingM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.radiusL),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppConfig.spacingM),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: AppConfig.spacingM),
              Text(
                name,
                style: AppConfig.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConfig.spacingS),
              Text(
                description,
                style: AppConfig.caption.copyWith(
                  color: AppConfig.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConfig.spacingS),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConfig.spacingS,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConfig.radiusS),
                ),
                child: Text(
                  '$count places',
                  style: AppConfig.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
