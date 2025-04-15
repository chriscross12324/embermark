import 'package:flutter/material.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  const MeasureSize({super.key, required this.child, required this.onChange});

  final Widget child;
  final OnWidgetSizeChange onChange;

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final _key = GlobalKey();
  Size _oldSize = Size.zero;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MeasureSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  void _notifySize() {
    final context = _key.currentContext;
    if (context == null) return;

    final newSize = context.size ?? Size.zero;
    if (_oldSize != newSize) {
      _oldSize = newSize;
      widget.onChange(newSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(key: _key, child: widget.child));
  }
}
