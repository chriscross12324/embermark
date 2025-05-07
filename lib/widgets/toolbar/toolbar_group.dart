import 'package:flutter/material.dart';

class ToolbarGroup extends StatefulWidget {
  const ToolbarGroup({
    super.key,
    required this.children,
    required this.groupName,
  });

  final List<Widget> children;
  final String groupName;

  @override
  State<ToolbarGroup> createState() => _ToolbarGroupState();
}

class _ToolbarGroupState extends State<ToolbarGroup> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _menuVisible = false;

  void _toggleMenu() {
    if (_menuVisible) {
      _hideMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            width: 300,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, -50),
              showWhenUnlinked: false,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.children,
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _menuVisible = true);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _menuVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      key: _key,
      crossAxisCount: 2,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: widget.children,
    );
    return Column(key: _key, children: widget.children);
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }
}
