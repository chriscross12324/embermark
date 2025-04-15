import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:embermark/widgets/action_toolbar.dart';
import 'package:embermark/widgets/split_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_acrylic/window.dart';
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
    return WidgetsApp(
      debugShowCheckedModeBanner: false,
      color: Color(0xFFFFFFFF),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => HomeScreen());
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    Center(
                      child: Text(
                        'Working Pane',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: ActionToolbar(pageNum: pageNum),
                      ),
                    ),
                  ],
                ),
                rightChild: Center(
                  child: Text(
                    'Preview Pane',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
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
          HugeIcon(icon: HugeIcons.strokeRoundedArrowHorizontal, color: Colors.white, size: 128,),
          Text(
            'Window Too Small',
            style: GoogleFonts.nunito(
                color: Colors.white.withValues(alpha: 0.75),
                fontWeight: FontWeight.bold,
                fontSize: 36
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'This layout needs more space. Please resize the window to continue.',
            style: GoogleFonts.nunito(
              color: Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
              fontSize: 16
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
