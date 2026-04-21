import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String logoAsset = 'assets/images/sign up/Group 3.svg';
  static const String planeAsset = 'assets/images/sign up/Vector.svg';
  static const String pathAsset = 'assets/images/sign up/Vector 1.svg';
  static const String cloudAsset = 'assets/images/sign up/Vector 6.svg';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color _primary = Color(0xFF00C7A7);
  static const Color _textPrimary = Color(0xFF212121);
  static const Color _textSecondary = Color(0xFF777777);
  static const Color _border = Color(0xFFE0E0E0);

  String _role = 'traveler';

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
          final headerHeight = height * 0.20;
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
                        top: height * 0.06,
                        left: width * 0.06,
                        child: SvgPicture.asset(
                          SignUpScreen.logoAsset,
                          width: width * 0.14,
                        ),
                      ),
                      Positioned(
                        top: height * 0.11,
                        left: width * 0.26,
                        child: SvgPicture.asset(
                          SignUpScreen.pathAsset,
                          width: width * 0.52,
                        ),
                      ),
                      Positioned(
                        top: height * 0.03,
                        right: width * 0.06,
                        child: SvgPicture.asset(
                          SignUpScreen.planeAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: height * 0.1,
                        right: width * 0.30,
                        child: SvgPicture.asset(
                          SignUpScreen.cloudAsset,
                          width: width * 0.16,
                        ),
                      ),
                      Positioned(
                        top: headerHeight * 0.65,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ClipPath(
                          clipper: _SignUpCurveClipper(
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
                                    'Sign Up',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  RadioGroup<String>(
                                    groupValue: _role,
                                    onChanged: (selected) {
                                      if (selected == null) return;
                                      setState(() => _role = selected);
                                    },
                                    child: Row(
                                      children: [
                                        _buildRoleOption(
                                          'traveler',
                                          'Traveler',
                                        ),
                                        SizedBox(width: width * 0.12),
                                        _buildRoleOption('guide', 'Guide'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildTextField(
                                          label: 'First Name',
                                          hint: 'Yoo',
                                        ),
                                      ),
                                      SizedBox(width: width * 0.08),
                                      Expanded(
                                        child: _buildTextField(
                                          label: 'Last Name',
                                          hint: 'Jin',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    label: 'Country',
                                    hint: 'Country',
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    label: 'Email',
                                    hint: 'Type email',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    label: 'Password',
                                    hint: 'Type password',
                                    obscure: true,
                                    helper: 'Password has more than 6 letters',
                                  ),
                                  SizedBox(height: height * 0.02),
                                  _buildTextField(
                                    label: 'Confirm Password',
                                    hint: '******',
                                    obscure: true,
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: _textSecondary,
                                        ),
                                        children: const [
                                          TextSpan(
                                            text:
                                                'By Signing Up, you agree to our ',
                                          ),
                                          TextSpan(
                                            text: 'Terms & Conditions',
                                            style: TextStyle(
                                              color: _primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {},
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
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.6,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account? ',
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
                                                    ) => const SignInScreen(),
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
                                            'Sign In',
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

  Widget _buildRoleOption(String value, String label) {
    return InkWell(
      onTap: () => setState(() => _role = value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            activeColor: _primary,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    bool obscure = false,
    String? helper,
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
          obscureText: obscure,
          keyboardType: keyboardType,
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
        if (helper != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              helper,
              style: const TextStyle(fontSize: 11, color: _textSecondary),
            ),
          ),
      ],
    );
  }
}

class _SignUpCurveClipper extends CustomClipper<Path> {
  _SignUpCurveClipper({required this.curveHeight});

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
  bool shouldReclip(covariant _SignUpCurveClipper oldClipper) {
    return oldClipper.curveHeight != curveHeight;
  }
}
