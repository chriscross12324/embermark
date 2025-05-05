import 'package:embermark/widgets/custom_icon_button.dart';
import 'package:embermark/widgets/list_separator.dart';
import 'package:embermark/widgets/toolbar/toolbar_group.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class VerticalToolbar extends StatefulWidget {
  const VerticalToolbar({super.key, required this.groups});

  final List<ToolbarGroup> groups;

  @override
  State<VerticalToolbar> createState() => _VerticalToolbarState();
}

class _VerticalToolbarState extends State<VerticalToolbar> {
  bool isPinned = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> toolbarItems = [];

    for (int i = 0; i < widget.groups.length; i++) {
      final group = widget.groups[i];
      toolbarItems.add(
        ToolbarGroup(
          groupName: group.groupName,
          children: group.children,
        ),
      );

      if (i < widget.groups.length - 1) {
        toolbarItems.add(const ListSeparator(orientation: Axis.horizontal));
      }
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isExpanded = true;
        });
      },
      onExit: (_) {
        setState(() {
          isExpanded = false;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: AnimatedPadding(
          padding: EdgeInsets.only(
            left: isPinned || isExpanded ? 10 : 0,
            right: 10,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                height: null,
                width: isPinned || isExpanded ? 49 : 6,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                duration: const Duration(milliseconds: 250),
                curve: Curves.fastOutSlowIn,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: AnimatedOpacity(
                    opacity: isPinned || isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    curve:
                        isPinned || isExpanded
                            ? Curves.easeInExpo
                            : Curves.easeInCirc,
                    child: CustomIconButton(
                      icon: isPinned ? HugeIcons.strokeRoundedPinOff : HugeIcons.strokeRoundedPin,
                      isChecked: isPinned,
                      callback: () {
                        setState(() {
                          isPinned = !isPinned;
                        });
                        ;
                      },
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 400),
                child: AnimatedContainer(
                  height: null,
                  width: isPinned || isExpanded ? 49 : 6,
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D2D),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.075),
                      width: isPinned || isExpanded ? 1.5 : 0,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isPinned || isExpanded ? 20 : 0),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(isPinned || isExpanded ? 20 : 0),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.fastOutSlowIn,
                  child: Padding(
                    padding: const EdgeInsets.all(5.5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: AnimatedOpacity(
                        opacity: isPinned || isExpanded ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 150),
                        curve:
                            isPinned || isExpanded
                                ? Curves.easeInExpo
                                : Curves.easeInCirc,
                        child: Column(children: toolbarItems),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
