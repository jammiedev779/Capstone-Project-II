<<<<<<< HEAD
import 'package:doc_care/screens/login_signup/login_screen.dart';
import 'package:doc_care/screens/login_signup/register_screen.dart';
=======
import 'package:doc_care/screens/login/login_screen.dart';
>>>>>>> 106331db243e753ec3690727ba675c8cb20cf74a
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
<<<<<<< HEAD
      // home: const MainNavBar(),
      home: RegisterPage(),
=======
      home: LoginPage(),
>>>>>>> 106331db243e753ec3690727ba675c8cb20cf74a
      theme: const AppTheme().themeData,
    );
  }
}
