import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/config/app_config.dart';

/// Trip planner page
class TripPlannerPage extends StatefulWidget {
  const TripPlannerPage({super.key});

  @override
  State<TripPlannerPage> createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  int _selectedDays = 3;
  List<String> _selectedCities = [];
  List<String> _selectedCategories = [];
  bool _showMap = false;

  final List<String> _availableCities = [
    'دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'تدمر',
    'دير الزور',
    'الرقة',
    'الحسكة',
  ];

  final List<Map<String, dynamic>> _availableCategories = [
    {'id': 'archaeological', 'name': 'مواقع أثرية', 'icon': Icons.architecture},
    {'id': 'religious', 'name': 'مواقع دينية', 'icon': Icons.church},
    {'id': 'museums', 'name': 'متاحف', 'icon': Icons.museum},
    {'id': 'parks', 'name': 'حدائق', 'icon': Icons.park},
    {'id': 'beaches', 'name': 'شواطئ', 'icon': Icons.beach_access},
    {'id': 'markets', 'name': 'أسواق', 'icon': Icons.store},
    {'id': 'castle', 'name': 'قلاع', 'icon': Icons.castle},
    {'id': 'restaurants', 'name': 'مطاعم', 'icon': Icons.restaurant},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تخطيط الرحلة'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: Icon(_showMap ? Icons.list : Icons.map),
            onPressed: () {
              setState(() {
                _showMap = !_showMap;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // إعدادات الرحلة
          Container(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            decoration: BoxDecoration(
              color: AppConfig.backgroundColor,
              boxShadow: AppConfig.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إعدادات الرحلة',
                  style: AppConfig.heading3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConfig.spacingM),
                // عدد الأيام
                Text('عدد الأيام: $_selectedDays', style: AppConfig.body1),
                Slider(
                  value: _selectedDays.toDouble(),
                  min: 1,
                  max: 14,
                  divisions: 13,
                  activeColor: AppConfig.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      _selectedDays = value.round();
                    });
                  },
                ),
                const SizedBox(height: AppConfig.spacingM),
                // اختيار المدن
                Text(
                  'اختر المدن:',
                  style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppConfig.spacingS),
                Wrap(
                  spacing: AppConfig.spacingS,
                  runSpacing: AppConfig.spacingS,
                  children: _availableCities.map((city) {
                    final isSelected = _selectedCities.contains(city);
                    return FilterChip(
                      label: Text(city),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCities.add(city);
                          } else {
                            _selectedCities.remove(city);
                          }
                        });
                      },
                      backgroundColor: AppConfig.backgroundColor,
                      selectedColor: AppConfig.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppConfig.syrianWhite
                            : AppConfig.textPrimaryColor,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppConfig.spacingM),
                // اختيار نوع الأماكن
                Text(
                  'نوع الأماكن:',
                  style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppConfig.spacingS),
                Wrap(
                  spacing: AppConfig.spacingS,
                  runSpacing: AppConfig.spacingS,
                  children: _availableCategories.map((category) {
                    final isSelected = _selectedCategories.contains(
                      category['id'],
                    );
                    return FilterChip(
                      avatar: Icon(
                        category['icon'],
                        size: 16,
                        color: isSelected
                            ? AppConfig.syrianWhite
                            : AppConfig.primaryColor,
                      ),
                      label: Text(category['name']),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedCategories.add(category['id']);
                          } else {
                            _selectedCategories.remove(category['id']);
                          }
                        });
                      },
                      backgroundColor: AppConfig.backgroundColor,
                      selectedColor: AppConfig.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppConfig.syrianWhite
                            : AppConfig.textPrimaryColor,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppConfig.spacingM),
                // زر إنشاء الخطة
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedCities.isNotEmpty
                        ? _generateTripPlan
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConfig.secondaryColor,
                      foregroundColor: AppConfig.syrianWhite,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConfig.spacingM,
                      ),
                    ),
                    child: const Text('إنشاء خطة الرحلة'),
                  ),
                ),
              ],
            ),
          ),
          // عرض الخطة
          Expanded(child: _showMap ? _buildTripMap() : _buildTripList()),
        ],
      ),
    );
  }

  void _generateTripPlan() {
    // TODO: إنشاء خطة رحلة ذكية بناءً على المدن والأيام المختارة
    setState(() {
      // تحديث الخطة
    });
  }

  Widget _buildTripList() {
    if (_selectedCities.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.route, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('اختر المدن لإنشاء خطة رحلة'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConfig.spacingM),
      itemCount: _selectedDays,
      itemBuilder: (context, dayIndex) {
        return _DayPlanCard(
          dayNumber: dayIndex + 1,
          cities: _selectedCities,
          categories: _selectedCategories,
        );
      },
    );
  }

  Widget _buildTripMap() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(34.8021, 38.9968), // وسط سوريا
        zoom: 6.0,
      ),
      markers: _getTripMarkers(),
      polylines: _getTripRoute(),
    );
  }

  Set<Marker> _getTripMarkers() {
    // TODO: إنشاء علامات للمدن المختارة
    return {};
  }

  Set<Polyline> _getTripRoute() {
    // TODO: إنشاء مسار الرحلة
    return {};
  }
}

class _DayPlanCard extends StatelessWidget {
  final int dayNumber;
  final List<String> cities;
  final List<String> categories;

  const _DayPlanCard({
    required this.dayNumber,
    required this.cities,
    required this.categories,
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
          // رأس اليوم
          Container(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            decoration: BoxDecoration(
              color: AppConfig.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConfig.radiusL),
                topRight: Radius.circular(AppConfig.radiusL),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: AppConfig.syrianWhite),
                const SizedBox(width: AppConfig.spacingS),
                Text(
                  'اليوم $dayNumber',
                  style: AppConfig.heading3.copyWith(
                    color: AppConfig.syrianWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  _getDayCity(),
                  style: AppConfig.body1.copyWith(color: AppConfig.syrianWhite),
                ),
              ],
            ),
          ),
          // جدول اليوم
          Padding(
            padding: const EdgeInsets.all(AppConfig.spacingM),
            child: Column(
              children: [
                _TimeSlotCard(
                  time: '09:00 - 11:00',
                  activity: 'زيارة ${_getRandomSite()}',
                  description: 'استكشاف الموقع التاريخي',
                  icon: Icons.architecture,
                ),
                _TimeSlotCard(
                  time: '11:30 - 13:00',
                  activity: 'غداء في مطعم محلي',
                  description: 'تذوق المأكولات السورية التقليدية',
                  icon: Icons.restaurant,
                ),
                _TimeSlotCard(
                  time: '13:30 - 15:30',
                  activity: 'زيارة ${_getRandomSite()}',
                  description: 'اكتشاف المزيد من المعالم',
                  icon: Icons.museum,
                ),
                _TimeSlotCard(
                  time: '16:00 - 18:00',
                  activity: 'تسوق في السوق التقليدي',
                  description: 'شراء الهدايا التذكارية',
                  icon: Icons.shopping_bag,
                ),
                _TimeSlotCard(
                  time: '18:30 - 20:00',
                  activity: 'عشاء في فندق',
                  description: 'وجبة عشاء فاخرة',
                  icon: Icons.hotel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDayCity() {
    if (cities.isEmpty) return '';
    return cities[dayNumber % cities.length];
  }

  String _getRandomSite() {
    final sites = [
      'الجامع الأموي',
      'قلعة الحصن',
      'تدمر',
      'أفاميا',
      'دورا أوروبوس',
    ];
    return sites[dayNumber % sites.length];
  }
}

class _TimeSlotCard extends StatelessWidget {
  final String time;
  final String activity;
  final String description;
  final IconData icon;

  const _TimeSlotCard({
    required this.time,
    required this.activity,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConfig.spacingS),
      padding: const EdgeInsets.all(AppConfig.spacingM),
      decoration: BoxDecoration(
        color: AppConfig.backgroundColor,
        borderRadius: BorderRadius.circular(AppConfig.radiusM),
        border: Border.all(color: AppConfig.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // الوقت
          Container(
            padding: const EdgeInsets.all(AppConfig.spacingS),
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConfig.radiusS),
            ),
            child: Text(
              time,
              style: AppConfig.caption.copyWith(
                color: AppConfig.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppConfig.spacingM),
          // أيقونة النشاط
          Icon(icon, color: AppConfig.primaryColor, size: 24),
          const SizedBox(width: AppConfig.spacingM),
          // تفاصيل النشاط
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: AppConfig.body1.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: AppConfig.body2.copyWith(
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          // زر التفاصيل
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: عرض تفاصيل النشاط
            },
          ),
        ],
      ),
    );
  }
}
