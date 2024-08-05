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
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
            ),
          ),
        ),
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
                            Text(
                                "Phone: ${hospital['phone_number'] ?? 'No Phone Number'}"),
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
                          hospital['visiting_hours'] ??
                              'No Visiting Hours Provided',
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
