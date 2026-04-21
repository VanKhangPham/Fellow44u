import 'package:flutter/material.dart';

import 'sign_in_screen.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  static const String logoAsset = 'assets/images/forgot password_2/Group 3.png';
  static const String planeAsset = 'assets/images/forgot password_2/Vector.png';
  static const String pathAsset =
      'assets/images/forgot password_2/Vector 1.png';
  static const String cloudAsset =
      'assets/images/forgot password_2/Vector 6.png';
  static const String envelopeAsset =
      'assets/images/forgot password_2/envelope.png';

  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final media = MediaQuery.of(context);
          final topInset = media.padding.top;
          final bottomInset = media.padding.bottom;
          final width = constraints.maxWidth;
          final height = constraints.maxHeight - topInset - bottomInset;
          final headerHeight = height * 0.22;
          final curveHeight = height * 0.06;

          return Stack(
            children: [
              const Positioned.fill(child: ColoredBox(color: Colors.white)),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: headerHeight + topInset,
                child: const ColoredBox(color: _primary),
              ),
              Padding(
                padding: EdgeInsets.only(top: topInset, bottom: bottomInset),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: height * 0.05,
                        left: width * 0.06,
                        child: Image.asset(
                          CheckEmailScreen.logoAsset,
                          width: width * 0.14,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        left: width * 0.26,
                        child: Image.asset(
                          CheckEmailScreen.pathAsset,
                          width: width * 0.52,
                        ),
                      ),
                      Positioned(
                        top: height * 0.03,
                        right: width * 0.06,
                        child: Image.asset(
                          CheckEmailScreen.planeAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        right: width * 0.3,
                        child: Image.asset(
                          CheckEmailScreen.cloudAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: headerHeight * 0.65,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipPath(
                          clipper: _CheckEmailCurveClipper(
                            curveHeight: curveHeight,
                          ),
                          child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(
                                width * 0.08,
                                height * 0.04,
                                width * 0.08,
                                height * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Check Email',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.022),
                                  const Text(
                                    'Please check your email for the instructions on\n'
                                    'how to reset your password.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.065),
                                  Center(
                                    child: Image.asset(
                                      CheckEmailScreen.envelopeAsset,
                                      width: width * 0.42,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.2),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Back to ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: _textSecondary,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _backToSignIn(context),
                                          child: const Text(
                                            'Sign In',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: _primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _backToSignIn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );
          return FadeTransition(opacity: curved, child: child);
        },
      ),
      (route) => false,
    );
  }
}

class _CheckEmailCurveClipper extends CustomClipper<Path> {
  _CheckEmailCurveClipper({required this.curveHeight});

  final double curveHeight;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _CheckEmailCurveClipper oldClipper) {
    return oldClipper.curveHeight != curveHeight;
  }
}
