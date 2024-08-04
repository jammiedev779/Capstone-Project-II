import 'dart:convert';
import 'package:doc_care/screens/booking_page/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DoctorDetailScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;
  final int patientId;  

  const DoctorDetailScreen({required this.doctor, required this.patientId, Key? key}) : super(key: key);

  @override
  _DoctorDetailScreenState createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final String apiUrl = 'http://10.0.2.2:8002/api/favorites/check/${widget.patientId}';
    
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _isFavorite = responseBody['is_favorite'] ?? false;
        });
      } else {
        print('Failed to check favorite status: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while checking favorite status: $e');
    }
  }

  Future<void> _toggleFavoriteStatus() async {
    final String apiUrl = _isFavorite
        ? 'http://10.0.2.2:8002/api/favorites/remove/${widget.patientId}'
        : 'http://10.0.2.2:8002/api/favorites/add/${widget.patientId}';
    
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'doctor_id': widget.doctor['id']}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          _isFavorite = !_isFavorite;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            _isFavorite ? 'Doctor added to favorites!' : 'Doctor removed from favorites!',
          )),
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text(_isFavorite
                  ? 'Doctor has been added to your favorites.'
                  : 'Doctor has been removed from your favorites.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to update favorite status: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favorite status.')),
        );
      }
    } catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color appBarColor = Color(0xFF245252);

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
                spreadRadius: 1.0,
              ),
            ],
            gradient: LinearGradient(
              colors: [appBarColor, Color(0xFF67A59B)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Doctor Details',
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
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      _toggleFavoriteStatus();
                    },
                  ),
                ),
              ),
            ],
          ),
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
                      widget.doctor['profile_picture_url'] ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiO1ABhTbJ30hyaTS5yGuX0cFk_PN51aKV9g&s',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${widget.doctor['first_name']} ${widget.doctor['last_name']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.doctor['specialist_title'] ?? 'Qualifications not available',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.doctor['hospital_name'] ?? 'Hospital not available',
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
                      _buildInfoCard('Patients', widget.doctor['patients_count']?.toString() ?? '100', appBarColor),
                      _buildInfoCard('Experiences', widget.doctor['experience_years']?.toString() ?? '5 years', appBarColor),
                      _buildInfoCard('Rating', widget.doctor['rating']?.toString() ?? '4.2', appBarColor),
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
                    widget.doctor['about'] ?? '${widget.doctor['first_name']} ${widget.doctor['last_name']} is an experienced Specialist ${widget.doctor['specialist_title']} at Cambodia, graduated since 2008, and completed his/her training at Sungai Buloh General Hospital',
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
                    widget.doctor['hospital_description'] ?? 'Hospital description not available',
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
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(
                      doctorId: widget.doctor['id'],
                      patientId: widget.patientId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: appBarColor, // Match the AppBar color
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
