import 'package:doc_care/screens/booking_page/booking_screen.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailScreen({required this.doctor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      doctor['profile_picture_url'] ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiO1ABhTbJ30hyaTS5yGuX0cFk_PN51aKV9g&s',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${doctor['first_name']} ${doctor['last_name']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor['specialist_title'] ?? 'Qualifications not available',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor['hospital_name'] ?? 'Hospital not available',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildInfoCard('Patients', doctor['patients_count'] ?? '100', Colors.green),
                      _buildInfoCard('Experiences', doctor['experience_years'] ?? '5 years', Colors.green),
                      _buildInfoCard('Rating', doctor['rating'] ?? '4.2', Colors.green),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Doctor',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor['about'] ?? '${doctor['first_name']} ${doctor['last_name']} is an experienced Specialist ${doctor['specialist_title']} at Cambodia, graduated since 2008, and completed his/her training at Sungai Buloh General Hospital',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About Hospital',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor['hospital_description'] ?? 'Hospital description not available',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.green, // Set the button color to green
              ),
              child: const Text('Book Appointment'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: 100,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}