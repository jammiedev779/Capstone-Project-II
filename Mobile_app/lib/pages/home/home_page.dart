import 'package:flutter/material.dart';
import 'package:mobile_app/components/bottom_navbar.dart';
import 'package:mobile_app/pages/layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DocCare"),
        centerTitle: true,
      ),
      body: Text('HomePage'),
    );
  }
}
