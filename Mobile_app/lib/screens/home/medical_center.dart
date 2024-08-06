import 'package:flutter/material.dart';
import 'package:doc_care/services/hospital_api.dart';
import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:doc_care/screens/hospital/hospital_list.dart'; // Ensure this import is correct

class NearbyMedicalCentersScreen extends StatefulWidget {
  final int patientId; // Add patientId as a parameter

  const NearbyMedicalCentersScreen({super.key, required this.patientId});

  @override
  _NearbyMedicalCentersScreenState createState() =>
      _NearbyMedicalCentersScreenState();
}

class _NearbyMedicalCentersScreenState
    extends State<NearbyMedicalCentersScreen> {
  late Future<List<Map<String, dynamic>>> _hospitalFuture;

  @override
  void initState() {
    super.initState();
    _hospitalFuture = HospitalApi.fetchHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Medical Centers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalListScreen(
                        patientId: widget.patientId, // Pass patientId here
                      ),
                    ),
                  );
                },
                child:
                    Text('See All', style: TextStyle(color: Color(0xff6B7280))),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _hospitalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('No nearby medical centers found.'));
                } else {
                  final hospitals = snapshot.data!;
                  return PageView.builder(
                    controller: PageController(viewportFraction: 1),
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = hospitals[index];
                      return Container(
                        width: 350.0,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: HospitalCard(
                          hospital: hospital,
                          patientId: widget.patientId, // Pass patientId here
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Map<String, dynamic> hospital;
  final int patientId; // Add patientId as a parameter

  const HospitalCard({
    required this.hospital,
    required this.patientId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 800.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
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
                        height: 140.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 140.0,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            hospital['location'] ?? 'Unknown Location',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      hospital['description'] ?? 'No Description',
                      maxLines: 3,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        Icon(Icons.star, size: 16, color: Colors.orange),
                        Icon(Icons.star, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('1031 Ratings'),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Color(0xffE5E7EB),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.phone, size: 16),
                    //     SizedBox(width: 5),
                    //     Text(
                    //       hospital['phone_number'] ?? 'No Phone Number',
                    //     ),
                    //     Spacer(),
                    //     Icon(Icons.email, size: 16),
                    //     SizedBox(width: 5),
                    //     Expanded(
                    //       child: Text(
                    //         hospital['email'] ?? 'No Email',
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}