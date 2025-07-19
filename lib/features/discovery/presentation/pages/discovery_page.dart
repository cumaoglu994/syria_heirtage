import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/models/tourist_site.dart';

/// Discovery page with categories and site cards
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

    final List<Map<String, dynamic>> _categories = [
      {
        'id': 'all',
        'name': l10n.categories,
        'icon': Icons.all_inclusive,
        'color': AppConfig.primaryColor,
      },
      {
        'id': 'archaeological',
        'name': l10n.categoriesArchaeological,
        'icon': Icons.architecture,
        'color': AppConfig.syrianGold,
      },
      {
        'id': 'religious',
        'name': l10n.categoriesMosques,
        'icon': Icons.church,
        'color': AppConfig.syrianGreen,
      },
      {
        'id': 'museums',
        'name': l10n.categoriesMuseums,
        'icon': Icons.museum,
        'color': AppConfig.syrianRed,
      },
      {
        'id': 'parks',
        'name': l10n.categoriesParks,
        'icon': Icons.park,
        'color': AppConfig.accentColor,
      },
      {
        'id': 'beaches',
        'name': l10n.categoriesBeaches,
        'icon': Icons.beach_access,
        'color': AppConfig.secondaryColor,
      },
      {
        'id': 'markets',
        'name': l10n.categoriesMarkets,
        'icon': Icons.store,
        'color': AppConfig.syrianBlack,
      },
      {
        'id': 'castle',
        'name': l10n.castles,
        'icon': Icons.castle,
        'color': AppConfig.syrianGold,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.discovery),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Advanced filtering
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchPlaceholder,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConfig.radiusL),
                ),
              ),
              onChanged: (value) {
                // TODO: Apply real-time search
                setState(() {});
              },
            ),
          ),
          // Categories
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppConfig.spacingM,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: AppConfig.spacingM),
                  child: GestureDetector(
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
                                ? category['color']
                                : category['color'].withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppConfig.radiusL,
                            ),
                            border: isSelected
                                ? Border.all(color: category['color'], width: 2)
                                : null,
                          ),
                          child: Icon(
                            category['icon'],
                            color: isSelected
                                ? AppConfig.syrianWhite
                                : category['color'],
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['name'],
                          style: AppConfig.caption.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Sites list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConfig.spacingM),
              itemCount: _getSitesForCategory(_selectedCategory).length,
              itemBuilder: (context, index) {
                final site = _getSitesForCategory(_selectedCategory)[index];
                return _SiteCard(site: site);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSitesForCategory(String category) {
    // TODO: Replace with real data from Firebase
    final allSites = [
      {
        'id': '1',
        'name': 'Palmyra',
        'nameAr': 'تدمر',
        'description':
            'Ancient city and UNESCO World Heritage site with stunning ruins',
        'descriptionAr': 'مدينة قديمة وموقع تراث عالمي مع أطلال مذهلة',
        'category': 'archaeological',
        'city': 'Tadmur',
        'cityAr': 'تدمر',
        'rating': 4.8,
        'image': 'https://example.com/palmyra.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '2',
        'name': 'Umayyad Mosque',
        'nameAr': 'الجامع الأموي',
        'description': 'One of the largest and oldest mosques in the world',
        'descriptionAr': 'واحدة من أكبر وأقدم المساجد في العالم',
        'category': 'religious',
        'city': 'Damascus',
        'cityAr': 'دمشق',
        'rating': 4.9,
        'image': 'https://example.com/umayyad.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '3',
        'name': 'Krak des Chevaliers',
        'nameAr': 'قلعة الحصن',
        'description':
            'Medieval Crusader castle, one of the best-preserved castles',
        'descriptionAr':
            'قلعة صليبية من العصور الوسطى، واحدة من أفضل القلاع المحفوظة',
        'category': 'castle',
        'city': 'Homs',
        'cityAr': 'حمص',
        'rating': 4.7,
        'image': 'https://example.com/krak.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '4',
        'name': 'National Museum of Damascus',
        'nameAr': 'المتحف الوطني بدمشق',
        'description': 'Houses important archaeological collections from Syria',
        'descriptionAr': 'يحتوي على مجموعات أثرية مهمة من سوريا',
        'category': 'museums',
        'city': 'Damascus',
        'cityAr': 'دمشق',
        'rating': 4.6,
        'image': 'https://example.com/museum.jpg',
        'entranceFee': 5.0,
      },
      {
        'id': '5',
        'name': 'Tishreen Park',
        'nameAr': 'حديقة تشرين',
        'description': 'Beautiful public park in Damascus',
        'descriptionAr': 'حديقة عامة جميلة في دمشق',
        'category': 'parks',
        'city': 'Damascus',
        'cityAr': 'دمشق',
        'rating': 4.3,
        'image': 'https://example.com/park.jpg',
        'entranceFee': 0.0,
      },
      {
        'id': '6',
        'name': 'Latakia Beach',
        'nameAr': 'شاطئ اللاذقية',
        'description': 'Beautiful Mediterranean beach',
        'descriptionAr': 'شاطئ جميل على البحر المتوسط',
        'category': 'beaches',
        'city': 'Latakia',
        'cityAr': 'اللاذقية',
        'rating': 4.4,
        'image': 'https://example.com/beach.jpg',
        'entranceFee': 0.0,
      },
    ];

    if (category == 'all') return allSites;
    return allSites.where((site) => site['category'] == category).toList();
  }
}

class _SiteCard extends StatelessWidget {
  final Map<String, dynamic> site;

  const _SiteCard({required this.site});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: InkWell(
        onTap: () {
          // TODO: الانتقال إلى صفحة تفاصيل الموقع
          context.go('/category/${site['category']}');
        },
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الموقع
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConfig.radiusL),
                  topRight: Radius.circular(AppConfig.radiusL),
                ),
                color: AppConfig.primaryColor.withOpacity(0.1),
              ),
              child: Stack(
                children: [
                  // TODO: استبدال بصورة حقيقية
                  Center(
                    child: Icon(
                      Icons.photo,
                      size: 64,
                      color: AppConfig.primaryColor,
                    ),
                  ),
                  // تقييم الموقع
                  Positioned(
                    top: AppConfig.spacingM,
                    right: AppConfig.spacingM,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConfig.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppConfig.syrianGold,
                        borderRadius: BorderRadius.circular(AppConfig.radiusS),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            site['rating'].toString(),
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
            // معلومات الموقع
            Padding(
              padding: const EdgeInsets.all(AppConfig.spacingM),
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
                  const SizedBox(height: AppConfig.spacingM),
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
                            horizontal: AppConfig.spacingS,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppConfig.syrianGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppConfig.radiusS,
                            ),
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
                            horizontal: AppConfig.spacingS,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppConfig.syrianGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppConfig.radiusS,
                            ),
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
      ),
    );
  }
}
