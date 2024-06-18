import 'package:doc_care/screens/home/home_screen.dart';
import 'package:doc_care/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DocCare());
}

class DocCare extends StatelessWidget {
  const DocCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: const AppTheme().themeData);
  }
}
