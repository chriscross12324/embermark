import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:embermark/widgets/custom_dropdown_button.dart';
import 'package:embermark/widgets/custom_icon_button.dart';
import 'package:embermark/widgets/split_view.dart';
import 'package:embermark/widgets/toolbar/toolbar_group.dart';
import 'package:embermark/widgets/toolbar/vertical_toolbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

import 'core/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktop()) {
    await Window.initialize();
  }

  runApp(ProviderScope(child: const EmbermarkApp()));
  if (isDesktop()) {
    doWhenWindowReady(() {
      appWindow.minSize = Size(800, 500);
    });
  }
}

class EmbermarkApp extends StatelessWidget {
  const EmbermarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white.withValues(alpha: 0.25),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  bool _isController1Scrolling = false;
  bool _isController2Scrolling = false;
  String inputString = "";
  int pageNum = 0;

  @override
  void initState() {
    super.initState();

    /*_scrollController1.addListener(() {
      if (_isController2Scrolling) return;
      _isController1Scrolling = true;
      double scrollFraction = _scrollController1.offset / _scrollController1.position.maxScrollExtent;
      double targetOffset = scrollFraction * _scrollController2.position.maxScrollExtent;
      _scrollController2.jumpTo(targetOffset*/ /*.clamp(0.0, _scrollController2.position.maxScrollExtent)*/ /*);
      _isController1Scrolling = false;
    });

    _scrollController2.addListener(() {
      if (_isController1Scrolling) return;
      _isController2Scrolling = true;
      double scrollFraction = _scrollController2.offset / _scrollController2.position.maxScrollExtent;
      double targetOffset = scrollFraction * _scrollController1.position.maxScrollExtent;
      _scrollController1.jumpTo(targetOffset*/ /*.clamp(0.0, _scrollController1.position.maxScrollExtent)*/ /*);
      _isController2Scrolling = false;
    });*/
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPinned = ref.watch(temporaryPinToolbar);
    final belowMinWidth = MediaQuery.of(context).size.width < 640;

    return Scaffold(
      backgroundColor: Color(0xFF171C17),
      body:
          belowMinWidth
              ? SmallWidthWarning()
              : Stack(
                children: [
                  SplitView(
                    leftChild: TextField(
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                        hintText: 'Type...',
                        hintStyle: GoogleFonts.nunito(
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      scrollController: _scrollController1,
                      controller: _textEditingController,
                      onChanged: (newString) {
                        setState(() {
                          inputString = newString;
                        });
                      },
                      cursorColor: Colors.white,
                      cursorHeight: 18,
                      cursorOpacityAnimates: true,
                      cursorRadius: Radius.circular(2),
                      cursorWidth: 2,
                    ),
                    rightChild: SelectionArea(
                      child: Markdown(
                        data: inputString,
                        selectable: false,
                        styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                        styleSheet: MarkdownStyleSheet(
                          a: TextStyle(color: Colors.white),
                          p: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          pPadding: EdgeInsets.zero,
                          code: TextStyle(color: Colors.white),
                          h1: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          h1Padding: EdgeInsets.only(top: 5),
                          h2: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          h2Padding: EdgeInsets.only(top: 5),
                          h3: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          h3Padding: EdgeInsets.only(top: 5),
                          h4: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          h4Padding: EdgeInsets.only(top: 5),
                          h5: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          h5Padding: EdgeInsets.only(top: 5),
                          h6: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          h6Padding: EdgeInsets.only(top: 5),
                          em: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.1,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          strong: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          del: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            decorationColor: Colors.white.withValues(alpha: 0.8),
                            decorationThickness: 1.5,
                          ),
                          blockquote: TextStyle(color: Colors.white),
                          img: TextStyle(color: Colors.white),
                          checkbox: TextStyle(color: Colors.white),
                          blockSpacing: 5.0,
                          listIndent: 24,
                          listBullet: TextStyle(color: Colors.white),
                          listBulletPadding: EdgeInsets.zero,
                          tableHead: TextStyle(),
                          tableBody: TextStyle(),
                          tableHeadAlign: TextAlign.left,
                          tablePadding: EdgeInsets.zero,
                          tableBorder: TableBorder.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          tableColumnWidth: null,
                          tableScrollbarThumbVisibility: false,
                          tableCellsPadding: null,
                          tableCellsDecoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                          tableVerticalAlignment: TableCellVerticalAlignment.middle,
                          blockquotePadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          blockquoteDecoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Color(0xFF39B543), width: 4),
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                          codeblockPadding: null,
                          codeblockDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                          horizontalRuleDecoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          textAlign: WrapAlignment.start,
                          h1Align: WrapAlignment.start,
                          h2Align: WrapAlignment.start,
                          h3Align: WrapAlignment.start,
                          h4Align: WrapAlignment.start,
                          h5Align: WrapAlignment.start,
                          h6Align: WrapAlignment.start,
                          unorderedListAlign: WrapAlignment.start,
                          orderedListAlign: WrapAlignment.start,
                          blockquoteAlign: WrapAlignment.start,
                          codeblockAlign: WrapAlignment.start,
                          superscriptFontFeatureTag: null,
                          textScaler: null,
                        ),
                        controller: _scrollController2,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: VerticalToolbar(
                      groups: [
                        ToolbarGroup(
                          groupName: 'History',
                          children: [
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedUndo03,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedRedo03,
                            ),
                          ],
                        ),
                        CustomDropdownButton(),
                        ToolbarGroup(
                          groupName: 'Style',
                          children: [
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedTextBold,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedTextItalic,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedTextUnderline,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedTextStrikethrough,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedLink04,
                            ),
                            CustomIconButton(
                              icon: HugeIcons.strokeRoundedSourceCode,
                            ),
                          ],
                        ),
                        ToolbarGroup(
                          groupName: 'List',
                          children: [
                            CustomIconButton(
                              icon:
                              HugeIcons
                                  .strokeRoundedLeftToRightListBullet,
                            ),
                            CustomIconButton(
                              icon:
                              HugeIcons
                                  .strokeRoundedLeftToRightListNumber,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

class SmallWidthWarning extends StatelessWidget {
  const SmallWidthWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedArrowHorizontal,
            color: Colors.white,
            size: 128,
          ),
          Text(
            'Window Too Small',
            style: GoogleFonts.nunito(
              color: Colors.white.withValues(alpha: 0.75),
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'This layout needs more space. Please resize the window to continue.',
            style: GoogleFonts.nunito(
              color: Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

bool isDesktop() {
  if (kIsWeb) return false;
  return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
}

/// TEST MARKDOWN
/**
 * # Heading One

    Lorem ipsum **bold text** dolor sit amet, _italic text_ consectetur adipiscing elit.

    ## Heading Two

    - Bullet point one
    - Bullet point two
    - Nested bullet point

    1. First item
    2. Second item
    3. Third item

    > This is a blockquote. Lorem ipsum dolor sit amet.

    ```dart
    void main() {
    print('Hello, Markdown!');
    }
    ```

    Here’s a [link to Flutter](https://flutter.dev) and some inline `code` for good measure.

    ---

    ### Heading Three

    | Syntax | Description |
    |--------|-------------|
    | Header | Title        |
    | Paragraph | Text      |

    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. **Pellentesque** habitant morbi _tristique senectus_ et netus.

 */
