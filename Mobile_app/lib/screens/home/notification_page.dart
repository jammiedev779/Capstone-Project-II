// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doc_care/screens/profile/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.25),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 6.0,
                spreadRadius: 1.0
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xFF245252),
                Color(0xFF67A59B),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Notification',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Read All',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Container(
          child: ListView(
            children: [
              ListTile(
                leading: WidgetStyle().buildCircleIcon(
                    paddingValue: 6.0,
                    backgroundColor: Color(0xEB5ACE7D),
                    iconData: Icons.add_alert_sharp,
                    iconColor: Color.fromARGB(255, 255, 255, 255),
                    iconSize: 36.0),
                title: Text(
                  'Doctor Approved the Appointent on 20 Jul 2024 at 10:00 AM',
                  style: TextStyle(fontSize: 14.0),
                ),
                subtitle: Text(
                  '01 Aug 2024 | 02:30 PM',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF787474)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
