import 'package:doc_care/services/appointment_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppointmentScreen extends StatefulWidget {
  final int patientId;
  const AppointmentScreen({super.key, required this.patientId});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String selectedTab = 'upcoming';
  List<Map<String, dynamic>> appointments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final data = await AppointmentApi.fetchAppointments(widget.patientId);
      setState(() {
        appointments = List<Map<String, dynamic>>.from(data['appointments']);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching appointments: $e');
    }
  }

  Future<void> cancelAppointment(int appointmentId) async {
    try {
      await AppointmentApi.cancelAppointment(appointmentId);
      fetchAppointments(); 
    } catch (e) {
      print('Error cancelling appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel appointment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showBackButton =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;

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
                    spreadRadius: 1.0),
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
              leading: showBackButton
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : null,
              title: Text(
                'Appointment Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green[50],
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('upcoming', 'Upcoming'),
                _buildTabButton('complete', 'Completed'),
                _buildTabButton('cancel', 'Canceled'),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildAppointmentDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String tab, String label) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedTab = tab;
        });
      },
      style: TextButton.styleFrom(
        backgroundColor:
            selectedTab == tab ? Color(0xFF4F7E76) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedTab == tab ? Colors.white : Colors.black,
          fontWeight: selectedTab == tab ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    List<Map<String, dynamic>> filteredAppointments =
        appointments.where((appointment) {
      if (selectedTab == 'upcoming') {
        return appointment['status'] == 'Pending' ||
            appointment['status'] == 'Ongoing';
      } else if (selectedTab == 'complete') {
        return appointment['status'] == 'Completed';
      } else if (selectedTab == 'cancel') {
        return appointment['status'] == 'Canceled';
      }
      return false;
    }).toList();

    if (filteredAppointments.isEmpty) {
      return Center(child: Text('No ${selectedTab} appointments'));
    }

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            appointment['doctor_avatar'] ??
                                'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1722297600&semt=ais_hybrid',
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment['doctor_name'] ?? 'Unknown Doctor',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              appointment['specialist_title'] ??
                                  'Unknown Specialty',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (selectedTab == 'upcoming')
                      Positioned(
                        right: 0,
                        top: 0,
                        child: TextButton(
                          onPressed: () =>
                              _showCancelConfirmationDialog(appointment['id']),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Colors.grey[600], size: 20),
                        const SizedBox(width: 4.0),
                        Text(
                          appointment['appointment_date'] ?? 'Unknown Date',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: appointment['status'] == 'Pending'
                              ? Colors.orange
                              : appointment['status'] == 'Ongoing'
                                  ? Colors.blue
                                  : appointment['status'] == 'Completed'
                                      ? Colors.green
                                      : appointment['status'] == 'Canceled'
                                          ? Colors.red
                                          : Colors.grey,
                          size: 12,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          appointment['status'] ?? 'Unknown Status',
                          style: TextStyle(
                            color: appointment['status'] == 'Pending'
                                ? Colors.orange
                                : appointment['status'] == 'Ongoing'
                                    ? Colors.blue
                                    : appointment['status'] == 'Completed'
                                        ? Colors.green
                                        : appointment['status'] == 'Canceled'
                                            ? Colors.red
                                            : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showCancelConfirmationDialog(int appointmentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content:
              const Text('Are you sure you want to cancel this appointment?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                cancelAppointment(appointmentId);
              },
            ),
          ],
        );
      },
    );
  }
}
