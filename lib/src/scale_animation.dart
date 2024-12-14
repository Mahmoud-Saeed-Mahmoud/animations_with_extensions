import 'package:flutter/material.dart';

extension ScaleAnimationExtension on Widget {
  Widget scaleAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    double beginScale = 0.0,
  }) {
    return _ScaleAnimation(
      child: this,
      duration: duration,
      curve: curve,
      beginScale: beginScale,
    );
  }
}

class _ScaleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double beginScale;

  const _ScaleAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginScale,
  });

  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<_ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }
    @override
    void didUpdateWidget(covariant _ScaleAnimation oldWidget) {
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
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}