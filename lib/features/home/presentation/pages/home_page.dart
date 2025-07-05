import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/config/app_config.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: AppConfig.spacingL),
            _buildCategoriesSection(),
            const SizedBox(height: AppConfig.spacingL),
            _buildFeaturedSitesSection(),
            const SizedBox(height: AppConfig.spacingL),
            _buildEventsSection(),
            const SizedBox(height: AppConfig.spacingL),
            _buildQuickActionsSection(),
            const SizedBox(height: AppConfig.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final l10n = AppLocalizations.of(context)!;

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
            l10n.appTitle,
            style: AppConfig.heading2.copyWith(
              color: AppConfig.syrianWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.spacingS),
          Text(
            l10n.appSubtitle,
            style: AppConfig.body1.copyWith(
              color: AppConfig.syrianWhite.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final l10n = AppLocalizations.of(context)!;

    final categories = [
      {
        'icon': Icons.architecture,
        'name': l10n.categoriesArchaeological,
        'color': AppConfig.syrianGold,
      },
      {
        'icon': Icons.museum,
        'name': l10n.categoriesMuseums,
        'color': AppConfig.syrianRed,
      },
      {
        'icon': Icons.church,
        'name': l10n.categoriesMosques,
        'color': AppConfig.syrianGreen,
      },
      {
        'icon': Icons.park,
        'name': l10n.categoriesParks,
        'color': AppConfig.primaryColor,
      },
      {
        'icon': Icons.beach_access,
        'name': l10n.categoriesBeaches,
        'color': AppConfig.secondaryColor,
      },
      {
        'icon': Icons.store,
        'name': l10n.categoriesMarkets,
        'color': AppConfig.accentColor,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.categories, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppConfig.spacingM,
            mainAxisSpacing: AppConfig.spacingM,
            childAspectRatio: 1.5,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              icon: category['icon'] as IconData,
              name: category['name'] as String,
              color: category['color'] as Color,
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
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Kategoriye git
        },
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppConfig.spacingM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.radiusM),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: AppConfig.spacingS),
              Text(
                name,
                style: AppConfig.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: color,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSitesSection() {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeFeaturedSites, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildFeaturedSiteCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSiteCard(int index) {
    final l10n = AppLocalizations.of(context)!;

    final featuredSites = [
      {
        'title': l10n.featuredSitePalmyra,
        'desc': l10n.featuredSitePalmyraDesc,
        'image': null, // TODO: Görsel ekle
      },
      {
        'title': l10n.featuredSiteUmayyad,
        'desc': l10n.featuredSiteUmayyadDesc,
        'image': null,
      },
      {
        'title': l10n.featuredSiteKrak,
        'desc': l10n.featuredSiteKrakDesc,
        'image': null,
      },
    ];
    final site = featuredSites[index];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppConfig.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.radiusS),
              ),
              child: const Icon(Icons.photo, size: 48, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              site['title'] as String,
              style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              site['desc'] as String,
              style: AppConfig.body2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsSection() {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeEvents, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildEventCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(int index) {
    final l10n = AppLocalizations.of(context)!;

    final events = [
      {
        'title': l10n.eventAleppoFestival,
        'date': l10n.eventAleppoFestivalDate,
        'desc': l10n.eventAleppoFestivalDesc,
      },
      {
        'title': l10n.eventDamascusWalk,
        'date': l10n.eventDamascusWalkDate,
        'desc': l10n.eventDamascusWalkDesc,
      },
    ];
    final event = events[index];
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['title'] as String,
              style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              event['date'] as String,
              style: AppConfig.body2.copyWith(color: AppConfig.primaryColor),
            ),
            const SizedBox(height: 4),
            Text(
              event['desc'] as String,
              style: AppConfig.body2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    final l10n = AppLocalizations.of(context)!;

    final actions = [
      {
        'icon': Icons.qr_code,
        'label': l10n.quickActionQrPass,
        'color': AppConfig.primaryColor,
        'onTap': () {
          // TODO: Navigate to QR Pass page
        },
      },
      {
        'icon': Icons.map,
        'label': l10n.quickActionMap,
        'color': AppConfig.secondaryColor,
        'onTap': () {
          // TODO: Navigate to Map page
        },
      },
      {
        'icon': Icons.event,
        'label': l10n.events,
        'color': AppConfig.syrianGreen,
        'onTap': () {
          context.go('/events');
        },
      },
      {
        'icon': Icons.shopping_bag,
        'label': l10n.shopping,
        'color': AppConfig.syrianRed,
        'onTap': () {
          context.go('/shopping');
        },
      },
      {
        'icon': Icons.hotel,
        'label': l10n.accommodation,
        'color': AppConfig.syrianGold,
        'onTap': () {
          context.go('/accommodation');
        },
      },
      {
        'icon': Icons.camera_alt,
        'label': l10n.ar,
        'color': AppConfig.accentColor,
        'onTap': () {
          context.go('/ar');
        },
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeQuickActions, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppConfig.spacingM,
                mainAxisSpacing: AppConfig.spacingM,
                childAspectRatio: 1.1,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                final action = actions[index];
                return _buildQuickActionButton(
                  icon: action['icon'] as IconData,
                  label: action['label'] as String,
                  color: action['color'] as Color,
                  onTap: action['onTap'] as VoidCallback,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConfig.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppConfig.spacingS),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                label,
                style: AppConfig.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
