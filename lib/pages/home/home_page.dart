import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/config/app_config.dart';
import '../../core/services/categories_service.dart';
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
        title: Text(l10n.syriaVoyager),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Go to notifications page
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/profile');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        children: [
          // Announcements Bar
          _buildAnnouncementsBar(),
          const SizedBox(height: AppConfig.spacingL),

          // Events & Festivals
          _buildEventsSection(),

          const SizedBox(height: AppConfig.spacingL),
          // Nearby Places (GPS)
          _buildFeaturedSitesSection(),

          const SizedBox(height: AppConfig.spacingL),
          // Trip Suggestions
          _buildTripSuggestionsSection(),
          const SizedBox(height: AppConfig.spacingL),

          const SizedBox(height: AppConfig.spacingL),
          // Personalized Recommendations
          _buildPersonalizedRecommendationsSection(),
          const SizedBox(height: AppConfig.spacingL),
          // Bottom Services Section
          _buildBottomServicesSection(),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsBar() {
    final l10n = AppLocalizations.of(context)!;

    // Sample announcements data
    final announcements = [
      {
        'title': l10n.announcementNewFeature,
        'icon': Icons.new_releases,
        'color': AppConfig.primaryColor,
        'isNew': true,
      },
      {
        'title': l10n.announcementSpecialOffer,
        'icon': Icons.local_offer,
        'color': AppConfig.secondaryColor,
        'isNew': false,
      },
      {
        'title': l10n.announcementEvent,
        'icon': Icons.event,
        'color': AppConfig.syrianRed,
        'isNew': true,
      },
      {
        'title': l10n.announcementUpdate,
        'icon': Icons.system_update,
        'color': AppConfig.syrianGreen,
        'isNew': false,
      },
      {
        'title': l10n.announcementMaintenance,
        'icon': Icons.build,
        'color': AppConfig.syrianGold,
        'isNew': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.announcements,
              style: AppConfig.heading3.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all announcements page
              },
              child: Text(
                l10n.viewAll,
                style: AppConfig.body2.copyWith(
                  color: AppConfig.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConfig.spacingS),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: announcements.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppConfig.spacingM),
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _buildAnnouncementCard(
                title: announcement['title'] as String,
                icon: announcement['icon'] as IconData,
                color: announcement['color'] as Color,
                isNew: announcement['isNew'] as bool,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard({
    required String title,
    required IconData icon,
    required Color color,
    required bool isNew,
  }) {
    return GestureDetector(
      onTap: () {
        // TODO: Show announcement details
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
            backgroundColor: color,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          border: Border.all(
            color: isNew ? color : color.withValues(alpha: 0.3),
            width: isNew ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConfig.spacingM),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConfig.spacingS),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 24,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spacingS),
                  Text(
                    title,
                    style: AppConfig.body2.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isNew)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppConfig.syrianRed,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
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
              color: AppConfig.syrianWhite.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final l10n = AppLocalizations.of(context)!;
    final categories = CategoriesService.getFeaturedCategories(l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.categories, style: AppConfig.heading3),
            TextButton(
              onPressed: () => context.go('/categories'),
              child: Text(
                l10n.viewAll,
                style: AppConfig.body2.copyWith(
                  color: AppConfig.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConfig.spacingM),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppConfig.spacingM,
            mainAxisSpacing: AppConfig.spacingM,
            childAspectRatio: 1.3,
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
    required int count,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: InkWell(
        onTap: () {
          if (route == '/category_detail') {
            context.go('$route?category=$category');
          } else {
            context.go(route);
          }
        },
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
        child: Container(
          padding: const EdgeInsets.all(AppConfig.spacingM),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConfig.radiusM),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.1),
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
                padding: const EdgeInsets.all(AppConfig.spacingS),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: color),
              ),
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
              const SizedBox(height: AppConfig.spacingXS),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppConfig.radiusS),
                ),
                child: Text(
                  '$count',
                  style: AppConfig.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
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
        Text(l10n.nearbyPlaces, style: AppConfig.heading3),
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
                color: AppConfig.primaryColor.withValues(alpha: 0.1),
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
        Text(l10n.eventsFestivals, style: AppConfig.heading3),
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

  Widget _buildTripSuggestionsSection() {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.tripSuggestions, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildTripSuggestionCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalizedRecommendationsSection() {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.recommendedForYou, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildRecommendationCard(index);
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

  Widget _buildTripSuggestionCard(int index) {
    final l10n = AppLocalizations.of(context)!;

    final tripSuggestions = [
      {
        'title': l10n.damascusToPalmyra,
        'duration': l10n.threeDaysTwoCities,
        'desc': l10n.tripSuggestionPalmyraDesc,
        'icon': Icons.route,
        'color': AppConfig.primaryColor,
      },
      {
        'title': l10n.tripSuggestionAleppoTitle,
        'duration': l10n.tripSuggestionAleppoDuration,
        'desc': l10n.tripSuggestionAleppoDesc,
        'icon': Icons.castle,
        'color': AppConfig.syrianRed,
      },
      {
        'title': l10n.tripSuggestionCoastalTitle,
        'duration': l10n.tripSuggestionCoastalDuration,
        'desc': l10n.tripSuggestionCoastalDesc,
        'icon': Icons.beach_access,
        'color': AppConfig.accentColor,
      },
    ];
    final trip = tripSuggestions[index];
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: Container(
        width: 200,
        height: 130,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: trip['color'] as Color,
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Icon(
                    trip['icon'] as IconData,
                    color: AppConfig.syrianWhite,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trip['title'] as String,
                    style:
                        AppConfig.body2.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              trip['duration'] as String,
              style: AppConfig.caption.copyWith(color: trip['color'] as Color),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                trip['desc'] as String,
                style: AppConfig.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(int index) {
    final l10n = AppLocalizations.of(context)!;

    final recommendations = [
      {
        'title': l10n.umayyadMosque,
        'location': l10n.damascus,
        'desc': l10n.recommendationUmayyadDesc,
        'icon': Icons.mosque,
        'color': AppConfig.syrianGold,
        'rating': '4.9',
      },
      {
        'title': l10n.recommendationKrakTitle,
        'location': l10n.recommendationKrakLocation,
        'desc': l10n.recommendationKrakDesc,
        'icon': Icons.castle,
        'color': AppConfig.syrianRed,
        'rating': '4.7',
      },
      {
        'title': l10n.recommendationApameaTitle,
        'location': l10n.recommendationApameaLocation,
        'desc': l10n.recommendationApameaDesc,
        'icon': Icons.landscape,
        'color': AppConfig.accentColor,
        'rating': '4.6',
      },
    ];
    final recommendation = recommendations[index];
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: Container(
        width: 200,
        height: 130,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: recommendation['color'] as Color,
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Icon(
                    recommendation['icon'] as IconData,
                    color: AppConfig.syrianWhite,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    recommendation['title'] as String,
                    style:
                        AppConfig.body2.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: recommendation['color'] as Color,
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 12, color: AppConfig.syrianWhite),
                      const SizedBox(width: 2),
                      Text(
                        recommendation['rating'] as String,
                        style: AppConfig.caption.copyWith(
                          color: AppConfig.syrianWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              recommendation['location'] as String,
              style: AppConfig.caption
                  .copyWith(color: recommendation['color'] as Color),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                recommendation['desc'] as String,
                style: AppConfig.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          border: Border.all(color: color.withValues(alpha: 0.3)),
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

  Widget _buildBottomServicesSection() {
    final l10n = AppLocalizations.of(context)!;

    final services = [
      {
        'icon': Icons.directions_car,
        'label': l10n.transportation,
        'color': AppConfig.primaryColor,
        'onTap': () {
          context.go('/transportation');
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
        'icon': Icons.newspaper,
        'label': l10n.news,
        'color': AppConfig.accentColor,
        'onTap': () {
          context.go('/news');
        },
      },
      {
        'icon': Icons.lightbulb_outline,
        'label': l10n.opportunities,
        'color': AppConfig.secondaryColor,
        'onTap': () {
          context.go('/opportunities');
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
        'icon': Icons.restaurant,
        'label': l10n.restaurants,
        'color': AppConfig.warningColor,
        'onTap': () {
          context.go('/restaurants');
        },
      },
      {
        'icon': Icons.local_hospital,
        'label': l10n.facilities,
        'color': AppConfig.syrianRed,
        'onTap': () {
          context.go('/facilities');
        },
      },
      {
        'icon': Icons.notifications,
        'label': l10n.announcements,
        'color': AppConfig.primaryColor,
        'onTap': () {
          context.go('/announcements');
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.homeBottomServices, style: AppConfig.heading3),
        const SizedBox(height: AppConfig.spacingM),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppConfig.spacingM),
            itemBuilder: (context, index) {
              final service = services[index];
              return _buildBottomServiceCard(
                icon: service['icon'] as IconData,
                label: service['label'] as String,
                color: service['color'] as Color,
                onTap: service['onTap'] as VoidCallback,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomServiceCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(AppConfig.spacingM),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConfig.radiusM),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: AppConfig.spacingS),
            Text(
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
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConfig.spacingS),
      child: Text(
        title,
        style: AppConfig.heading3.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _HorizontalCardList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) cardBuilder;
  const _HorizontalCardList({
    required this.itemCount,
    required this.cardBuilder,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: AppConfig.spacingM),
        itemBuilder: cardBuilder,
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with real offer data
    return GestureDetector(
      onTap: () {
        // TODO: Go to offer details
      },
      child: Card(
        color: AppConfig.secondaryColor.withOpacity(0.1),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_offer,
                size: 48,
                color: AppConfig.secondaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.specialOffer,
                style: AppConfig.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.upTo30Off,
                style: AppConfig.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with real nearby place data (use GPS)
    return GestureDetector(
      onTap: () {
        // TODO: Go to place details
      },
      child: Card(
        color: AppConfig.accentColor.withOpacity(0.1),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.place, size: 48, color: AppConfig.accentColor),
              const SizedBox(height: 12),
              Text(
                l10n.oldCity,
                style: AppConfig.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.damascus,
                style: AppConfig.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripSuggestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with real trip suggestion data
    return GestureDetector(
      onTap: () {
        // TODO: Go to trip planner
        context.go('/trip-planner');
      },
      child: Card(
        color: AppConfig.primaryColor.withOpacity(0.08),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.route, size: 48, color: AppConfig.primaryColor),
              const SizedBox(height: 12),
              Text(
                l10n.damascusToPalmyra,
                style: AppConfig.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.threeDaysTwoCities,
                style: AppConfig.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with real event data
    return GestureDetector(
      onTap: () {
        // TODO: Go to event details
      },
      child: Card(
        color: AppConfig.syrianRed.withOpacity(0.08),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.celebration, size: 48, color: AppConfig.syrianRed),
              const SizedBox(height: 12),
              Text(
                l10n.aleppoFestival,
                style: AppConfig.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.july152024,
                style: AppConfig.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with personalized recommendation data
    return GestureDetector(
      onTap: () {
        // TODO: Go to recommended site details
      },
      child: Card(
        color: AppConfig.syrianGold.withOpacity(0.08),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(AppConfig.spacingM),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 48, color: AppConfig.syrianGold),
              const SizedBox(height: 12),
              Text(
                l10n.umayyadMosque,
                style: AppConfig.body1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.damascus,
                style: AppConfig.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
