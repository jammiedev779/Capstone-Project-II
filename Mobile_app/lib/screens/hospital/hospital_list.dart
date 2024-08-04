import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:doc_care/services/hospital_api.dart';
import 'package:flutter/material.dart';
import 'package:doc_care/screens/hospital/hospital_detail.dart';



class HospitalListScreen extends StatefulWidget {
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
      appBar: AppBar(
        title: Text('Hospitals'),
        centerTitle: true,
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
                return HospitalCard(hospital: hospital);
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

  const HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HospitalDetailScreen(hospital: hospital),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: hospital['url'] != null
                  ? Image.network(
                      hospital['url'],
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
                  Text(hospital['location'] ?? 'Unknown Location'),
                  SizedBox(height: 5),
                  Text(hospital['description'] ?? 'No Description'),
                  SizedBox(height: 5),
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

