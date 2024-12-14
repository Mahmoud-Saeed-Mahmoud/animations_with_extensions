// 1. Define the Extension
import 'package:flutter/material.dart';

extension FadeAnimationExtension on Widget {
  Widget fadeAnimation({
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return _FadeAnimation(
      child: this,
      duration: duration,
      curve: curve,
    );
  }
}

// 2. Implement the animated widget
class _FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const _FadeAnimation({
    required this.child,
    required this.duration,
    required this.curve,
  });

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<_FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;


  @override
  void initState() {
      super.initState();
      _controller = AnimationController(
          vsync: this, duration: widget.duration
      );

      _opacityAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0
      ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      // Start the animation on first build
      _controller.forward();

  }

  @override
  void didUpdateWidget(covariant _FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
      _controller.reset();//resets to 0.0
      _controller.forward();// starts the animation

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}
