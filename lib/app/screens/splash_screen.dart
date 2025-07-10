import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../logic/asset_manager.dart';
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _assetsLoaded = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadAssets();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _loadAssets() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      await AssetManager.preloadAssets(context);
      if (!mounted) return;
      setState(() {
        _assetsLoaded = true;
      });
      await _fadeController.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        context.goNamed(AppRoute.base.name);
      }

    }
    catch (e) {
      debugPrint('Error loading assets: $e');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _assetsLoaded
            ? FadeTransition(
          opacity: _fadeAnimation,
          child: _buildLogo(),
        )
            : _buildLogo(),
      ),
    );
  }

  Widget _buildLogo() {
    return const Image(
      image: AssetImage('assets/images/splash-logo.png'),
      width: 120,
      height: 120,
      fit: BoxFit.contain,
    );
  }
}
