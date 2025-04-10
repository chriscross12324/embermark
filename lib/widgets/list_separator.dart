import 'package:flutter/material.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({super.key, required this.orientation});

  final Axis orientation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(height: double.infinity, width: 2, color: Colors.white.withValues(alpha: 0.05),),
    );
  }
}
