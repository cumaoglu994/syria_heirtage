import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/config/app_config.dart';

class ARPage extends StatelessWidget {
  const ARPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ar),
        backgroundColor: AppConfig.primaryColor,
        foregroundColor: AppConfig.syrianWhite,
      ),
      body: const Center(child: Text('AR Experience Page - Coming Soon')),
    );
  }
}
