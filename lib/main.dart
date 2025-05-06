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

  runApp(
      ProviderScope(child: const EmbermarkApp()));
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
      backgroundColor: Color(0xFF171C18),
      body:
          belowMinWidth
              ? SmallWidthWarning()
              : SplitView(
                leftChild: Stack(
                  children: [
                    AnimatedPadding(
                      padding: EdgeInsets.only(left: isPinned ? 55.0 : 0),
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.fastOutSlowIn,
                      child: TextField(
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
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: VerticalToolbar(groups: [
                        ToolbarGroup(
                          groupName: 'History',
                          children: [
                            CustomIconButton(icon: HugeIcons.strokeRoundedUndo03),
                            CustomIconButton(icon: HugeIcons.strokeRoundedRedo03),
                          ],
                        ),
                        ToolbarGroup(
                          groupName: 'Title',
                          children: [
                            CustomDropdownButton(),
                          ],
                        ),
                        ToolbarGroup(
                          groupName: 'Style',
                          children: [
                            CustomIconButton(icon: HugeIcons.strokeRoundedTextBold),
                            CustomIconButton(icon: HugeIcons.strokeRoundedTextItalic),
                            CustomIconButton(icon: HugeIcons.strokeRoundedTextUnderline),
                            CustomIconButton(icon: HugeIcons.strokeRoundedTextStrikethrough),
                            CustomIconButton(icon: HugeIcons.strokeRoundedLink04),
                            CustomIconButton(icon: HugeIcons.strokeRoundedSourceCode),
                          ],
                        ),
                        ToolbarGroup(
                          groupName: 'List',
                          children: [
                            CustomIconButton(icon: HugeIcons.strokeRoundedLeftToRightListBullet),
                            CustomIconButton(icon: HugeIcons.strokeRoundedLeftToRightListNumber),
                          ],
                        ),
                      ],),
                    ),
                  ],
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
                      code: TextStyle(color: Colors.white),
                      h1: TextStyle(
                        color: Colors.white.withValues(alpha: 1),
                        height: 1.1,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      h2: TextStyle(color: Colors.white),
                      h3: TextStyle(color: Colors.white),
                      h4: TextStyle(color: Colors.white),
                      h5: TextStyle(color: Colors.white),
                      h6: TextStyle(color: Colors.white),
                      em: TextStyle(color: Colors.white),
                      strong: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      blockquote: TextStyle(color: Colors.white),
                      blockquoteDecoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 4),
                        ),
                        color: Color(0x34FFFFFF)
                      ),
                      img: TextStyle(color: Colors.white),
                      checkbox: TextStyle(color: Colors.white),
                      listBullet: TextStyle(color: Colors.white),
                      horizontalRuleDecoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    controller: _scrollController2,
                  ),
                ),
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
