import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:doc_care/services/hospital_api.dart';
import 'package:flutter/material.dart';

class HospitalListScreen extends StatefulWidget {
  final int patientId;

  const HospitalListScreen({super.key, required this.patientId});

  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  late Future<List<Map<String, dynamic>>> _hospitalFuture;

  @override
  void initState() {
    super.initState();
    _hospitalFuture = HospitalApi.fetchHospitals();
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
                'Hospital',
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _hospitalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hospitals found.'));
          } else {
            final hospitals = snapshot.data!;
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return HospitalCard(
                  hospital: hospital,
                  patientId: widget.patientId, 
                );
              },
            );
          }
        },
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Map<String, dynamic> hospital;
  final int patientId; // Add patientId here

  const HospitalCard({required this.hospital, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetailScreen(
                hospitalId: hospital['id'], // Ensure hospitalId is provided
                patientId: patientId, // Pass patientId here
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: hospital['image'] != null
                  ? Image.network(
                      hospital['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 150,
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
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital['kh_name'] ?? 'Unknown Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        hospital['location'] ?? 'Unknown Location',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(hospital['description'] ?? 'No Description'),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const Icon(Icons.star, size: 16, color: Colors.orange),
                      const Icon(Icons.star, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('1031 Ratings'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 2,
                    color: Color(0xffE5E7EB),
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 16),
                      SizedBox(width: 5),
                      Text(hospital['phone_number'] ?? 'No Phone Number'),
                      Spacer(),
                      Icon(Icons.email, size: 16),
                      SizedBox(width: 5),
                      Text(hospital['email'] ?? 'No Email'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
