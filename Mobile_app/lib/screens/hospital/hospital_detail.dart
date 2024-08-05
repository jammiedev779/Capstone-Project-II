import 'package:flutter/material.dart';
import 'package:doc_care/services/hospital_api.dart';

class HospitalDetailScreen extends StatefulWidget {
  final int hospitalId;

  HospitalDetailScreen({required this.hospitalId});

  @override
  _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  late Future<Map<String, dynamic>> _hospitalFuture;

  @override
  void initState() {
    super.initState();
    print('Fetching hospital details for ID: ${widget.hospitalId}');
    _hospitalFuture = HospitalApi.fetchHospitalDetails(widget.hospitalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: _hospitalFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (!snapshot.hasData) {
              return Text('No Data');
            } else {
              final hospital = snapshot.data!;
              return Text(
                hospital['kh_name'] ?? 'Unknown Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _hospitalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found.'));
          } else {
            final hospital = snapshot.data!;
            print('Hospital details fetched successfully: $hospital');
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      hospital['image'] != null
                          ? Image.network(
                              hospital['image'],
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 250,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Center(
                                child: Text(
                                  'No Image Available',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                      Positioned(
                        top: 40,
                        left: 10,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "About the Hospital",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          hospital['description'] ?? 'No Description',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Contact Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("Phone: ${hospital['phone_number'] ?? 'No Phone Number'}"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.grey),
                            SizedBox(width: 5),
                            Text("Email: ${hospital['email'] ?? 'No Email'}"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            SizedBox(width: 5),
                            Text(hospital['location'] ?? 'Unknown Location'),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Services",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          (hospital['services'] as List<dynamic>?)
                                  ?.join(", ") ??
                              'No Services',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Visiting Hours",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          hospital['visiting_hours'] ?? 'No Visiting Hours Provided',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
