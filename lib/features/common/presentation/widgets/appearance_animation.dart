import 'package:flutter/material.dart';

class AppearanceAnimation extends StatefulWidget {
  const AppearanceAnimation({
    super.key,
    required this.child,
    this.duration = 500,
    this.delay = 0,
  }) : assert(delay >= 0 && delay <= 1);

  final double delay;
  final int duration;
  final Widget child;

  @override
  State<AppearanceAnimation> createState() => _AppearanceAnimationState();
}

class _AppearanceAnimationState extends State<AppearanceAnimation> with TickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.duration),
  )..forward();

  @override
  Widget build(BuildContext context) {
    const begin = Offset(0, -0.15);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          widget.delay,
          1,
          curve: Curves.easeInOutBack,
        ),
      ),
    );

    return SlideTransition(
      position: tween,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }
}
