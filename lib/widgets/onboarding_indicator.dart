import 'package:flutter/material.dart';

class OnboardingIndicator extends StatefulWidget {
  const OnboardingIndicator({
    super.key,
    required this.fromIndex,
    required this.toIndex,
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.easeOutCubic,
  });

  final int fromIndex;
  final int toIndex;
  final Duration duration;
  final Curve curve;

  @override
  State<OnboardingIndicator> createState() => _OnboardingIndicatorState();
}

class _OnboardingIndicatorState extends State<OnboardingIndicator>
    with SingleTickerProviderStateMixin {
  static const Color _activeColor = Color(0xFF00C7A7);
  static const Color _inactiveColor = Color(0xFFD9D9D9);
  static const double _width = 18;
  static const double _height = 3;
  static const double _gap = 6;
  static const int _count = 3;

  late AnimationController _controller;
  late Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _position = _buildTween(widget.fromIndex, widget.toIndex);

    if (widget.fromIndex == widget.toIndex) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fromIndex != widget.fromIndex ||
        oldWidget.toIndex != widget.toIndex ||
        oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve) {
      _controller.duration = widget.duration;
      _position = _buildTween(widget.fromIndex, widget.toIndex);
      if (widget.fromIndex == widget.toIndex) {
        _controller.value = 1;
      } else {
        _controller
          ..value = 0
          ..forward();
      }
    }
  }

  Animation<double> _buildTween(int from, int to) {
    final clampedFrom = from.clamp(0, _count - 1).toDouble();
    final clampedTo = to.clamp(0, _count - 1).toDouble();
    return Tween<double>(begin: clampedFrom, end: clampedTo).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = _width * _count + _gap * (_count - 1);
    final track = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_count, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index == _count - 1 ? 0 : _gap),
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _inactiveColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      }),
    );

    return SizedBox(
      width: totalWidth,
      height: _height,
      child: Stack(
        children: [
          track,
          AnimatedBuilder(
            animation: _position,
            builder: (context, child) {
              final left = _position.value * (_width + _gap);
              return Positioned(
                left: left,
                child: child!,
              );
            },
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _activeColor,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
