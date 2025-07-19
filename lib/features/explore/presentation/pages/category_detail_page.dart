import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/models/tourist_site.dart';

class CategoryDetailPage extends StatelessWidget {
  final String category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getCategoryTitle(category)),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: Column(
        children: [
          _buildCategoryHeader(),
          Expanded(child: _buildSitesList()),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConfig.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getCategoryColor(category).withOpacity(0.1),
            _getCategoryColor(category).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getCategoryIcon(category),
            size: 48,
            color: _getCategoryColor(category),
          ),
          const SizedBox(width: AppConfig.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getCategoryTitle(category),
                  style: AppConfig.heading2.copyWith(
                    color: _getCategoryColor(category),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConfig.spacingS),
                Text(
                  '${_getSitesForCategory(category).length} sites available',
                  style: AppConfig.body1.copyWith(
                    color: _getCategoryColor(category).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSitesList() {
    final sites = _getSitesForCategory(category);

    return ListView.builder(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      itemCount: sites.length,
      itemBuilder: (context, index) {
        return _buildSiteCard(sites[index]);
      },
    );
  }

  Widget _buildSiteCard(TouristSite site) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to site details page
        },
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppConfig.radiusM),
                  topRight: Radius.circular(AppConfig.radiusM),
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppConfig.radiusM),
                      topRight: Radius.circular(AppConfig.radiusM),
                    ),
                    child: site.images.isNotEmpty
                        ? Image.network(
                            site.images.first,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: _getCategoryColor(
                                  category,
                                ).withOpacity(0.1),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                    color: _getCategoryColor(category),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: _getCategoryColor(
                                  category,
                                ).withOpacity(0.1),
                                child: Center(
                                  child: Icon(
                                    Icons.photo,
                                    size: 64,
                                    color: _getCategoryColor(category),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: _getCategoryColor(category).withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                Icons.photo,
                                size: 64,
                                color: _getCategoryColor(category),
                              ),
                            ),
                          ),
                  ),
                  Positioned(
                    top: AppConfig.spacingM,
                    right: AppConfig.spacingM,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConfig.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category),
                        borderRadius: BorderRadius.circular(AppConfig.radiusS),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            site.rating.toString(),
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
            Padding(
              padding: const EdgeInsets.all(AppConfig.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    site.name,
                    style: AppConfig.heading3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConfig.spacingS),
                  Text(
                    site.description,
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
                      Expanded(
                        child: Text(
                          '${site.city}, ${site.region}',
                          style: AppConfig.body2,
                        ),
                      ),
                      if (site.entranceFee > 0)
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
                            '\$${site.entranceFee}',
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
                            'Free',
                            style: AppConfig.body2.copyWith(
                              color: AppConfig.syrianGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppConfig.spacingS),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppConfig.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(site.visitingHours, style: AppConfig.caption),
                      const Spacer(),
                      Text(
                        '${site.reviewCount} reviews',
                        style: AppConfig.caption,
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

  String _getCategoryTitle(String category) {
    switch (category.toLowerCase()) {
      case 'archaeological':
        return 'Archaeological Sites';
      case 'museums':
        return 'Museums';
      case 'religious':
        return 'Mosques & Churches';
      case 'parks':
        return 'Parks & Gardens';
      case 'beaches':
        return 'Beaches';
      case 'markets':
        return 'Markets & Souqs';
      case 'castle':
        return 'Castles & Forts';
      default:
        return category;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'archaeological':
        return Icons.architecture;
      case 'museums':
        return Icons.museum;
      case 'religious':
        return Icons.church;
      case 'parks':
        return Icons.park;
      case 'beaches':
        return Icons.beach_access;
      case 'markets':
        return Icons.store;
      case 'castle':
        return Icons.castle;
      default:
        return Icons.place;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'archaeological':
        return AppConfig.syrianGold;
      case 'museums':
        return AppConfig.syrianRed;
      case 'religious':
        return AppConfig.syrianGreen;
      case 'parks':
        return AppConfig.primaryColor;
      case 'beaches':
        return AppConfig.secondaryColor;
      case 'markets':
        return AppConfig.accentColor;
      case 'castle':
        return AppConfig.accentColor;
      default:
        return AppConfig.primaryColor;
    }
  }

  List<TouristSite> _getSitesForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'archaeological':
        return [
          TouristSite(
            id: '1',
            name: 'Palmyra',
            nameAr: 'تدمر',
            description:
                'Ancient city and UNESCO World Heritage site with impressive ruins',
            descriptionAr: 'مدينة قديمة وموقع تراث عالمي مع أطلال مذهلة',
            category: 'Archaeological',
            city: 'Tadmur',
            region: 'Homs Governorate',
            latitude: 34.5560,
            longitude: 38.2739,
            address: 'Tadmur, Homs Governorate, Syria',
            addressAr: 'تدمر، محافظة حمص، سوريا',
            images: [
              'https://cdn.britannica.com/51/180451-050-F25987E6/Ruins-Grand-Colonnade-Palmyra-Syria.jpg',
              'https://cdn.britannica.com/51/180451-050-F25987E6/Ruins-Grand-Colonnade-Palmyra-Syria.jpg',
            ],
            rating: 4.8,
            reviewCount: 1250,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '8:00 AM - 6:00 PM',
            contactPhone: '+963-31-123456',
            contactEmail: 'info@palmyra.gov.sy',
            website: 'www.palmyra.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '4',
            name: 'Apamea',
            nameAr: 'أفاميا',
            description:
                'Ancient Hellenistic city with impressive colonnaded street',
            descriptionAr: 'مدينة هلنستية قديمة مع شارع أعمدة مذهل',
            category: 'Archaeological',
            city: 'Hama',
            region: 'Hama Governorate',
            latitude: 35.4200,
            longitude: 36.3900,
            address: 'Hama Governorate, Syria',
            addressAr: 'محافظة حماة، سوريا',
            images: [
              'https://img1.advisor.travel/1200x630px-Apamea_Syria_1.jpg',
              'https://img1.advisor.travel/1200x630px-Apamea_Syria_1.jpg',
            ],
            rating: 4.6,
            reviewCount: 850,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '9:00 AM - 5:00 PM',
            contactPhone: '+963-33-123456',
            contactEmail: 'info@apamea.gov.sy',
            website: 'www.apamea.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '5',
            name: 'Dura-Europos',
            nameAr: 'دورا أوروبوس',
            description: 'Ancient city with well-preserved wall paintings',
            descriptionAr: 'مدينة قديمة مع لوحات جدارية محفوظة جيداً',
            category: 'Archaeological',
            city: 'Deir ez-Zor',
            region: 'Deir ez-Zor Governorate',
            latitude: 34.7500,
            longitude: 40.7300,
            address: 'Deir ez-Zor Governorate, Syria',
            addressAr: 'محافظة دير الزور، سوريا',
            images: [
              'https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2024/09/931/523/dura-europos-syria.jpg?ve=1&amp;tl=1',
              'https://a57.foxnews.com/static.foxnews.com/foxnews.com/content/uploads/2024/09/931/523/dura-europos-syria.jpg?ve=1&amp;tl=1',
            ],
            rating: 4.5,
            reviewCount: 620,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '8:00 AM - 4:00 PM',
            contactPhone: '+963-51-123456',
            contactEmail: 'info@dura.gov.sy',
            website: 'www.dura.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'religious':
        return [
          TouristSite(
            id: '2',
            name: 'Umayyad Mosque',
            nameAr: 'الجامع الأموي',
            description: 'One of the largest and oldest mosques in the world',
            descriptionAr: 'واحدة من أكبر وأقدم المساجد في العالم',
            category: 'Religious',
            city: 'Damascus',
            region: 'Damascus Governorate',
            latitude: 33.5117,
            longitude: 36.3064,
            address: 'Damascus, Syria',
            addressAr: 'دمشق، سوريا',
            images: [
              'https://www.islamiclandmarks.com/wp-content/uploads/2015/11/Umayyad-Mosque-exterior.jpg',
              'https://www.islamiclandmarks.com/wp-content/uploads/2015/11/Umayyad-Mosque-exterior.jpg',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.9,
            reviewCount: 2100,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '24/7',
            contactPhone: '+963-11-123456',
            contactEmail: 'info@umayyad.gov.sy',
            website: 'www.umayyad.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '6',
            name: 'Sayyidah Zaynab Mosque',
            nameAr: 'مسجد السيدة زينب',
            description: 'Important Shia shrine and pilgrimage site',
            descriptionAr: 'ضريح شيعي مهم وموقع حج',
            category: 'Religious',
            city: 'Damascus',
            region: 'Damascus Governorate',
            latitude: 33.4500,
            longitude: 36.3500,
            address: 'Damascus, Syria',
            addressAr: 'دمشق، سوريا',
            images: [
              'https://lh3.googleusercontent.com/gps-cs-s/AC9h4nr-gv0KdDp4u8hAl2eU_DvqRlD-RMeevt29DK7DvrkqTfCM5wo_ttPTo2mQAnHnJtm_j6CYO6HnWfewmSwsb9Cl1_aDzOiBqqqqh5q1jktQdAyPMLIVUaHK8NGEMiPTUgAia4gFJQ=s1360-w1360-h1020-rw',
              'https://lh3.googleusercontent.com/gps-cs-s/AC9h4nr-gv0KdDp4u8hAl2eU_DvqRlD-RMeevt29DK7DvrkqTfCM5wo_ttPTo2mQAnHnJtm_j6CYO6HnWfewmSwsb9Cl1_aDzOiBqqqqh5q1jktQdAyPMLIVUaHK8NGEMiPTUgAia4gFJQ=s1360-w1360-h1020-rw',
            ],
            rating: 4.7,
            reviewCount: 1800,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '24/7',
            contactPhone: '+963-11-654321',
            contactEmail: 'info@zaynab.gov.sy',
            website: 'www.zaynab.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '7',
            name: 'Great Mosque of Aleppo',
            nameAr: 'الجامع الكبير بحلب',
            description: 'Historic mosque in the heart of Aleppo',
            descriptionAr: 'مسجد تاريخي في قلب حلب',
            category: 'Religious',
            city: 'Aleppo',
            region: 'Aleppo Governorate',
            latitude: 36.1997,
            longitude: 37.1597,
            address: 'Aleppo, Syria',
            addressAr: 'حلب، سوريا',
            images: [
              'https://ia.tmgrup.com.tr/bc87fe/0/0/0/0/800/501?u=http://i.tmgrup.com.tr/dailysabah/2016/12/16/great-mosque-of-aleppo-bears-the-marks-of-the-ongoing-destruction-1481892872468.jpg',
              'https://ia.tmgrup.com.tr/bc87fe/0/0/0/0/800/501?u=http://i.tmgrup.com.tr/dailysabah/2016/12/16/great-mosque-of-aleppo-bears-the-marks-of-the-ongoing-destruction-1481892872468.jpg',
            ],
            rating: 4.6,
            reviewCount: 950,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '24/7',
            contactPhone: '+963-21-123456',
            contactEmail: 'info@aleppomosque.gov.sy',
            website: 'www.aleppomosque.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'museums':
        return [
          TouristSite(
            id: '9',
            name: 'National Museum of Damascus',
            nameAr: 'المتحف الوطني بدمشق',
            description:
                'Largest museum in Syria with extensive archaeological collections',
            descriptionAr: 'أكبر متحف في سوريا مع مجموعات أثرية واسعة',
            category: 'Museums',
            city: 'Damascus',
            region: 'Damascus Governorate',
            latitude: 33.5117,
            longitude: 36.3064,
            address: 'Damascus, Syria',
            addressAr: 'دمشق، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.6,
            reviewCount: 850,
            entranceFee: 5.0,
            currency: 'USD',
            visitingHours: '9:00 AM - 5:00 PM',
            contactPhone: '+963-11-123456',
            contactEmail: 'info@museum.gov.sy',
            website: 'www.museum.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '10',
            name: 'Aleppo Museum',
            nameAr: 'متحف حلب',
            description: 'Museum showcasing the rich history of Aleppo region',
            descriptionAr: 'متحف يعرض التاريخ الغني لمنطقة حلب',
            category: 'Museums',
            city: 'Aleppo',
            region: 'Aleppo Governorate',
            latitude: 36.1997,
            longitude: 37.1597,
            address: 'Aleppo, Syria',
            addressAr: 'حلب، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.4,
            reviewCount: 620,
            entranceFee: 3.0,
            currency: 'USD',
            visitingHours: '9:00 AM - 4:00 PM',
            contactPhone: '+963-21-654321',
            contactEmail: 'info@aleppomuseum.gov.sy',
            website: 'www.aleppomuseum.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'parks':
        return [
          TouristSite(
            id: '11',
            name: 'Tishreen Park',
            nameAr: 'حديقة تشرين',
            description:
                'Beautiful public park in Damascus with walking paths and gardens',
            descriptionAr: 'حديقة عامة جميلة في دمشق مع مسارات للمشي وحدائق',
            category: 'Parks',
            city: 'Damascus',
            region: 'Damascus Governorate',
            latitude: 33.5117,
            longitude: 36.3064,
            address: 'Damascus, Syria',
            addressAr: 'دمشق، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.3,
            reviewCount: 450,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '6:00 AM - 10:00 PM',
            contactPhone: '+963-11-789012',
            contactEmail: 'info@tishreen.gov.sy',
            website: 'www.tishreen.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'beaches':
        return [
          TouristSite(
            id: '12',
            name: 'Latakia Beach',
            nameAr: 'شاطئ اللاذقية',
            description:
                'Beautiful Mediterranean beach with crystal clear waters',
            descriptionAr: 'شاطئ متوسطي جميل مع مياه صافية',
            category: 'Beaches',
            city: 'Latakia',
            region: 'Latakia Governorate',
            latitude: 35.5200,
            longitude: 35.7800,
            address: 'Latakia, Syria',
            addressAr: 'اللاذقية، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.5,
            reviewCount: 780,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '24/7',
            contactPhone: '+963-41-123456',
            contactEmail: 'info@latakiabeach.gov.sy',
            website: 'www.latakiabeach.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'markets':
        return [
          TouristSite(
            id: '13',
            name: 'Souq Al-Hamidiyah',
            nameAr: 'سوق الحميدية',
            description:
                'Historic covered market in Damascus, one of the largest in the Middle East',
            descriptionAr:
                'سوق تاريخي مسقوف في دمشق، واحد من أكبر الأسواق في الشرق الأوسط',
            category: 'Markets',
            city: 'Damascus',
            region: 'Damascus Governorate',
            latitude: 33.5117,
            longitude: 36.3064,
            address: 'Damascus, Syria',
            addressAr: 'دمشق، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.7,
            reviewCount: 1200,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '8:00 AM - 8:00 PM',
            contactPhone: '+963-11-345678',
            contactEmail: 'info@souq.gov.sy',
            website: 'www.souq.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      case 'castle':
        return [
          TouristSite(
            id: '3',
            name: 'Krak des Chevaliers',
            nameAr: 'قلعة الحصن',
            description: 'Medieval Crusader castle, one of the best preserved',
            descriptionAr:
                'قلعة صليبية من العصور الوسطى، واحدة من أفضل القلاع المحفوظة',
            category: 'Castle',
            city: 'Homs',
            region: 'Homs Governorate',
            latitude: 34.7553,
            longitude: 36.2944,
            address: 'Homs Governorate, Syria',
            addressAr: 'محافظة حمص، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.7,
            reviewCount: 980,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '9:00 AM - 5:00 PM',
            contactPhone: '+963-31-654321',
            contactEmail: 'info@krak.gov.sy',
            website: 'www.krak.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          TouristSite(
            id: '8',
            name: 'Citadel of Aleppo',
            nameAr: 'قلعة حلب',
            description: 'Ancient fortress in the center of Aleppo',
            descriptionAr: 'قلعة قديمة في وسط حلب',
            category: 'Castle',
            city: 'Aleppo',
            region: 'Aleppo Governorate',
            latitude: 36.1997,
            longitude: 37.1597,
            address: 'Aleppo, Syria',
            addressAr: 'حلب، سوريا',
            images: [
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
              'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&h=600&fit=crop&auto=format&q=80',
            ],
            rating: 4.5,
            reviewCount: 1200,
            entranceFee: 0.0,
            currency: 'USD',
            visitingHours: '8:00 AM - 6:00 PM',
            contactPhone: '+963-21-654321',
            contactEmail: 'info@citadel.gov.sy',
            website: 'www.citadel.gov.sy',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ];

      default:
        return [];
    }
  }
}
