import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({super.key, required this.orientation});

  final Axis orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        height: orientation == Axis.vertical ? double.infinity : 2,
        width: orientation == Axis.vertical ? 2 : double.infinity,
        color: Colors.white.withValues(alpha: 0.05),
      ),
    );
  }
}
