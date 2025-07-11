import 'package:flutter/material.dart';
//Todo Load images here once they confirmed to be permanent
class AssetManager {
  static const _assets = {
    'onboarding': [
      'assets/images/onboarding-1.png',
      'assets/images/onboarding-2.png',
    ],
    'welcome': [
      'assets/images/welcome-image.png',
      'assets/images/white-logo.png',
    ],
    'splash': [
      'assets/images/splash-logo.png',
    ],
  };

  static Future<void> preloadAssets(BuildContext context) async {
    try {
      await Future.wait([
        for (final category in _assets.values)
          for (final asset in category)
            precacheImage(AssetImage(asset), context),
      ]);
    } catch (e) {
      debugPrint('Error preloading assets: $e');

    }
  }
} 