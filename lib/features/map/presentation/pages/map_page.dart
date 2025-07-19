import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/config/app_config.dart';

/// Interactive map screen for Syria
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  // موقع سوريا الافتراضي
  static const CameraPosition _syriaCenter = CameraPosition(
    target: LatLng(34.8021, 38.9968), // وسط سوريا
    zoom: 6.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadTouristSites();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // TODO: طلب إذن الموقع
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // TODO: إظهار رسالة تفعيل خدمة الموقع
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // TODO: إظهار رسالة رفض الإذن
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // TODO: إظهار رسالة الإذن مرفوض نهائياً
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });

      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 12.0,
          ),
        ),
      );
    } catch (e) {
      // TODO: معالجة الأخطاء
      print('خطأ في الحصول على الموقع: $e');
    }
  }

  void _loadTouristSites() {
    // TODO: استبدال ببيانات حقيقية من Firebase
    final sites = [
      {
        'id': '1',
        'name': 'تدمر',
        'nameEn': 'Palmyra',
        'position': const LatLng(34.5560, 38.2739),
        'category': 'archaeological',
        'rating': 4.8,
        'description': 'مدينة قديمة وموقع تراث عالمي',
      },
      {
        'id': '2',
        'name': 'الجامع الأموي',
        'nameEn': 'Umayyad Mosque',
        'position': const LatLng(33.5117, 36.3064),
        'category': 'religious',
        'rating': 4.9,
        'description': 'واحدة من أكبر وأقدم المساجد في العالم',
      },
      {
        'id': '3',
        'name': 'قلعة الحصن',
        'nameEn': 'Krak des Chevaliers',
        'position': const LatLng(34.7553, 36.2944),
        'category': 'castle',
        'rating': 4.7,
        'description': 'قلعة صليبية من العصور الوسطى',
      },
      {
        'id': '4',
        'name': 'أفاميا',
        'nameEn': 'Apamea',
        'position': const LatLng(35.4200, 36.3900),
        'category': 'archaeological',
        'rating': 4.6,
        'description': 'مدينة هلنستية قديمة',
      },
      {
        'id': '5',
        'name': 'دورا أوروبوس',
        'nameEn': 'Dura-Europos',
        'position': const LatLng(34.7500, 40.7300),
        'category': 'archaeological',
        'rating': 4.5,
        'description': 'مدينة قديمة مع لوحات جدارية',
      },
    ];

    _markers = sites.map((site) {
      return Marker(
        markerId: MarkerId(site['id'] as String),
        position: site['position'] as LatLng,
        infoWindow: InfoWindow(
          title: site['name'] as String,
          snippet: site['description'] as String,
          onTap: () {
            _showSiteDetails(site);
          },
        ),
        icon: _getMarkerIcon(site['category'] as String),
        onTap: () {
          _showSiteDetails(site);
        },
      );
    }).toSet();

    setState(() {
      _isLoading = false;
    });
  }

  BitmapDescriptor _getMarkerIcon(String category) {
    // TODO: استبدال بأيقونات مخصصة لكل فئة
    switch (category) {
      case 'archaeological':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      case 'religious':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 'castle':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'museums':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'parks':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueYellow,
        );
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  void _showSiteDetails(Map<String, dynamic> site) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SiteDetailsSheet(site: site),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خريطة سوريا'),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              // TODO: إظهار طبقات الخريطة (فنادق، مطاعم، نقل)
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            initialCameraPosition: _syriaCenter,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onTap: (LatLng position) {
              // إغلاق Bottom Sheet عند النقر على الخريطة
            },
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
          // زر العودة للموقع الحالي
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: AppConfig.primaryColor,
              child: const Icon(Icons.my_location, color: Colors.white),
              onPressed: _getCurrentLocation,
            ),
          ),
        ],
      ),
    );
  }
}

class _SiteDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> site;

  const _SiteDetailsSheet({required this.site});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConfig.radiusXL),
          topRight: Radius.circular(AppConfig.radiusXL),
        ),
      ),
      child: Column(
        children: [
          // مقبض السحب
          Container(
            margin: const EdgeInsets.only(top: AppConfig.spacingM),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // صورة الموقع
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(AppConfig.spacingM),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConfig.radiusL),
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
                  style: AppConfig.heading2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  site['nameEn'],
                  style: AppConfig.body1.copyWith(
                    color: AppConfig.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(site['description'], style: AppConfig.body1),
                const SizedBox(height: AppConfig.spacingL),
                // أزرار الإجراءات
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.directions),
                        label: const Text('الاتجاهات'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.primaryColor,
                          foregroundColor: AppConfig.syrianWhite,
                        ),
                        onPressed: () {
                          // TODO: فتح تطبيق الخرائط مع الاتجاهات
                        },
                      ),
                    ),
                    const SizedBox(width: AppConfig.spacingM),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.info),
                        label: const Text('التفاصيل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.accentColor,
                          foregroundColor: AppConfig.syrianWhite,
                        ),
                        onPressed: () {
                          // TODO: الانتقال إلى صفحة تفاصيل الموقع
                        },
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
}
