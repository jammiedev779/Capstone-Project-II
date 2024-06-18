import 'package:flutter/material.dart';
import 'package:mobile_app/themes/themes.dart';

import 'screens/layout.dart';

void main() {
  runApp(const DocCare());
}

class DocCare extends StatelessWidget {
  const DocCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutPage(),
      theme: lightMode,
    );
  }
}
