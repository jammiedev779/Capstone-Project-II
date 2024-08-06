import 'package:doc_care/screens/screens.dart';
import 'package:flutter/material.dart';

class MainNavBar extends StatefulWidget {
  final String token;
  final int patientId;

  const MainNavBar({super.key, required this.token, required this.patientId});

  @override
  _MainNavBarState createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 0;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      HomeView(token: widget.token,patientId: widget.patientId),
      SearchScreen(token: widget.token,patientId: widget.patientId), 
      AppointmentScreen(patientId: widget.patientId),
      ProfileScreen(token: widget.token, patientId: widget.patientId),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToAppointmentSchedule(BuildContext context) {
    Navigator.of(context).pushNamed('/appointment', arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onBackground.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedFontSize: 14,
        selectedLabelStyle: textTheme.bodySmall,
        unselectedLabelStyle: textTheme.bodySmall,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Appointment',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.inbox),
          //   label: 'Inbox',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
