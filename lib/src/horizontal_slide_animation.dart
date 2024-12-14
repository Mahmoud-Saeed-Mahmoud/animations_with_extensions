import 'package:flutter/material.dart';

// 1. Horizontal Slide Extension
extension HorizontalSlideAnimationExtension on Widget {
  Widget horizontalSlideAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    double beginOffset = 0.5,
  }) {
    return _HorizontalSlideAnimation(
      child: this,
      duration: duration,
      curve: curve,
      beginOffset: beginOffset,
    );
  }
}

class _HorizontalSlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double beginOffset;

  const _HorizontalSlideAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginOffset,
  });

  @override
  _HorizontalSlideAnimationState createState() => _HorizontalSlideAnimationState();
}

class _HorizontalSlideAnimationState extends State<_HorizontalSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.beginOffset, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _HorizontalSlideAnimation oldWidget) {
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
        animation: _offsetAnimation,
        builder: (context, child) {
          return SlideTransition(
              position: _offsetAnimation,
              child: child,
          );
        },
      child: widget.child,
    );
  }
}