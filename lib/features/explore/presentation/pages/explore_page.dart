import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/config/app_config.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.explore),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
      ),
      body: const Center(child: Text('Explore Page - Coming Soon')),
    );
  }
}
