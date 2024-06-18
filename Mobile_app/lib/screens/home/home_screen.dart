import 'package:flutter/material.dart';
import 'package:mobile_app/components/bottom_navbar.dart';
import 'package:mobile_app/screens/layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
