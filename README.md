# Syrian Heritage - تطبيق التراث السوري

A comprehensive tourism application showcasing Syria's rich cultural heritage, archaeological sites, and tourist attractions with multi-language support.

## Features

### 🌟 Core Features
- **Multi-language Support**: Arabic, English, Russian, French, Chinese
- **Offline Mode**: Download city data for offline access
- **QR Pass System**: Digital tickets for multiple sites
- **AR Experience**: Augmented reality for historical sites
- **Local Guides**: Connect with certified local guides
- **Smart Notifications**: Real-time updates and alerts

### 🏛️ Tourist Sites
- Archaeological sites (Palmyra, Aleppo Citadel, Krak des Chevaliers)
- Museums and cultural centers
- Religious sites (mosques, churches)
- Public parks and gardens
- Beaches and coastal areas
- Traditional markets and souks

### 🗺️ Navigation & Maps
- Interactive maps with tourist sites
- Turn-by-turn navigation
- Public transportation integration
- Walking and driving routes

### 🎫 Booking & Services
- Ticket booking for attractions
- Hotel and accommodation booking
- Restaurant reservations
- Tour guide services
- Transportation booking

### 📱 User Experience
- Beautiful, modern UI design
- RTL support for Arabic
- Dark/Light theme modes
- Accessibility features
- Performance optimized

## Technology Stack

- **Framework**: Flutter 3.8+
- **State Management**: Provider + ChangeNotifier
- **Navigation**: GoRouter
- **Localization**: Flutter Localizations
- **Maps**: Google Maps Flutter
- **Database**: SQLite (local) + PostgreSQL (backend)
- **Networking**: Dio + HTTP
- **Storage**: SharedPreferences + Secure Storage
- **AR**: AR Flutter Plugin
- **QR Codes**: QR Flutter + Mobile Scanner

## Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── constants/       # App constants
│   ├── models/          # Data models
│   ├── services/        # API services
│   └── utils/           # Utility functions
├── features/
│   ├── home/           # Home page
│   ├── explore/        # Explore cities
│   ├── events/         # Events and festivals
│   ├── tours/          # Guided tours
│   ├── shopping/       # Traditional markets
│   ├── accommodation/  # Hotels and lodging
│   ├── ar/             # AR experiences
│   └── profile/        # User profile
├── shared/
│   ├── providers/      # State providers
│   └── widgets/        # Shared widgets
└── l10n/              # Localization files
```

## Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/syria_heritage.git
   cd syria_heritage
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Configuration

1. **API Configuration**
   - Update `lib/core/config/app_config.dart` with your API endpoints
   - Set up your Mapbox access token for maps

2. **Localization**
   - Add new language files in `lib/l10n/`
   - Update `l10n.yaml` configuration

3. **Assets**
   - Add images to `assets/images/`
   - Add icons to `assets/icons/`
   - Add fonts to `assets/fonts/`

## Multi-Language Support

The app supports 5 languages:
- 🇺🇸 English (en)
- 🇸🇦 Arabic (ar)
- 🇷🇺 Russian (ru)
- 🇫🇷 French (fr)
- 🇨🇳 Chinese (zh)

### Adding New Languages

1. Create a new ARB file in `lib/l10n/` (e.g., `app_fr.arb`)
2. Add the locale to `l10n.yaml`
3. Update the supported locales in `main.dart`

## Key Features Implementation

### QR Pass System
- Digital tickets for multiple attractions
- QR code generation and scanning
- Offline validation
- Integration with entrance gates

### AR Experience
- Historical information overlay
- 3D reconstructions of ancient sites
- Interactive educational content
- Location-based AR triggers

### Offline Mode
- Download city data packages
- Cached maps and images
- Offline search functionality
- Sync when online

### Local Guides
- Verified guide profiles
- Booking system
- Reviews and ratings
- Real-time availability

## API Integration

The app integrates with:
- Syrian Tourism Ministry API
- Payment gateways
- Weather services
- Transportation APIs
- Social media platforms

## Security Features

- Encrypted data storage
- Secure API communication
- User authentication
- Privacy protection
- GDPR compliance

## Performance Optimization

- Image caching and compression
- Lazy loading
- Background data sync
- Memory management
- Battery optimization

## Testing

```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- Email: support@syrianheritage.com
- Website: https://syrianheritage.com
- Documentation: https://docs.syrianheritage.com

## Acknowledgments

- Syrian Ministry of Tourism
- UNESCO World Heritage Sites
- Local tour guides and experts
- Open source community

---

**Syrian Heritage** - Preserving and promoting Syria's cultural legacy through technology.
