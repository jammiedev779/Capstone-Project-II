// main.dart
import 'package:flutter/material.dart';
import 'package:mobile_app/components/bottom_navbar.dart';
import 'package:mobile_app/pages/calendar/calendar_page.dart';
import 'package:mobile_app/pages/home/home_page.dart';
import 'package:mobile_app/pages/message/message_page.dart';
import 'package:mobile_app/pages/profile/profile_page.dart';
import 'package:mobile_app/pages/search/search_page.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    CalendarPage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavbar(
        widgetOptions: _widgetOptions,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
