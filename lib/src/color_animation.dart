import 'package:flutter/material.dart';

extension ColorAnimationExtension on Widget {
  Widget colorAnimation({
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    Color beginColor =  Colors.blue,
    Color endColor = Colors.black
  }) {
    return _ColorAnimation(
      child: this,
      duration: duration,
      curve: curve,
      beginColor: beginColor,
      endColor:endColor,
    );
  }
}

class _ColorAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Color beginColor;
  final Color endColor;

  const _ColorAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.beginColor,
      required this.endColor,
  });

  @override
  _ColorAnimationState createState() => _ColorAnimationState();
}

class _ColorAnimationState extends State<_ColorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
     _colorAnimation = ColorTween(begin: widget.beginColor, end: widget.endColor)
         .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
     _controller.forward();

  }
  @override
  void didUpdateWidget(covariant _ColorAnimation oldWidget) {
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
      animation: _colorAnimation,
      builder: (context, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            _colorAnimation.value!,
            BlendMode.srcIn,
          ),
          child: child
        );
      },
        child: widget.child,
    );
  }
}