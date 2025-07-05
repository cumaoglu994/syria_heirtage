class TouristSite {
  final String id;
  final String name;
  final String nameAr;
  final String description;
  final String descriptionAr;
  final String category;
  final String city;
  final String region;
  final double latitude;
  final double longitude;
  final String address;
  final String addressAr;
  final List<String> images;
  final String? videoUrl;
  final String? panorama360Url;
  final double rating;
  final int reviewCount;
  final double entranceFee;
  final String currency;
  final String visitingHours;
  final String contactPhone;
  final String contactEmail;
  final String website;
  final Map<String, dynamic>? additionalInfo;
  final bool isFavorite;
  final bool isOfflineAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  TouristSite({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.description,
    required this.descriptionAr,
    required this.category,
    required this.city,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.addressAr,
    required this.images,
    this.videoUrl,
    this.panorama360Url,
    required this.rating,
    required this.reviewCount,
    required this.entranceFee,
    required this.currency,
    required this.visitingHours,
    required this.contactPhone,
    required this.contactEmail,
    required this.website,
    this.additionalInfo,
    this.isFavorite = false,
    this.isOfflineAvailable = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TouristSite.fromJson(Map<String, dynamic> json) {
    return TouristSite(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      description: json['description'] as String,
      descriptionAr: json['descriptionAr'] as String,
      category: json['category'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      address: json['address'] as String,
      addressAr: json['addressAr'] as String,
      images: List<String>.from(json['images']),
      videoUrl: json['videoUrl'] as String?,
      panorama360Url: json['panorama360Url'] as String?,
      rating: json['rating'] as double,
      reviewCount: json['reviewCount'] as int,
      entranceFee: json['entranceFee'] as double,
      currency: json['currency'] as String,
      visitingHours: json['visitingHours'] as String,
      contactPhone: json['contactPhone'] as String,
      contactEmail: json['contactEmail'] as String,
      website: json['website'] as String,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isOfflineAvailable: json['isOfflineAvailable'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'description': description,
      'descriptionAr': descriptionAr,
      'category': category,
      'city': city,
      'region': region,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'addressAr': addressAr,
      'images': images,
      'videoUrl': videoUrl,
      'panorama360Url': panorama360Url,
      'rating': rating,
      'reviewCount': reviewCount,
      'entranceFee': entranceFee,
      'currency': currency,
      'visitingHours': visitingHours,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'website': website,
      'additionalInfo': additionalInfo,
      'isFavorite': isFavorite,
      'isOfflineAvailable': isOfflineAvailable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  TouristSite copyWith({
    String? id,
    String? name,
    String? nameAr,
    String? description,
    String? descriptionAr,
    String? category,
    String? city,
    String? region,
    double? latitude,
    double? longitude,
    String? address,
    String? addressAr,
    List<String>? images,
    String? videoUrl,
    String? panorama360Url,
    double? rating,
    int? reviewCount,
    double? entranceFee,
    String? currency,
    String? visitingHours,
    String? contactPhone,
    String? contactEmail,
    String? website,
    Map<String, dynamic>? additionalInfo,
    bool? isFavorite,
    bool? isOfflineAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TouristSite(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      category: category ?? this.category,
      city: city ?? this.city,
      region: region ?? this.region,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      addressAr: addressAr ?? this.addressAr,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      panorama360Url: panorama360Url ?? this.panorama360Url,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      entranceFee: entranceFee ?? this.entranceFee,
      currency: currency ?? this.currency,
      visitingHours: visitingHours ?? this.visitingHours,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      website: website ?? this.website,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      isFavorite: isFavorite ?? this.isFavorite,
      isOfflineAvailable: isOfflineAvailable ?? this.isOfflineAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TouristSite &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TouristSite{id: $id, name: $name, category: $category, city: $city}';
  }
}
