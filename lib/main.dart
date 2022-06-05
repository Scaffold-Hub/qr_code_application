import 'package:flutter/material.dart';
import 'package:qr_project/screens/introduction_screen.dart';
import 'theme/light_theme.dart';

void main() => runApp(const QrProject());

class QrProject extends StatelessWidget {
  const QrProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme().theme,
      debugShowCheckedModeBanner: false,
      title: 'QR Project',
      home: const IntroductionsScreen(),
    );
  }
}
