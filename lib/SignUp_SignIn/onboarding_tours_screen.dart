import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/onboarding_indicator.dart';
import 'onboarding_offers_screen.dart';

class OnboardingToursScreen extends StatefulWidget {
  const OnboardingToursScreen({super.key});

  static const String blobAsset = 'assets/images/onboarding2/Vector_8.svg';
  static const String cloudAsset = 'assets/images/onboarding2/Vector_5.svg';
  static const String bookLeftAsset = 'assets/images/onboarding2/Group_98.png';
  static const String bookRightAsset = 'assets/images/onboarding2/Group_99.png';
  static const String girlAsset = 'assets/images/onboarding2/Group_101.svg';

  @override
  State<OnboardingToursScreen> createState() => _OnboardingToursScreenState();
}

class _OnboardingToursScreenState extends State<OnboardingToursScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _imageSlide;
  late final Animation<Offset> _textSlide;
  late final Animation<Offset> _indicatorSlide;
  late final Animation<Offset> _skipSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _imageSlide = Tween<Offset>(
      begin: const Offset(-0.08, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(-0.06, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.9, curve: Curves.easeOutCubic),
      ),
    );
    _indicatorSlide = Tween<Offset>(
      begin: const Offset(-0.04, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1, curve: Curves.easeOutCubic),
      ),
    );
    _skipSlide = Tween<Offset>(
      begin: const Offset(-0.03, 0),
      end: Offset.zero,
    ).animate(
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

  void _goToOffers(BuildContext context) {
    Navigator.of(context).push(_buildRoute());
  }

  Route _buildRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OnboardingOffersScreen(),
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

                return Column(
                  children: [
                    SlideTransition(
                      position: _imageSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: SizedBox(
                          height: imageHeight,
                          width: width,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: imageHeight * 0.17,
                                child: SvgPicture.asset(
                                  OnboardingToursScreen.blobAsset,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: width * 0.18,
                                top: imageHeight * 0.05,
                                child: SvgPicture.asset(
                                  OnboardingToursScreen.cloudAsset,
                                  width: width * 0.2,
                                ),
                              ),
                              Positioned(
                                left: width * 0.15,
                                top: imageHeight * 0.09,
                                child: Image.asset(
                                  OnboardingToursScreen.bookLeftAsset,
                                  width: width * 0.38,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                left: width * 0.47,
                                top: imageHeight * 0.07,
                                child: Image.asset(
                                  OnboardingToursScreen.bookRightAsset,
                                  width: width * 0.38,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                bottom: imageHeight * 0.1,
                                child: SvgPicture.asset(
                                  OnboardingToursScreen.girlAsset,
                                  width: width * 0.26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.08),
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.12),
                              child: const Text(
                                'Many tours around the world',
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.14),
                              child: const Text(
                                'Lorem Ipsum is simply dummy text of\n'
                                'the printing and typesetting industry.',
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
                    SizedBox(height: height * 0.028),
                    SlideTransition(
                      position: _indicatorSlide,
                      child: FadeTransition(
                        opacity: _fade,
                        child: const OnboardingIndicator(fromIndex: 0, toIndex: 1),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        right: width * 0.08,
                        bottom: height * 0.03,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SlideTransition(
                          position: _skipSlide,
                          child: FadeTransition(
                            opacity: _fade,
                            child: GestureDetector(
                              onTap: () => _goToOffers(context),
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
