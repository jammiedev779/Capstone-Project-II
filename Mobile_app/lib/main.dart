import 'package:doc_care/screens/login_signup/login_screen.dart';
import 'package:doc_care/screens/login_signup/register_screen.dart';
import 'package:doc_care/shared/theme/app_theme.dart';
import 'package:doc_care/shared/utils/bottom_nav_bars/main_nav_bar.dart';
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
      // home: const MainNavBar(),
      home: RegisterPage(),
      theme: const AppTheme().themeData,
    );
  }
}
