import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/config/app_config.dart';

/// Discovery page with modern Gaziantep app design
class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  String _selectedCategory = 'all';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppConfig.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar Section
            _buildSearchBar(l10n),

            // Main Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 16),

                  // Announcements Section
                  //   _buildAnnouncementsSection(l10n),
                  const SizedBox(height: 24),

                  // Categories Section
                  _buildCategoriesSection(l10n),
                  const SizedBox(height: 24),

                  // Featured Sites Section
                  _buildFeaturedSitesSection(l10n),
                  const SizedBox(height: 24),

                  // Individual Category Sections
                  _buildCategorySections(l10n),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              context.pop();
            },
          ),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchPlaceholder,
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey[600]),
                    onPressed: () => _searchController.clear(),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsSection(AppLocalizations l10n) {
    final announcements = [
      {
        'title': l10n.discoveryNewDiscoveryRoutes,
        'icon': Icons.explore,
        'color': Colors.pink,
        'isNew': true,
      },
      {
        'title': l10n.discoverySpecialTourOffers,
        'icon': Icons.local_offer,
        'color': Colors.orange,
        'isNew': true,
      },
      {
        'title': l10n.discoveryCulturalEvents,
        'icon': Icons.event,
        'color': Colors.purple,
        'isNew': false,
      },
      {
        'title': l10n.discoveryMuseumUpdates,
        'icon': Icons.museum,
        'color': Colors.blue,
        'isNew': false,
      },
      {
        'title': l10n.discoveryArchaeologicalDiscoveries,
        'icon': Icons.architecture,
        'color': Colors.green,
        'isNew': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.discoveryAnnouncements,
          style: AppConfig.heading3.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConfig.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: announcements.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return _buildAnnouncementCard(announcement);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementCard(Map<String, dynamic> announcement) {
    return GestureDetector(
      onTap: () {
        // TODO: Show announcement details
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              announcement['color'] as Color,
              (announcement['color'] as Color).withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: (announcement['color'] as Color).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    announcement['icon'] as IconData,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      announcement['title'] as String,
                      style: AppConfig.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (announcement['isNew'] as bool)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(AppLocalizations l10n) {
    final categories = [
      {
        'id': 'all',
        'name': l10n.discoveryAll,
        'icon': Icons.all_inclusive,
        'color': AppConfig.primaryColor,
      },
      {
        'id': 'archaeological',
        'name': l10n.discoveryArchaeologicalSites,
        'icon': Icons.architecture,
        'color': AppConfig.syrianGold,
      },
      {
        'id': 'religious',
        'name': l10n.discoveryReligiousPlaces,
        'icon': Icons.church,
        'color': AppConfig.syrianGreen,
      },
      {
        'id': 'museums',
        'name': l10n.discoveryMuseums,
        'icon': Icons.museum,
        'color': AppConfig.syrianRed,
      },
      {
        'id': 'parks',
        'name': l10n.discoveryParks,
        'icon': Icons.park,
        'color': AppConfig.accentColor,
      },
      {
        'id': 'beaches',
        'name': l10n.discoveryBeaches,
        'icon': Icons.beach_access,
        'color': AppConfig.secondaryColor,
      },
      {
        'id': 'markets',
        'name': l10n.discoveryMarkets,
        'icon': Icons.store,
        'color': AppConfig.syrianBlack,
      },
      {
        'id': 'castle',
        'name': l10n.discoveryCastles,
        'icon': Icons.castle,
        'color': AppConfig.syrianGold,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.discoveryCategories,
          style: AppConfig.heading3.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConfig.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _selectedCategory == category['id'];
              return _buildCategoryCard(category, isSelected);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category['id'];
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? category['color'] as Color
                  : (category['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: isSelected
                  ? Border.all(color: category['color'] as Color, width: 2)
                  : null,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (category['color'] as Color).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              category['icon'] as IconData,
              color: isSelected ? Colors.white : category['color'] as Color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category['name'] as String,
            style: AppConfig.caption.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? category['color'] as Color
                  : AppConfig.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSitesSection(AppLocalizations l10n) {
    final featuredSites = [
      {
        'title': l10n.featuredSitePalmyraTitle,
        'subtitle': l10n.featuredSitePalmyraSubtitle,
        'desc': l10n.featuredSitePalmyraDesc,
        'image': null,
        'color': AppConfig.primaryColor,
        'rating': '4.9',
      },
      {
        'title': l10n.featuredSiteUmayyadTitle,
        'subtitle': l10n.featuredSiteUmayyadSubtitle,
        'desc': l10n.featuredSiteUmayyadDesc,
        'image': null,
        'color': AppConfig.syrianRed,
        'rating': '4.8',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.discoveryFeaturedSites,
          style: AppConfig.heading3.copyWith(
            fontWeight: FontWeight.bold,
            color: AppConfig.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: featuredSites.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return _buildFeaturedSiteCard(featuredSites[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSiteCard(Map<String, dynamic> site) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Site Image/Header
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: site['color'] as Color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // TODO: Add real image here
                Center(
                  child: Icon(
                    Icons.photo,
                    size: 48,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          site['rating'] as String,
                          style: AppConfig.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Site Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    site['title'] as String,
                    style: AppConfig.body2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConfig.textPrimaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    site['subtitle'] as String,
                    style: AppConfig.caption.copyWith(
                      color: AppConfig.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    child: Text(
                      site['desc'] as String,
                      style: AppConfig.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllSitesSection(AppLocalizations l10n) {
    final sites = _getSitesForCategory(_selectedCategory);
    final categoryName = _getCategoryName(_selectedCategory);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: AppConfig.heading3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppConfig.textPrimaryColor,
              ),
            ),
            Text(
              l10n.discoveryPlacesCount(sites.length),
              style: AppConfig.body2.copyWith(
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sites.isEmpty)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppConfig.textSecondaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.discoveryNoPlacesInCategory,
                  style: AppConfig.body1.copyWith(
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sites.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return _buildSiteCard(sites[index], l10n);
            },
          ),
      ],
    );
  }

  String _getCategoryName(String categoryId) {
    final l10n = AppLocalizations.of(context)!;
    switch (categoryId) {
      case 'all':
        return l10n.discoveryAllSites;
      case 'archaeological':
        return l10n.discoveryArchaeologicalSites;
      case 'religious':
        return l10n.discoveryReligiousPlaces;
      case 'museums':
        return l10n.discoveryMuseums;
      case 'parks':
        return l10n.discoveryParks;
      case 'beaches':
        return l10n.discoveryBeaches;
      case 'markets':
        return l10n.discoveryMarkets;
      case 'castle':
        return l10n.discoveryCastles;
      default:
        return l10n.discoveryAllSites;
    }
  }

  Widget _buildCategorySections(AppLocalizations l10n) {
    final categories = [
      {
        'id': 'archaeological',
        'name': l10n.discoveryArchaeologicalSites,
        'icon': Icons.architecture,
        'color': AppConfig.syrianGold,
      },
      {
        'id': 'religious',
        'name': l10n.discoveryReligiousPlaces,
        'icon': Icons.church,
        'color': AppConfig.syrianGreen,
      },
      {
        'id': 'museums',
        'name': l10n.discoveryMuseums,
        'icon': Icons.museum,
        'color': AppConfig.syrianRed,
      },
      {
        'id': 'parks',
        'name': l10n.discoveryParks,
        'icon': Icons.park,
        'color': AppConfig.accentColor,
      },
      {
        'id': 'beaches',
        'name': l10n.discoveryBeaches,
        'icon': Icons.beach_access,
        'color': AppConfig.secondaryColor,
      },
      {
        'id': 'markets',
        'name': l10n.discoveryMarkets,
        'icon': Icons.store,
        'color': AppConfig.syrianBlack,
      },
      {
        'id': 'castle',
        'name': l10n.discoveryCastles,
        'icon': Icons.castle,
        'color': AppConfig.syrianGold,
      },
    ];

    return Column(
      children: categories.map((category) {
        final sites = _getSitesForCategory(category['id'] as String);
        if (sites.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            const SizedBox(height: 24),
            _buildCategorySection(category, sites, l10n),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCategorySection(Map<String, dynamic> category,
      List<Map<String, dynamic>> sites, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: category['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                category['icon'] as IconData,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                category['name'] as String,
                style: AppConfig.body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConfig.textPrimaryColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: category['color'] as Color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                sites.length.toString(),
                style: AppConfig.caption.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Sites in this category
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sites.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _buildCategorySiteCard(
                  sites[index], category['color'] as Color, l10n);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySiteCard(
      Map<String, dynamic> site, Color categoryColor, AppLocalizations l10n) {
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
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    site['name'],
                    style: AppConfig.body2.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.circular(AppConfig.radiusS),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.white),
                      const SizedBox(width: 2),
                      Text(
                        (site['rating'] as num).toString(),
                        style: AppConfig.caption.copyWith(
                          color: Colors.white,
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
              site['nameAr'],
              style: AppConfig.caption.copyWith(color: categoryColor),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                site['description'],
                style: AppConfig.caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 12,
                  color: categoryColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    site['city'],
                    style: AppConfig.caption.copyWith(
                      color: categoryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (site['entranceFee'] > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppConfig.syrianGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '\$${site['entranceFee']}',
                      style: AppConfig.caption.copyWith(
                        color: AppConfig.syrianGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppConfig.syrianGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      l10n.free,
                      style: AppConfig.caption.copyWith(
                        color: AppConfig.syrianGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiteCard(Map<String, dynamic> site, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Site Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                // TODO: Replace with real image
                Center(
                  child: Icon(
                    Icons.photo,
                    size: 64,
                    color: AppConfig.primaryColor,
                  ),
                ),
                // Rating
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppConfig.syrianGold,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          (site['rating'] as num).toString(),
                          style: AppConfig.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Site Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  site['name'],
                  style: AppConfig.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  site['nameAr'],
                  style: AppConfig.body2.copyWith(
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  site['description'],
                  style: AppConfig.body1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppConfig.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(site['city'], style: AppConfig.body2),
                    const Spacer(),
                    if (site['entranceFee'] > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppConfig.syrianGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${site['entranceFee']}',
                          style: AppConfig.body2.copyWith(
                            color: AppConfig.syrianGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppConfig.syrianGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          l10n.free,
                          style: AppConfig.body2.copyWith(
                            color: AppConfig.syrianGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: AppConfig.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                icon: Icons.explore,
                label: l10n.discovery,
                onTap: () => context.go('/discovery'),
              ),
              _buildBottomNavItem(
                icon: Icons.map,
                label: l10n.map,
                onTap: () => context.go('/map'),
              ),
              _buildBottomNavItem(
                icon: Icons.favorite,
                label: l10n.favorites,
                onTap: () => context.go('/favorites'),
              ),
              _buildBottomNavItem(
                icon: Icons.person,
                label: l10n.profile,
                onTap: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppConfig.caption.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSitesForCategory(String category) {
    final l10n = AppLocalizations.of(context)!;
    // TODO: Replace with real data from Firebase
    final allSites = [
      {
        'id': '1',
        'name': l10n.sitePalmyraName,
        'nameAr': 'تدمر',
        'description': l10n.sitePalmyraDesc,
        'descriptionAr': 'مدينة قديمة وموقع تراث عالمي مع أطلال مذهلة',
        'category': 'archaeological',
        'city': l10n.cityTadmur,
        'cityAr': 'تدمر',
        'rating': 4.8,
        'image': 'https://example.com/palmyra.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '2',
        'name': l10n.siteUmayyadName,
        'nameAr': 'الجامع الأموي',
        'description': l10n.siteUmayyadDesc,
        'descriptionAr': 'واحدة من أكبر وأقدم المساجد في العالم',
        'category': 'religious',
        'city': l10n.cityDamascus,
        'cityAr': 'دمشق',
        'rating': 4.9,
        'image': 'https://example.com/umayyad.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '3',
        'name': l10n.siteKrakName,
        'nameAr': 'قلعة الحصن',
        'description': l10n.siteKrakDesc,
        'descriptionAr':
            'قلعة صليبية من العصور الوسطى، واحدة من أفضل القلاع المحفوظة',
        'category': 'castle',
        'city': l10n.cityHoms,
        'cityAr': 'حمص',
        'rating': 4.7,
        'image': 'https://example.com/krak.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '4',
        'name': l10n.siteMuseumName,
        'nameAr': 'المتحف الوطني بدمشق',
        'description': l10n.siteMuseumDesc,
        'descriptionAr': 'يحتوي على مجموعات أثرية مهمة من سوريا',
        'category': 'museums',
        'city': l10n.cityDamascus,
        'cityAr': 'دمشق',
        'rating': 4.6,
        'image': 'https://example.com/museum.jpg',
        'entranceFee': 5.0,
      },
      {
        'id': '5',
        'name': l10n.siteParkName,
        'nameAr': 'حديقة تشرين',
        'description': l10n.siteParkDesc,
        'descriptionAr': 'حديقة عامة جميلة في دمشق',
        'category': 'parks',
        'city': l10n.cityDamascus,
        'cityAr': 'دمشق',
        'rating': 4.3,
        'image': 'https://example.com/park.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '6',
        'name': l10n.siteBeachName,
        'nameAr': 'شاطئ اللاذقية',
        'description': l10n.siteBeachDesc,
        'descriptionAr': 'شاطئ جميل على البحر المتوسط',
        'category': 'beaches',
        'city': l10n.cityLatakia,
        'cityAr': 'اللاذقية',
        'rating': 4.4,
        'image': 'https://example.com/beach.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '7',
        'name': l10n.siteAleppoName,
        'nameAr': 'قلعة حلب',
        'description': l10n.siteAleppoDesc,
        'descriptionAr': 'قلعة من العصور الوسطى في وسط حلب',
        'category': 'castle',
        'city': l10n.cityAleppo,
        'cityAr': 'حلب',
        'rating': 4.5,
        'image': 'https://example.com/aleppo-citadel.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '8',
        'name': l10n.siteSouqName,
        'nameAr': 'سوق الحميدية',
        'description': l10n.siteSouqDesc,
        'descriptionAr': 'سوق تاريخي مسقوف في دمشق',
        'category': 'markets',
        'city': l10n.cityDamascus,
        'cityAr': 'دمشق',
        'rating': 4.2,
        'image': 'https://example.com/souq.jpg',
        'entranceFee': 0.0,
      },
    ];

    // First filter by category
    List<Map<String, dynamic>> filteredSites;
    if (category == 'all') {
      filteredSites = allSites;
    } else {
      filteredSites =
          allSites.where((site) => site['category'] == category).toList();
    }

    // Then filter by search text if any
    if (_searchController.text.isNotEmpty) {
      final searchText = _searchController.text.toLowerCase();
      filteredSites = filteredSites.where((site) {
        return site['name'].toString().toLowerCase().contains(searchText) ||
            site['nameAr'].toString().toLowerCase().contains(searchText) ||
            site['description'].toString().toLowerCase().contains(searchText) ||
            site['city'].toString().toLowerCase().contains(searchText);
      }).toList();
    }

    return filteredSites;
  }
}
