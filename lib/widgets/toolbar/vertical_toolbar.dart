import 'package:embermark/core/app_providers.dart';
import 'package:embermark/widgets/custom_mini_icon_button.dart';
import 'package:embermark/widgets/list_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class VerticalToolbar extends ConsumerStatefulWidget {
  const VerticalToolbar({super.key, required this.groups});

  final List<Widget> groups;

  @override
  ConsumerState<VerticalToolbar> createState() => _VerticalToolbarState();
}

class _VerticalToolbarState extends ConsumerState<VerticalToolbar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isPinned = ref.watch(temporaryPinToolbar);
    final columnCount = ref.watch(settingToolbarColumnCount);
    final List<Widget> toolbarItems = [];

    for (int i = 0; i < widget.groups.length; i++) {
      toolbarItems.add(widget.groups[i]);

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
        if (isPinned) return;
        setState(() {
          isExpanded = false;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: AnimatedPadding(
          padding: EdgeInsets.only(
            left: isExpanded ? 10 : 0,
            right: 10,
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              AnimatedContainer(
                clipBehavior: Clip.hardEdge,
                height: isExpanded ? 35 : 6,
                width: isExpanded ? 35 : 6,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withValues(alpha: 0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.0),
                    width: isExpanded ? 1.5 : 0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isExpanded ? 20 : 0),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(
                      isExpanded ? 20 : 0,
                    ),
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
                child: AnimatedOpacity(
                  opacity: isExpanded ? 1.0 : 0.0,
                  duration: Duration(milliseconds: isExpanded ? 150 : 100),
                  curve:
                      isExpanded
                          ? Curves.easeInExpo
                          : Curves.easeInCirc,
                  child: Center(
                    child: CustomMiniIconButton(
                      icon:
                          isPinned
                              ? HugeIcons.strokeRoundedPinOff
                              : HugeIcons.strokeRoundedPin,
                      //HugeIcons.strokeRoundedInformationCircle
                      isChecked: isPinned,
                      callback: () {
                        setState(() {
                          ref
                              .read(temporaryPinToolbar.notifier)
                              .updateState(!isPinned);
                        });
                      },
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                child: AnimatedContainer(
                  height: null,
                  width: isExpanded ? 43.0 * columnCount : 6,
                  decoration: BoxDecoration(
                    color:
                        isExpanded
                            ? Color(0xff2b422a)
                            : Color(0xff335034),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.075),
                      width: isExpanded ? 1.5 : 0,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isExpanded ? 20 : 0),
                      topRight: Radius.circular(
                        isExpanded ? 20 : 4,
                      ),
                      bottomLeft: Radius.circular(
                        isExpanded ? 20 : 0,
                      ),
                      bottomRight: Radius.circular(
                        isExpanded ? 20 : 4,
                      ),
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
                    padding: const EdgeInsets.all(4.5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      child: AnimatedOpacity(
                        opacity: isExpanded ? 1.0 : 0.0,
                        duration: Duration(milliseconds: isExpanded ? 150 : 75),
                        curve:
                            isExpanded
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