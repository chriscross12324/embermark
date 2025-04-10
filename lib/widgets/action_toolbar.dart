import 'package:embermark/widgets/custom_dropdown_button.dart';
import 'package:embermark/widgets/custom_icon_button.dart';
import 'package:embermark/widgets/list_separator.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ActionToolbar extends StatelessWidget {
  const ActionToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 55,
      width: 400,
      decoration: BoxDecoration(
        color: Color(0xFF2D2D2D),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 2,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconButton(icon: HugeIcons.strokeRoundedUndo03),
              CustomIconButton(icon: HugeIcons.strokeRoundedRedo03),
              ListSeparator(orientation: Axis.vertical),
              CustomDropdownButton(),
              ListSeparator(orientation: Axis.vertical),
              CustomIconButton(icon: HugeIcons.strokeRoundedTextBold),
              CustomIconButton(icon: HugeIcons.strokeRoundedTextItalic),
              CustomIconButton(icon: HugeIcons.strokeRoundedTextUnderline),
              CustomIconButton(icon: HugeIcons.strokeRoundedTextStrikethrough),
            ],
          ),
        ),
      ),
    );
  }
}
