import 'package:embermark/core/app_constants.dart';
import 'package:embermark/core/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomIconButton extends ConsumerStatefulWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.isChecked = false,
    this.onPressed,
  });

  final IconData icon;
  final bool isChecked;
  final VoidCallback? onPressed;

  @override
  ConsumerState<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends ConsumerState<CustomIconButton> {
  bool _hovering = false;
  bool _pressing = false;

  void _setHover(bool value) => setState(() => _hovering = value);

  void _setPress(bool value) => setState(() => _pressing = value);

  // Visual State Styling
  double get _backgroundOpacity =>
      _pressing
          ? 0.15
          : _hovering
          ? 0.25
          : 0.0;

  double get _borderOpacity =>
      _pressing
          ? 0.0
          : _hovering
          ? 0.1
          : 0.0;

  double get _shadowOpacity =>
      _pressing
          ? 0.0
          : _hovering
          ? 0.18
          : 0.0;

  static const _animationDuration = Duration(milliseconds: 75);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTapDown: (_) => _setPress(true),
        onTapUp: (_) {
          _setPress(false);
          widget.onPressed?.call();
        },
        onTapCancel: () => _setPress(false),
        child: _buildAnimatedScale(),
      ),
    );
  }

  Widget _buildAnimatedScale() {
    return AnimatedScale(
      scale: _pressing ? 0.99 : 1.0,
      duration: _animationDuration,
      child: _buildAnimatedContainer(),
    );
  }

  Widget _buildAnimatedContainer() {
    final interfaceScale = ref.watch(settingInterfaceScale);

    return AnimatedContainer(
      height: interfaceScale.buttonSize,
      width: interfaceScale.buttonSize,
      duration: _animationDuration,
      curve: Curves.linear,
      decoration: _buildDecoration(),
      child: HugeIcon(
        icon: widget.icon,
        color: widget.isChecked ? Colors.black : Colors.white,
        size: interfaceScale.iconSize,
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: Colors.white.withValues(alpha: _backgroundOpacity),
      borderRadius: BorderRadius.circular(13.5),
      border: Border.all(
        color: Colors.white.withValues(alpha: _borderOpacity),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: _shadowOpacity),
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}

extension ButtonScaleValue on InterfaceScale {
  double get buttonSize {
    switch (this) {
      case InterfaceScale.small:
        return iconButtonWidthSmall;
      case InterfaceScale.normal:
        return iconButtonWidthNormal;
      case InterfaceScale.large:
        return iconButtonWidthLarge;
    }
  }

  double get iconSize {
    switch (this) {
      case InterfaceScale.small:
        return iconButtonWidthSmall / 2;
      case InterfaceScale.normal:
        return iconButtonWidthNormal / 2;
      case InterfaceScale.large:
        return iconButtonWidthLarge / 2;
    }
  }
}