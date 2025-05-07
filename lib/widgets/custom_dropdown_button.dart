import 'package:embermark/widgets/custom_animated_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedScale(
          scale: _isPressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 75),
          curve: Curves.linear,
          child: AnimatedContainer(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  _isPressed
                      ? Colors.white.withValues(alpha: 0.05)
                      : _isHovered
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.5),
              border: Border.all(
                color: Colors.white.withValues(
                  alpha:
                      _isPressed
                          ? 0
                          : _isHovered
                          ? 0.1
                          : 0,
                ),
                width: 1.5,
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
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              padding: EdgeInsets.only(left: _isPressed ? 5 : 0),
              child: CustomAnimatedSwitcher(
                child:
                    _isHovered
                        ? HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowRight01,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 20,
                        )
                        : HugeIcon(
                          icon: HugeIcons.strokeRoundedHeading01,
                          color: Colors.white,
                          size: 20,
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
