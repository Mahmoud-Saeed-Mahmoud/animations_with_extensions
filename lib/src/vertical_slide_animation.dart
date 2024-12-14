import 'package:flutter/material.dart';

extension VerticalSlideAnimationExtension on Widget {
  Widget verticalSlideAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    double beginOffset = 0.5,
  }) {
    return _VerticalSlideAnimation(
      child: this,
      duration: duration,
      curve: curve,
      beginOffset: beginOffset,
    );
  }
}

class _VerticalSlideAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double beginOffset;

  const _VerticalSlideAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginOffset,
  });

  @override
  _VerticalSlideAnimationState createState() => _VerticalSlideAnimationState();
}

class _VerticalSlideAnimationState extends State<_VerticalSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, widget.beginOffset),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }
    @override
    void didUpdateWidget(covariant _VerticalSlideAnimation oldWidget) {
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