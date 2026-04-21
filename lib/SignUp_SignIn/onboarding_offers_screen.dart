import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/onboarding_indicator.dart';
import 'sign_in_screen.dart';

class OnboardingOffersScreen extends StatefulWidget {
  const OnboardingOffersScreen({super.key});

  static const String illustrationAsset =
      'assets/images/onboarding3/group_177.svg';

  @override
  State<OnboardingOffersScreen> createState() => _OnboardingOffersScreenState();
}

class _OnboardingOffersScreenState extends State<OnboardingOffersScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _imageSlide;
  late final Animation<Offset> _textSlide;
  late final Animation<Offset> _indicatorSlide;
  late final Animation<Offset> _buttonSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _imageSlide = Tween<Offset>(begin: const Offset(-0.08, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        );
    _textSlide = Tween<Offset>(begin: const Offset(-0.06, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.15, 0.9, curve: Curves.easeOutCubic),
          ),
        );
    _indicatorSlide =
        Tween<Offset>(begin: const Offset(-0.04, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 1, curve: Curves.easeOutCubic),
          ),
        );
    _buttonSlide =
        Tween<Offset>(begin: const Offset(-0.03, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1, curve: Curves.easeOutCubic),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                final buttonHeight = (height * 0.06)
                    .clamp(40.0, 52.0)
                    .toDouble();

                return Column(
                  children: [
                    SlideTransition(
                      position: _imageSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: SizedBox(
                          height: imageHeight,
                          width: width,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Transform.translate(
                              offset: Offset(
                                -width * 0.08,
                                15,
                              ), // dương = sang trái
                              child: SvgPicture.asset(
                                OnboardingOffersScreen.illustrationAsset,
                                width: width * 0.9,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.12,
                              ),
                              child: const Text(
                                'Create a trip and get offers',
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
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.14,
                              ),
                              child: const Text(
                                'Fellow4U helps you save time and get \n'
                                'offers from hundred local guides that \n'
                                'suit your trip.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    SlideTransition(
                      position: _indicatorSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: const OnboardingIndicator(
                          fromIndex: 1,
                          toIndex: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    SlideTransition(
                      position: _buttonSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: SizedBox(
                          width: width * 0.76,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 320,
                                  ),
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => const SignInScreen(),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        final curved = CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOut,
                                        );
                                        return FadeTransition(
                                          opacity: curved,
                                          child: child,
                                        );
                                      },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00C7A7),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'GET STARTED',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.6,
                                color: Colors.white,
                              ),
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
