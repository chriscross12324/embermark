import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return _BlurTransition(animation: animation, child: child);
      },
      child: child,
    );
  }
}

class _BlurTransition extends StatelessWidget {
  const _BlurTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          // Blur IN: start blurred and clear up (0 → 10 → 0)
          // Blur OUT: start sharp, blur out (1 → 0 → 10)
          final reverse = animation.status == AnimationStatus.reverse;
          final t = animation.value;
          final blur = reverse
              ? (t) * 10.0  // Outgoing: blur out
              : (1.0 - t) * 10.0; // Incoming: start blurred, clear in

          final opacity = t;

          return Opacity(
            opacity: opacity,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
