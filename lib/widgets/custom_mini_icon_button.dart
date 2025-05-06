import 'package:embermark/core/app_constants.dart';
import 'package:embermark/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomMiniIconButton extends StatefulWidget {
  const CustomMiniIconButton({
    super.key,
    required this.icon,
    this.isChecked = false,
    this.callback,
  });

  final IconData icon;
  final bool isChecked;
  final VoidCallback? callback;

  @override
  State<CustomMiniIconButton> createState() => _CustomMiniIconButtonState();
}

class _CustomMiniIconButtonState extends State<CustomMiniIconButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _updateHover(bool hovering) => setState(() => _isHovered = hovering);
  void _updatePress(bool pressing) => setState(() => _isPressed = pressing);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHover(true),
      onExit: (_) => _updateHover(false),
      child: GestureDetector(
        onTapDown: (_) => _updatePress(true),
        onTapUp: (_) {
          setState(() {
            _updatePress(false);
            widget.callback?.call();
          });
        },
        onTapCancel: () => _updatePress(false),
        child: AnimatedScale(
          scale: _isPressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 75),
          curve: Curves.linear,
          child: AnimatedContainer(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color:
                  _isPressed
                      ? blendWithWhite(Color(0xFF416C41), 0.25)
                      : _isHovered
                      ? blendWithWhite(Color(0xFF416C41), 0.35)
                      : blendWithWhite(Color(0xFF416C41), 0.00),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(
                  alpha:
                      _isPressed
                          ? 0
                          : _isHovered
                          ? 0.35
                          : 0,
                ),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha:
                        _isPressed
                            ? 0
                            : _isHovered
                            ? 0.18
                            : 0,
                  ),
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 75),
            curve: Curves.linear,
            child: HugeIcon(
              icon: widget.icon,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
