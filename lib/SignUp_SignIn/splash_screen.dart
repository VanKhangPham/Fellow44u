import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_offers_screen.dart';
import 'onboarding_screen.dart';
import 'onboarding_tours_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAssets(context);
      _goToOnboarding();
    });
  }

  void _precacheAssets(BuildContext context) {
    final assets = <String>[
      _logo,
      _plane,
      _path,
      _cloudMain,
      _cloudSmall,
      _cloudTiny,
      _ground,
      _rightPlant,
      _leftPlantTall,
      _leftPlantShort,
      _hat,
      OnboardingScreen.blobAsset,
      OnboardingScreen.illustrationLeftAsset,
      OnboardingScreen.illustrationRightAsset,
      OnboardingScreen.cloudAsset,
      OnboardingToursScreen.blobAsset,
      OnboardingToursScreen.cloudAsset,
      OnboardingToursScreen.bookLeftAsset,
      OnboardingToursScreen.bookRightAsset,
      OnboardingToursScreen.girlAsset,
      OnboardingOffersScreen.illustrationAsset,
    ];

    final futures = <Future<dynamic>>[];
    for (final asset in assets) {
      if (asset.toLowerCase().endsWith('.png')) {
        futures.add(precacheImage(AssetImage(asset), context));
      } else {
        futures.add(SvgAssetLoader(asset).loadBytes(context));
      }
    }

    unawaited(Future.wait(futures));
  }

  void _goToOnboarding() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(_buildRoute());
    });
  }

  Route _buildRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 650),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OnboardingScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  static const Color _background = Color(0xFF00C7A7);

  static const String _logo = 'assets/images/splash/Logo.svg';
  static const String _plane = 'assets/images/splash/Vector.svg';
  static const String _path = 'assets/images/splash/Vector_1.svg';
  static const String _cloudMain = 'assets/images/splash/Vector_2.svg';
  static const String _cloudSmall = 'assets/images/splash/Vector_5.svg';
  static const String _cloudTiny = 'assets/images/splash/Vector_6.svg';
  static const String _ground = 'assets/images/splash/Vector_4.svg';
  static const String _rightPlant = 'assets/images/splash/Vector_3.svg';
  static const String _leftPlantTall = 'assets/images/splash/Group_1.svg';
  static const String _leftPlantShort = 'assets/images/splash/Group_2.svg';
  static const String _hat = 'assets/images/splash/Group.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Center(
        child: AspectRatio(
          aspectRatio: 375 / 812,
          child: LayoutBuilder(
            builder: (context, constraints) {
              const designWidth = 375.0;
              final scale = constraints.maxWidth / designWidth;

              double dx(double value) => value * scale;
              double dy(double value) => value * scale;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Clouds
                  Positioned(
                    left: dx(24),
                    top: dy(70),
                    child: SvgPicture.asset(
                      _cloudTiny,
                      width: dx(78),
                    ),
                  ),
                  Positioned(
                    right: dx(28),
                    top: dy(90),
                    child: SvgPicture.asset(
                      _cloudMain,
                      width: dx(96),
                    ),
                  ),
                  Positioned(
                    right: dx(52),
                    top: dy(190),
                    child: SvgPicture.asset(
                      _cloudSmall,
                      width: dx(92),
                    ),
                  ),

                  // Plane and dashed path
                  Positioned(
                    left: dx(10),
                    top: dy(150),
                    child: SvgPicture.asset(
                      _path,
                      width: dx(320),
                    ),
                  ),
                  Positioned(
                    left: dx(230),
                    top: dy(160),
                    child: SvgPicture.asset(
                      _plane,
                      width: dx(70),
                    ),
                  ),

                  // Logo
                  Positioned(
                    left: dx(85),
                    top: dy(320),
                    child: SvgPicture.asset(
                      _logo,
                      width: dx(205),
                    ),
                  ),

                  // Bottom ground
                  Positioned(
                    left: dx(0),
                    right: dx(0),
                    bottom: dy(0),
                    child: SvgPicture.asset(
                      _ground,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Right plant
                  Positioned(
                    right: dx(-6),
                    bottom: dy(-12),
                    child: SvgPicture.asset(
                      _rightPlant,
                      width: dx(150),
                    ),
                  ),

                  // Left plants
                  Positioned(
                    left: dx(16),
                    bottom: dy(-6),
                    child: SvgPicture.asset(
                      _leftPlantTall,
                      width: dx(66),
                    ),
                  ),
                  Positioned(
                    left: dx(0),
                    bottom: dy(-2),
                    child: SvgPicture.asset(
                      _leftPlantShort,
                      width: dx(58),
                    ),
                  ),

                  // Hat on ground
                  Positioned(
                    right: dx(70),
                    bottom: dy(58),
                    child: SvgPicture.asset(
                      _hat,
                      width: dx(110),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
