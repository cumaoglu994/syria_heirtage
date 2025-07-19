import 'package:flutter/material.dart';
import '../../../../core/config/app_config.dart';

/// Packages and offers page
class PackagesPage extends StatefulWidget {
  const PackagesPage({super.key});

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  final List<String> _filters = [
    'الكل',
    'رحلات جماعية',
    'رحلات فردية',
    'فنادق',
    'سيارات',
    'مرشدين',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الباقات والعروض'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppConfig.syrianWhite,
          tabs: const [
            Tab(text: 'رحلات'),
            Tab(text: 'فنادق'),
            Tab(text: 'خدمات'),
          ],
        ),
      ),
      body: Column(
        children: [
          // فلترة العروض
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: AppConfig.spacingM),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: AppConfig.spacingS),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: AppConfig.backgroundColor,
                    selectedColor: AppConfig.primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppConfig.syrianWhite
                          : AppConfig.textPrimaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          // محتوى التبويبات
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTripsTab(),
                _buildHotelsTab(),
                _buildServicesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsTab() {
    return ListView(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      children: [
        _TripPackageCard(
          title: 'رحلة دمشق - تدمر',
          subtitle: '3 أيام، 2 ليالي',
          description: 'اكتشف عاصمة سوريا ومدينة تدمر الأثرية',
          price: 299.0,
          originalPrice: 399.0,
          rating: 4.8,
          image: 'https://example.com/damascus-palmyra.jpg',
          features: ['نقل مريح', 'إقامة فاخرة', 'مرشد محترف', 'وجبات'],
        ),
        _TripPackageCard(
          title: 'رحلة حلب التاريخية',
          subtitle: '2 أيام، 1 ليلة',
          description: 'استكشف مدينة حلب القديمة وقلعتها الشهيرة',
          price: 199.0,
          originalPrice: 249.0,
          rating: 4.6,
          image: 'https://example.com/aleppo.jpg',
          features: ['نقل مريح', 'إقامة', 'مرشد محترف'],
        ),
        _TripPackageCard(
          title: 'رحلة الساحل السوري',
          subtitle: '4 أيام، 3 ليالي',
          description: 'استمتع بشواطئ اللاذقية وطرطوس',
          price: 399.0,
          originalPrice: 499.0,
          rating: 4.7,
          image: 'https://example.com/coast.jpg',
          features: [
            'نقل مريح',
            'إقامة فاخرة',
            'مرشد محترف',
            'وجبات',
            'أنشطة بحرية',
          ],
        ),
      ],
    );
  }

  Widget _buildHotelsTab() {
    return ListView(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      children: [
        _HotelCard(
          name: 'فندق الشام الكبير',
          location: 'دمشق، سوريا',
          rating: 4.8,
          price: 150.0,
          image: 'https://example.com/hotel1.jpg',
          amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'موقف سيارات'],
        ),
        _HotelCard(
          name: 'فندق حلب التاريخي',
          location: 'حلب، سوريا',
          rating: 4.6,
          price: 120.0,
          image: 'https://example.com/hotel2.jpg',
          amenities: ['واي فاي مجاني', 'مطعم', 'حديقة'],
        ),
        _HotelCard(
          name: 'فندق اللاذقية البحري',
          location: 'اللاذقية، سوريا',
          rating: 4.7,
          price: 180.0,
          image: 'https://example.com/hotel3.jpg',
          amenities: ['واي فاي مجاني', 'مطعم', 'صالة رياضية', 'شاطئ خاص'],
        ),
      ],
    );
  }

  Widget _buildServicesTab() {
    return ListView(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      children: [
        _ServiceCard(
          title: 'سيارة مع سائق',
          description: 'سيارة مريحة مع سائق محترف',
          price: 80.0,
          icon: Icons.directions_car,
          features: ['سائق محترف', 'سيارة مريحة', 'تأمين شامل'],
        ),
        _ServiceCard(
          title: 'مرشد سياحي',
          description: 'مرشد محترف يتحدث العربية والإنجليزية',
          price: 50.0,
          icon: Icons.person,
          features: ['مرشد محترف', 'معرفة عميقة', 'لغات متعددة'],
        ),
        _ServiceCard(
          title: 'تأمين سفر',
          description: 'تأمين شامل لرحلة آمنة',
          price: 25.0,
          icon: Icons.security,
          features: ['تأمين طبي', 'تأمين أمتعة', 'تأمين إلغاء'],
        ),
      ],
    );
  }
}

class _TripPackageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final String image;
  final List<String> features;

  const _TripPackageCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.image,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الرحلة
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
                // تقييم الرحلة
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
                          rating.toString(),
                          style: AppConfig.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // خصم
                Positioned(
                  top: AppConfig.spacingM,
                  left: AppConfig.spacingM,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConfig.spacingS,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppConfig.syrianRed,
                      borderRadius: BorderRadius.circular(AppConfig.radiusS),
                    ),
                    child: Text(
                      'خصم ${((originalPrice - price) / originalPrice * 100).round()}%',
                      style: AppConfig.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // معلومات الرحلة
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppConfig.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppConfig.body2.copyWith(
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: AppConfig.body1),
                const SizedBox(height: AppConfig.spacingM),
                // المميزات
                Wrap(
                  spacing: AppConfig.spacingS,
                  runSpacing: AppConfig.spacingS,
                  children: features
                      .map(
                        (feature) => Chip(
                          label: Text(feature),
                          backgroundColor: AppConfig.primaryColor.withOpacity(
                            0.1,
                          ),
                          labelStyle: AppConfig.caption.copyWith(
                            color: AppConfig.primaryColor,
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppConfig.spacingM),
                // السعر والحجز
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${price.toStringAsFixed(0)}',
                          style: AppConfig.heading2.copyWith(
                            color: AppConfig.syrianGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${originalPrice.toStringAsFixed(0)}',
                          style: AppConfig.body2.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: AppConfig.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: الانتقال إلى صفحة الحجز
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.secondaryColor,
                        foregroundColor: AppConfig.syrianWhite,
                      ),
                      child: const Text('احجز الآن'),
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
}

class _HotelCard extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final double price;
  final String image;
  final List<String> amenities;

  const _HotelCard({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.image,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: Row(
        children: [
          // صورة الفندق
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConfig.radiusL),
                bottomLeft: Radius.circular(AppConfig.radiusL),
              ),
              color: AppConfig.primaryColor.withOpacity(0.1),
            ),
            child: const Icon(
              Icons.hotel,
              size: 48,
              color: AppConfig.primaryColor,
            ),
          ),
          // معلومات الفندق
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConfig.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppConfig.heading3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: AppConfig.body2.copyWith(
                      color: AppConfig.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: AppConfig.syrianGold),
                      const SizedBox(width: 4),
                      Text(rating.toString(), style: AppConfig.body2),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${price.toStringAsFixed(0)} / ليلة',
                    style: AppConfig.body1.copyWith(
                      color: AppConfig.syrianGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: الانتقال إلى صفحة حجز الفندق
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConfig.primaryColor,
                      foregroundColor: AppConfig.syrianWhite,
                    ),
                    child: const Text('احجز'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final IconData icon;
  final List<String> features;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingM),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConfig.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConfig.spacingM),
        child: Row(
          children: [
            // أيقونة الخدمة
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppConfig.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.radiusL),
              ),
              child: Icon(icon, color: AppConfig.primaryColor, size: 32),
            ),
            const SizedBox(width: AppConfig.spacingM),
            // معلومات الخدمة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppConfig.heading3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: AppConfig.body1),
                  const SizedBox(height: 8),
                  Text(
                    '\$${price.toStringAsFixed(0)}',
                    style: AppConfig.body1.copyWith(
                      color: AppConfig.syrianGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // زر الحجز
            ElevatedButton(
              onPressed: () {
                // TODO: الانتقال إلى صفحة حجز الخدمة
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConfig.accentColor,
                foregroundColor: AppConfig.syrianWhite,
              ),
              child: const Text('احجز'),
            ),
          ],
        ),
      ),
    );
  }
}
