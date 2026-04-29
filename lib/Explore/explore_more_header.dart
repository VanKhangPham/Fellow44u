import 'package:flutter/material.dart';

class ExploreMoreHeader extends StatelessWidget {
  const ExploreMoreHeader({
    super.key,
    required this.heroAsset,
    required this.title,
    required this.onBack,
    required this.onSearchTap,
  });

  static const double contentHeight = 222;
  static const double searchOverlap = 24;

  final String heroAsset;
  final String title;
  final VoidCallback onBack;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: contentHeight + searchOverlap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: contentHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(heroAsset, fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.1),
                        Color.fromRGBO(0, 0, 0, 0.35),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: IconButton(
                    onPressed: onBack,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 44,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      height: 1.25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: GestureDetector(
              onTap: onSearchTap,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.12),
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF9E9E9E), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Hi, where do you want to explore?',
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExploreMoreIndicator extends StatelessWidget {
  const ExploreMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IndicatorDot(active: false),
        SizedBox(width: 6),
        _IndicatorDot(active: true),
        SizedBox(width: 6),
        _IndicatorDot(active: false),
      ],
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 7 : 6,
      height: active ? 7 : 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFBDBDBD) : const Color(0xFFD9D9D9),
        shape: BoxShape.circle,
      ),
    );
  }
}
