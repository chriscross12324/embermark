import 'package:flutter/material.dart';
import 'package:macos_haptic_feedback/macos_haptic_feedback.dart';

class SplitView extends StatefulWidget {
  const SplitView({
    super.key,
    required this.leftChild,
    required this.rightChild,
  });

  final Widget leftChild;
  final Widget rightChild;

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  double _leftWidth = 600;
  final double _minWidth = 315;
  final double _splitterWidth = 10;
  final List<double> snapFractions = [0.25, 0.5, 0.75];
  double _dragOffsetCorrection = 0;
  bool isSplitterHovered = false;
  bool isSplitterDragging = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double rightWidth = totalWidth - _leftWidth - _splitterWidth;

    _leftWidth = _leftWidth.clamp(
      _minWidth,
      totalWidth - _minWidth - _splitterWidth,
    );
    rightWidth = rightWidth.clamp(
      _minWidth,
      totalWidth - _minWidth - _splitterWidth,
    );

    return Row(
      children: [
        Container(
          width: _leftWidth,
          color: Colors.transparent,
          child: widget.leftChild,
        ),
        MouseRegion(
          onEnter: (_) {
            setState(() {
              isSplitterHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isSplitterHovered = false;
            });
          },
          cursor: SystemMouseCursors.resizeColumn,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragUpdate: (details) {
              setState(() {
                final total =
                    MediaQuery.of(context).size.width - _splitterWidth;
                final maxLeftWidth = total - _minWidth;
                final previousWidth = _leftWidth;

                double proposed = _leftWidth + details.delta.dx;

                // Check if user is still dragging past min/max
                if (proposed < _minWidth) {
                  _dragOffsetCorrection += details.delta.dx;
                  proposed = _minWidth;
                } else if (proposed > maxLeftWidth) {
                  _dragOffsetCorrection += details.delta.dx;
                  proposed = maxLeftWidth;
                } else {
                  // Only apply offset if we're recovering from over-drag
                  if (_dragOffsetCorrection != 0) {
                    final remainingCorrection =
                        _dragOffsetCorrection + details.delta.dx;

                    // If the cursor hasn't caught up yet, don't move the splitter
                    if ((_dragOffsetCorrection < 0 &&
                            remainingCorrection < 0) ||
                        (_dragOffsetCorrection > 0 &&
                            remainingCorrection > 0)) {
                      _dragOffsetCorrection = remainingCorrection;
                      return;
                    }

                    // Cursor has caught up — clear the correction and continue
                    _dragOffsetCorrection = 0;
                  }

                  // Normal drag
                  _leftWidth = proposed;
                }

                final clamped = _leftWidth.clamp(_minWidth, maxLeftWidth);
                // Only trigger haptic when just hitting the min or max
                if ((previousWidth > _minWidth && clamped == _minWidth) ||
                    (previousWidth < maxLeftWidth && clamped == maxLeftWidth)) {
                  MacosHapticFeedback().generic();
                }

                _leftWidth = clamped;
              });
            },
            onHorizontalDragStart: (_) {
              setState(() {
                isSplitterDragging = true;
              });
            },
            onHorizontalDragEnd: (_) {
              setState(() {
                isSplitterDragging = false;
                _dragOffsetCorrection = 0;
              });
            },
            child: Container(
              width: _splitterWidth,
              color: Colors.transparent,
              child: Center(
                child: AnimatedContainer(
                  height:
                      isSplitterDragging
                          ? 50
                          : isSplitterHovered
                          ? 30
                          : 25,
                  width:
                      isSplitterDragging
                          ? 1.5
                          : isSplitterHovered
                          ? 3
                          : 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: isSplitterHovered || isSplitterDragging ? 1 : 0.35,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.fastOutSlowIn,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: rightWidth,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E301D),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                border: Border(
                  left: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 2,
                  ),
                ),
              ),
              child: widget.rightChild,
            ),
          ),
        ),
      ],
    );
  }
}
