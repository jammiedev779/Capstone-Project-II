import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String selectedTab = 'upcoming';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Schedule"),
        backgroundColor: Colors.green,
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
            child: _buildAppointmentDetails(),
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
        backgroundColor: selectedTab == tab ? Colors.green : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
    if (selectedTab == 'upcoming') {
      return _buildAppointmentList();
    } else if (selectedTab == 'complete') {
      return const Center(child: Text('No completed appointments'));
    } else if (selectedTab == 'cancel') {
      return const Center(child: Text('No canceled appointments'));
    }
    return Container();
  }

  Widget _buildAppointmentList() {
    List<Map<String, dynamic>> appointments = [
      {
        'name': 'Dr. Doctor Name',
        'specialty': 'Therapist',
        'date': '12/01/2023',
        'time': '10:30 AM',
        'status': 'Confirmed',
        'avatarUrl': 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1722297600&semt=ais_hybrid',
      },
      // Add more appointments here
    ];

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
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
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(appointment['avatarUrl']),
                    ),
                    const SizedBox(width: 12.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          appointment['specialty'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 4.0),
                        Text(
                          appointment['date'],
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey[600], size: 20),
                        const SizedBox(width: 4.0),
                        Text(
                          appointment['time'],
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 12),
                        const SizedBox(width: 4.0),
                        Text(
                          appointment['status'],
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     OutlinedButton(
                //       onPressed: () {},
                //       style: OutlinedButton.styleFrom(
                //         side: const BorderSide(color: Colors.red),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8.0),
                //         ),
                //       ),
                //       child: const Text(
                //         'Cancel',
                //         style: TextStyle(color: Colors.red),
                //       ),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {},
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.green,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8.0),
                //         ),
                //       ),
                //       child: const Text('Reschedule'),
                //     ),
                //   ],
                // ),

              ],
            ),
          ),
        );
      },
    );
  }
}
