import 'package:flutter/material.dart';

extension RotationAnimationExtension on Widget {
  Widget rotationAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    double beginRotation = 1.0,
  }) {
    return _RotationAnimation(
      child: this,
      duration: duration,
      curve: curve,
      beginRotation: beginRotation,
    );
  }
}

class _RotationAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double beginRotation;

  const _RotationAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginRotation,
  });

  @override
  _RotationAnimationState createState() => _RotationAnimationState();
}

class _RotationAnimationState extends State<_RotationAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _rotationAnimation = Tween<double>(
      begin: widget.beginRotation,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
     _controller.forward();
  }
  @override
  void didUpdateWidget(covariant _RotationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: child,
        );
      },
        child: widget.child,
    );
  }
}