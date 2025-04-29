import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:embermark/widgets/action_toolbar.dart';
import 'package:embermark/widgets/split_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDesktop()) {
    await Window.initialize();
  }

  runApp(const EmbermarkApp());
  if (isDesktop()) {
    doWhenWindowReady(() {
      appWindow.minSize = Size(640, 360);
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String inputString = "";
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    final belowMinWidth = MediaQuery.of(context).size.width < 640;

    return Scaffold(
      backgroundColor: Color(0xFF363636),
      body:
          belowMinWidth
              ? SmallWidthWarning()
              : SplitView(
                leftChild: Stack(
                  children: [
                    TextField(
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
                      scrollController: _scrollController,
                      controller: _textEditingController,
                      onChanged: (newString) {
                        setState(() {
                          inputString = newString;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: ActionToolbar(pageNum: pageNum),
                        /*AdaptiveToolbar(
                          groups: [
                            ToolbarGroup(
                              weight: 10,
                              isCollapsed: true,
                              groupID: 'undoredo1',
                              children: [
                                CustomIconButton(icon: HugeIcons.strokeRoundedUndo03),
                                CustomIconButton(icon: HugeIcons.strokeRoundedRedo03),
                              ],
                            ),
                            ToolbarGroup(
                              weight: 9,
                              isCollapsed: true,
                              groupID: 'type',
                              children: [
                                CustomDropdownButton(),
                              ],
                            ),
                            ToolbarGroup(
                              weight: 8,
                              isCollapsed: true,
                              groupID: 'styling',
                              children: [
                                CustomIconButton(icon: HugeIcons.strokeRoundedTextBold),
                                CustomIconButton(icon: HugeIcons.strokeRoundedTextItalic),
                                CustomIconButton(icon: HugeIcons.strokeRoundedTextUnderline),
                                CustomIconButton(icon: HugeIcons.strokeRoundedTextStrikethrough),
                              ],
                            ),
                          ],
                        ),*/
                      ),
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
                      p: TextStyle(color: Colors.white),
                      code: TextStyle(color: Colors.white),
                      h1: TextStyle(color: Colors.white),
                      h2: TextStyle(color: Colors.white),
                      h3: TextStyle(color: Colors.white),
                      h4: TextStyle(color: Colors.white),
                      h5: TextStyle(color: Colors.white),
                      h6: TextStyle(color: Colors.white),
                      em: TextStyle(color: Colors.white),
                      strong: TextStyle(color: Colors.white),
                      blockquote: TextStyle(color: Colors.white),
                      img: TextStyle(color: Colors.white),
                      checkbox: TextStyle(color: Colors.white),
                      listBullet: TextStyle(color: Colors.white),
                    ),
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
