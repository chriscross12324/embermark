import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:embermark/widgets/action_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_acrylic/window.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();

  runApp(const AmbermarkApp());
  if (Platform.isMacOS) {
    doWhenWindowReady(() {
      appWindow.minSize = Size(640, 360);
    });
  }
}

class AmbermarkApp extends StatelessWidget {
  const AmbermarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Color(0xFFFFFFFF),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => HomeScreen());
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFF363636), body: Center(child: ActionToolbar()));
  }
}
