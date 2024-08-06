import 'package:doc_care/screens/appointment/appointment_screen.dart';
import 'package:doc_care/screens/favorite_hospital/favorite_hospitals_screen.dart';
import 'package:doc_care/screens/favorite_doctor/favorite_doctors_screen.dart';
import 'package:doc_care/screens/login_&_register/login_screen.dart';
import 'package:doc_care/screens/profile/edit_profile.dart';
import 'package:doc_care/screens/profile/medical_history.dart';
import 'package:doc_care/screens/profile/widget_style.dart';
import 'package:doc_care/services/patient_api.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String token;
  final int patientId;

  const ProfileScreen(
      {super.key, required this.token, required this.patientId});

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

  Future<void> _refreshProfile() async {
    setState(() {
      futureProfile = ApiService.fetchProfile(widget.token);
    });
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4),
                  blurRadius: 6.0,
                  spreadRadius: 1.0),
            ],
            gradient: LinearGradient(
              colors: [Color(0xFF2d595a)!, Color(0xFF65a399)!],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
        ),
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
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
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
                                    '${profile['image']}'),
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
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 24, 22, 22)),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    final updated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileScreen(
                                          token: widget.token,
                                          profileData: profile,
                                          onUpdate: (newProfileData) {
                                            setState(() {
                                              futureProfile =
                                                  Future.value(newProfileData);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                    if (updated) {
                                      await _refreshProfile();
                                    }
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
                              WidgetStyle().buildCircleIcon(
                                  paddingValue: 8.0,
                                  backgroundColor: Color(0xFF4F7E76),
                                  iconData: Icons.transgender_outlined,
                                  iconColor: Color.fromARGB(255, 255, 255, 255),
                                  iconSize: 16.0),
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
                              WidgetStyle().buildCircleIcon(
                                  paddingValue: 8.0,
                                  backgroundColor: Color(0xFF4F7E76),
                                  iconData: Icons.phone,
                                  iconColor: Colors.white,
                                  iconSize: 16.0),
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
                              WidgetStyle().buildCircleIcon(
                                  paddingValue: 8.0,
                                  backgroundColor: Color(0xFF4F7E76),
                                  iconData: Icons.email,
                                  iconColor: Colors.white,
                                  iconSize: 16.0),
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
                              WidgetStyle().buildCircleIcon(
                                  paddingValue: 8.0,
                                  backgroundColor: Color(0xFF4F7E76),
                                  iconData: Icons.location_on,
                                  iconColor: Colors.white,
                                  iconSize: 16.0),
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
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading:
                                  const Icon(Icons.history, color: Color(0xFFFF6961)),
                              title: const Text('Medical History'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicalHistoryScreen(patientId: widget.patientId),
                                  ),
                                );
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color(0x0F292626),
                              widthValue: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.bookmark_add,
                                  color: Color(0xFF6FC276)),
                              title: const Text('Appointment'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentScreen(
                                        patientId: widget.patientId),
                                    settings:
                                        const RouteSettings(arguments: true),
                                  ),
                                );
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color(0x0F292626),
                              widthValue: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.person_4,
                                  color: Color(0xFFFFA756)),
                              title: const Text('Favorite Doctor'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FavoriteDoctorsScreen(
                                        token: widget.token,
                                        patientId: widget.patientId),
                                  ),
                                );
                              },
                            ),
                          ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color(0x0F292626),
                              widthValue: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.local_hospital,
                                  color: Color(0xFF6488EA)),
                              title: const Text('Favorite Hospital'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FavoriteHospitalScreen(
                                        patientId: widget.patientId),
                                  ),
                                );
                              },
                            ),
                          ),
                          // WidgetStyle().buildBottomBorder(
                          //     horizontalValue: 24.0,
                          //     colorValue: Color(0x0F292626),
                          //     widthValue: 2.0),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: ListTile(
                          //     leading: const Icon(Icons.settings,
                          //         color: Color(0xF8817676)),
                          //     title: const Text('Settings'),
                          //     onTap: () {
                          //       // Navigate to Settings
                          //     },
                          //   ),
                          // ),
                          WidgetStyle().buildBottomBorder(
                              horizontalValue: 24.0,
                              colorValue: Color(0x0F292626),
                              widthValue: 2.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(Icons.logout_outlined,
                                  color: Color(0xFFFF6961)),
                              title: const Text('Log out',
                                  style: TextStyle(color: Color(0xFFFF6961))),
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
