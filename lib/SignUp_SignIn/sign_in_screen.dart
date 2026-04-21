import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Explore/explore_screen.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String logoAsset = 'assets/images/sign in/Group 3.svg';
  static const String planeAsset = 'assets/images/sign in/Vector.svg';
  static const String pathAsset = 'assets/images/sign in/Vector 1.svg';
  static const String cloudAsset = 'assets/images/sign in/Vector 6.svg';
  static const String socialsAsset = 'assets/images/sign in/Group 176.svg';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _border = Color(0xFFE0E0E0);
  static const String _demoEmail = 'demo@fellow4u.com';
  static const String _demoPassword = '123456';

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: _demoEmail);
    _passwordController = TextEditingController(text: _demoPassword);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                        child: SvgPicture.asset(
                          SignInScreen.logoAsset,
                          width: width * 0.14,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        left: width * 0.26,
                        child: SvgPicture.asset(
                          SignInScreen.pathAsset,
                          width: width * 0.52,
                        ),
                      ),
                      Positioned(
                        top: height * 0.03,
                        right: width * 0.06,
                        child: SvgPicture.asset(
                          SignInScreen.planeAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        right: width * 0.3,
                        child: SvgPicture.asset(
                          SignInScreen.cloudAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: headerHeight * 0.65,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipPath(
                          clipper: _SignInCurveClipper(
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
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.012),
                                  Text(
                                    'Welcome back, Yoo Jin',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: _primary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  _buildTextField(
                                    label: 'Email',
                                    controller: _emailController,
                                    hint: _demoEmail,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    label: 'Password',
                                    controller: _passwordController,
                                    hint: _demoPassword,
                                    obscure: true,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Demo email: demo@fellow4u.com',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _textSecondary,
                                    ),
                                  ),
                                  const Text(
                                    'Demo password: 123456',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(
                                            milliseconds: 280,
                                          ),
                                          pageBuilder:
                                              (
                                                context,
                                                animation,
                                                secondaryAnimation,
                                              ) => const ForgotPasswordScreen(),
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
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _textSecondary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: _handleSignIn,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _primary,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'SIGN IN',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Center(
                                    child: Text(
                                      'or sign in with',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _textSecondary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Center(
                                    child: SvgPicture.asset(
                                      SignInScreen.socialsAsset,
                                      width: width * 0.46,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account? ",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: _textSecondary,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                      milliseconds: 280,
                                                    ),
                                                pageBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                    ) => const SignUpScreen(),
                                                transitionsBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child,
                                                    ) {
                                                      final curved =
                                                          CurvedAnimation(
                                                            parent: animation,
                                                            curve:
                                                                Curves.easeOut,
                                                          );
                                                      return FadeTransition(
                                                        opacity: curved,
                                                        child: child,
                                                      );
                                                    },
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: _primary,
                                              fontWeight: FontWeight.w600,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    bool obscure = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          textCapitalization: TextCapitalization.none,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: _border),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: _border),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: _primary, width: 1.4),
            ),
            contentPadding: const EdgeInsets.only(bottom: 6),
          ),
        ),
      ],
    );
  }

  void _handleSignIn() {
    final email = _emailController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();

    if (email != _demoEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please use demo email: demo@fellow4u.com'),
        ),
      );
      return;
    }

    if (password.isNotEmpty && password != _demoPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Demo password is 123456')));
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ExploreScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

class _SignInCurveClipper extends CustomClipper<Path> {
  _SignInCurveClipper({required this.curveHeight});

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
  bool shouldReclip(covariant _SignInCurveClipper oldClipper) {
    return oldClipper.curveHeight != curveHeight;
  }
}
