import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/services/location_service.dart';
import 'package:go_router/go_router.dart';

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
  bool _locationPermissionGranted = false;
  bool _locationServiceEnabled = false;

  // Default Syria center position
  static const CameraPosition _syriaCenter = CameraPosition(
    target: LatLng(34.8021, 38.9968), // Center of Syria
    zoom: 6.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      await _checkLocationServices();
      _loadTouristSites();
    } catch (e) {
      _showErrorDialog('Map initialization error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkLocationServices() async {
    try {
      bool hasPermission =
          await LocationService.checkLocationPermission(context);
      setState(() {
        _locationPermissionGranted = hasPermission;
        _locationServiceEnabled = hasPermission;
      });

      if (hasPermission) {
        await _getCurrentLocation();
      }
    } catch (e) {
      _showErrorDialog('Location service error: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Position? position = await LocationService.getCurrentLocation(context);

      if (position != null) {
        setState(() {
          _currentPosition = position;
          _locationPermissionGranted = true;
        });

        // Animate camera to current location
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 12.0,
            ),
          ),
        );

        LocationService.showSuccessSnackBar(
            context, 'Location updated successfully!');
      }
    } catch (e) {
      _showErrorDialog('Could not get current location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: AppConfig.errorColor),
              const SizedBox(width: 8),
              const Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _loadTouristSites() {
    // Sample tourist sites data
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
  }

  BitmapDescriptor _getMarkerIcon(String category) {
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.map),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _locationPermissionGranted
                ? _getCurrentLocation
                : _checkLocationServices,
            tooltip: 'Get Current Location',
          ),
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: () {
              _showLayersDialog();
            },
            tooltip: 'Map Layers',
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
            myLocationEnabled: _locationPermissionGranted,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onTap: (LatLng position) {
              // Close any open bottom sheets when tapping on map
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          // Current location button
          if (_locationPermissionGranted)
            Positioned(
              bottom: 100,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: AppConfig.primaryColor,
                child: const Icon(Icons.my_location, color: Colors.white),
                onPressed: _getCurrentLocation,
              ),
            ),
          // Location permission status indicator
          if (!_locationPermissionGranted)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConfig.warningColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_off, color: AppConfig.syrianWhite),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Location access required for full map features',
                        style: AppConfig.body2.copyWith(
                          color: AppConfig.syrianWhite,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _checkLocationServices,
                      child: Text(
                        'Enable',
                        style: AppConfig.body2.copyWith(
                          color: AppConfig.syrianWhite,
                          fontWeight: FontWeight.bold,
                        ),
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

  void _showLayersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Map Layers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Tourist Sites'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Toggle tourist sites layer
                },
              ),
              ListTile(
                leading: const Icon(Icons.hotel),
                title: const Text('Hotels'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Toggle hotels layer
                },
              ),
              ListTile(
                leading: const Icon(Icons.restaurant),
                title: const Text('Restaurants'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Toggle restaurants layer
                },
              ),
              ListTile(
                leading: const Icon(Icons.directions_bus),
                title: const Text('Transportation'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: Toggle transportation layer
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
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
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: AppConfig.spacingM),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Site image
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
                // TODO: Replace with real image
                Center(
                  child: Icon(
                    Icons.photo,
                    size: 64,
                    color: AppConfig.primaryColor,
                  ),
                ),
                // Site rating
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
          // Site information
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
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.directions),
                        label: const Text('Directions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.primaryColor,
                          foregroundColor: AppConfig.syrianWhite,
                        ),
                        onPressed: () {
                          // TODO: Open maps app with directions
                        },
                      ),
                    ),
                    const SizedBox(width: AppConfig.spacingM),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.info),
                        label: const Text('Details'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConfig.accentColor,
                          foregroundColor: AppConfig.syrianWhite,
                        ),
                        onPressed: () {
                          // TODO: Navigate to site details page
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
