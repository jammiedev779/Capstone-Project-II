import 'package:flutter/material.dart';
// import 'package:mobile_app/pages/home/home_page.dart';

class BottomNavbar extends StatefulWidget {
  int selectedIndex;
  List<Widget> widgetOptions;
  BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.widgetOptions,
  });
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.widgetOptions.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile.png'), 
              radius: 12,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
