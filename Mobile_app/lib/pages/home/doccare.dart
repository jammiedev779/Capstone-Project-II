import 'package:flutter/material.dart';
import 'package:mobile_app/pages/layout.dart';
// import 'package:mobile_app/pages/login_signup/login_page.dart';

class DocCare extends StatelessWidget {
  const DocCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutPage(),
    );
  }
}
