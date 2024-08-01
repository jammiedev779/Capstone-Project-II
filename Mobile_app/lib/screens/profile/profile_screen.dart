// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doc_care/screens/login_&_register/login_screen.dart';
import 'package:doc_care/screens/profile/edit_profile.dart';
import 'package:doc_care/screens/profile/widget_style.dart';
import 'package:doc_care/services/patient_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';


class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({super.key, required this.token});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = ApiService.fetchProfile(widget.token);
  }

  void _logout() async {
    final response = await ApiService.logout(widget.token);
    if (response['status'] == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${response['message']}')),
      );
    }
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                _showLoadingDialog();
                await Future.delayed(const Duration(seconds: 2));
                _logout();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                const Text('Logging out...'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile',
        style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No profile data found.'));
          } else {
            final profile = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                               
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://i.pinimg.com/736x/83/1f/01/831f015888b5a0cd588e89b865ed12d0.jpg'),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile['name'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${profile['age']} years old',
                                    style: const TextStyle(color: Color.fromARGB(255, 24, 22, 22)),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(token: 'widget.token'),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            height: 0.3,
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              WidgetStyle().buildCircleIcon(paddingValue: 8.0, backgroundColor: Color.fromRGBO(77, 139, 201, 1), iconData: Icons.transgender_outlined, iconColor: Colors.white, iconSize: 16.0),
                              const SizedBox(width: 8),
                              const Text('Gender'),
                              Spacer(),
                              Text(
                                profile['gender'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              WidgetStyle().buildCircleIcon(paddingValue: 8.0, backgroundColor: Color.fromRGBO(77, 139, 201, 1), iconData: Icons.phone, iconColor: Colors.white, iconSize: 16.0),
                              const SizedBox(width: 8),
                              const Text('Phone'),
                              Spacer(),
                              Text(
                                profile['phone_number'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              WidgetStyle().buildCircleIcon(paddingValue: 8.0, backgroundColor: Color.fromRGBO(77, 139, 201, 1), iconData: Icons.email, iconColor: Colors.white, iconSize: 16.0),
                              const SizedBox(width: 8),
                              const Text('Email'),
                              Spacer(),
                              Text(
                                profile['email'] ?? 'N/A',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          Row(
                            children: [
                              WidgetStyle().buildCircleIcon(paddingValue: 8.0, backgroundColor: Color.fromRGBO(77, 139, 201, 1), iconData: Icons.location_on, iconColor: Colors.white, iconSize: 16.0),
                              const SizedBox(width: 8),
                              const Text('Address'),
                              Spacer(),
                              Expanded(
                                child: Text(
                                  profile['address'] ?? 'N/A',
                                  style: const TextStyle(color: Colors.black),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  
                    // Menu Options
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.favorite, color: Colors.red),
                              title: const Text('Medical History'),
                              onTap: () {
                                // Navigate to Your Favorites
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color.fromARGB(15, 41, 38, 38),
                              widthValue: 2.0),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.bookmark_add, color: Color.fromARGB(255, 53, 138, 56)),
                              title: const Text('Appointment'),
                              onTap: () {
                                // Navigate to Paymentx`
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color.fromARGB(15, 41, 38, 38),
                              widthValue: 2.0),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.person_4, color: Color.fromARGB(255, 80, 131, 156)),
                              title: const Text('Favorite Doctor'),
                              onTap: () {
                                // Navigate to Paymentx`
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color.fromARGB(15, 41, 38, 38),
                              widthValue: 2.0),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.maps_home_work, color:Color.fromARGB(255, 138, 84, 22)),
                              title: const Text('Favorite Hospital'),
                              onTap: () {
                                // Navigate to Paymentx`
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color.fromARGB(15, 41, 38, 38),
                              widthValue: 2.0),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.settings, color: Color.fromARGB(248, 108, 104, 104)),
                              title: const Text('Settings'),
                              onTap: () {
                                // Navigate to Settings
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color.fromARGB(15, 41, 38, 38),
                              widthValue: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.logout_outlined, color: Color.fromARGB(255, 167, 18, 18)),
                              title: const Text('Log out',
                                  style: TextStyle(color: Colors.red)),
                              onTap: _showLogoutConfirmationDialog,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  
}
