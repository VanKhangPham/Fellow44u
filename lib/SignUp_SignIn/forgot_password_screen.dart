import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'check_email_screen.dart';
import 'sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String logoAsset = 'assets/images/forgot password/Group 3.svg';
  static const String planeAsset = 'assets/images/forgot password/Vector.svg';
  static const String pathAsset = 'assets/images/forgot password/Vector 1.svg';
  static const String cloudAsset = 'assets/images/forgot password/Vector 6.svg';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _border = Color(0xFFE0E0E0);

  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'yoojin@gmail.com');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
              const Positioned.fill(
                child: ColoredBox(color: Colors.white),
              ),
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
                        child: SvgPicture.asset(
                          ForgotPasswordScreen.logoAsset,
                          width: width * 0.14,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        left: width * 0.26,
                        child: SvgPicture.asset(
                          ForgotPasswordScreen.pathAsset,
                          width: width * 0.52,
                        ),
                      ),
                      Positioned(
                        top: height * 0.03,
                        right: width * 0.06,
                        child: SvgPicture.asset(
                          ForgotPasswordScreen.planeAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        right: width * 0.3,
                        child: SvgPicture.asset(
                          ForgotPasswordScreen.cloudAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: headerHeight * 0.65,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipPath(
                          clipper: _ForgotPasswordCurveClipper(
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
                                  Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.022),
                                  Text(
                                    'Input your email, we will send you an\n'
                                    'instruction to reset your password.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: _textSecondary,
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.04),
                                  _buildEmailField(),
                                  SizedBox(height: height * 0.05),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: _handleSend,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _primary,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'SEND',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.22),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Back to ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: _textSecondary,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _handleBackToSignIn,
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

  void _handleSend() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CheckEmailScreen(),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );
          return FadeTransition(opacity: curved, child: child);
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            isDense: true,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _border),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _border),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _primary, width: 1.4),
            ),
            contentPadding: EdgeInsets.only(bottom: 6),
          ),
        ),
      ],
    );
  }

  void _handleBackToSignIn() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignInScreen(),
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          );
          return FadeTransition(opacity: curved, child: child);
        },
      ),
    );
  }
}

class _ForgotPasswordCurveClipper extends CustomClipper<Path> {
  _ForgotPasswordCurveClipper({required this.curveHeight});

  final double curveHeight;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(
      size.width * 0.5,
      0,
      size.width,
      curveHeight,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _ForgotPasswordCurveClipper oldClipper) {
    return oldClipper.curveHeight != curveHeight;
  }
}
