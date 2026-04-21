import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/onboarding_indicator.dart';
import 'onboarding_tours_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const String blobAsset = 'assets/images/onboarding/vector_7.svg';
  static const String illustrationLeftAsset =
      'assets/images/onboarding/group_107.svg';
  static const String illustrationRightAsset =
      'assets/images/onboarding/group_108.svg';
  static const String cloudAsset = 'assets/images/onboarding/vector_5.svg';

  void _goToTours(BuildContext context) {
    Navigator.of(context).push(_buildRoute());
  }

  Route _buildRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OnboardingToursScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 375 / 812,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                final imageHeight = height * 0.56;
                final blobWidth = width * 0.82;
                final girlWidth = width * 0.30;
                final boyWidth = width * 0.23;

                return Column(
                  children: [
                    SizedBox(
                      height: imageHeight,
                      width: width,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: imageHeight * 0.05,
                            left: width * 0.18,
                            child:
                                SvgPicture.asset(blobAsset, width: blobWidth),
                          ),
                          Positioned(
                            left: width * 0.23,
                            top: imageHeight * 0.15,
                            child: SvgPicture.asset(
                              cloudAsset,
                              width: width * 0.22,
                            ),
                          ),
                          Positioned(
                            left: width * 0.25,
                            bottom: imageHeight * 0.08,
                            child: SvgPicture.asset(
                              illustrationRightAsset,
                              width: boyWidth,
                            ),
                          ),
                          Positioned(
                            left: width * 0.46,
                            bottom: imageHeight * 0.07,
                            child: SvgPicture.asset(
                              illustrationLeftAsset,
                              width: girlWidth,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.085),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.12),
                      child: const Text(
                        'Find a local guide easily',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.14),
                      child: const Text(
                        'With Fellow4U, you can find a local\n'
                        'guide for your trip easily and explore\n'
                        'as the way you want.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.028),
                    const OnboardingIndicator(fromIndex: 0, toIndex: 0),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * 0.08,
                        bottom: height * 0.03,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => _goToTours(context),
                          child: const Text(
                            'SKIP',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.6,
                              color: Color(0xFF777777),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
