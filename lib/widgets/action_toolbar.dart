import 'package:embermark/widgets/custom_dropdown_button.dart';
import 'package:embermark/widgets/custom_icon_button.dart';
import 'package:embermark/widgets/custom_overflow_button.dart';
import 'package:embermark/widgets/list_separator.dart';
import 'package:embermark/widgets/measure_size.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ActionToolbar extends StatefulWidget {
  const ActionToolbar({super.key, required this.pageNum});

  final int pageNum;

  @override
  State<ActionToolbar> createState() => _ActionToolbarState();
}

class _ActionToolbarState extends State<ActionToolbar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Size _childSize = Size.zero;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 49,
      width: null,
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.075),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.elasticOut,
      child: Padding(
        padding: const EdgeInsets.all(5.5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: MeasureSize(
              key: ValueKey(widget.pageNum),
              onChange: (Size size) {
                if (size != _childSize) {
                  setState(() {
                    _childSize = size;
                    print(size);
                  });
                }
              },
              child: widget.pageNum == 0 ? editorActions() : watermarkActions(),
            ),
          ),
        ),
      ),
    );
  }
}

Widget editorActions() {
  return Row(
    key: ValueKey(0),
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomIconButton(icon: HugeIcons.strokeRoundedUndo03),
      CustomIconButton(icon: HugeIcons.strokeRoundedRedo03),
      ListSeparator(orientation: Axis.vertical),
      CustomDropdownButton(),
      ListSeparator(orientation: Axis.vertical),
      CustomOverflowButton(icon: HugeIcons.strokeRoundedTextBold),
      CustomIconButton(icon: HugeIcons.strokeRoundedTextBold),
      CustomIconButton(icon: HugeIcons.strokeRoundedTextItalic),
      CustomIconButton(icon: HugeIcons.strokeRoundedTextUnderline),
      CustomIconButton(icon: HugeIcons.strokeRoundedTextStrikethrough),
    ],
  );
}

Widget watermarkActions() {
  return Row(
    key: ValueKey(1),
    mainAxisSize: MainAxisSize.min,
    children: [
      CustomIconButton(icon: HugeIcons.strokeRoundedLeftToRightBlockQuote),
      CustomIconButton(icon: HugeIcons.strokeRoundedLeftToRightListBullet),
      CustomIconButton(icon: HugeIcons.strokeRoundedLink04),
    ],
  );
}
