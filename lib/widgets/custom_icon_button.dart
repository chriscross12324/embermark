import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({super.key, required this.icon});

  final IconData icon;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
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
        child: AnimatedContainer(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color:
                _isPressed ? Color(0xFF3D3D3D) :
                _isHovered
                    ? Color(0xFF424242)
                    : Color(0xFF424242).withValues(alpha: 0),
            borderRadius: BorderRadius.circular(12.5),
            border: Border.all(
              color: Colors.white.withValues(
                alpha:
                    _isPressed
                        ? 0
                        : _isHovered
                        ? 0.05
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
          child: HugeIcon(
            icon: widget.icon,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
