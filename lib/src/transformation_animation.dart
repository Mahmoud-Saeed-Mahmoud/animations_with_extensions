import 'package:flutter/material.dart';

class _TransformAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Matrix4 beginMatrix;

  const _TransformAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginMatrix,
  });

  @override
  _TransformAnimationState createState() => _TransformAnimationState();
}

class _TransformAnimationState extends State<_TransformAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Matrix4?> _transformAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _transformAnimation,
      builder: (context, child) {
        return Transform(
            transform: _transformAnimation.value ?? Matrix4.identity(),
            child: child);
      },
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant _TransformAnimation oldWidget) {
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
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _transformAnimation =
        Matrix4Tween(begin: widget.beginMatrix, end: Matrix4.identity())
            .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _controller.forward();
  }
}

extension TransformAnimationExtension on Widget {
  Widget transformAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    required Matrix4 beginMatrix,
  }) {
    return _TransformAnimation(
      duration: duration,
      curve: curve,
      beginMatrix: beginMatrix,
      child: this,
    );
  }
}
