import 'package:flutter/material.dart';
import 'package:doc_care/services/hospital_api.dart';
import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:doc_care/screens/hospital/hospital_list.dart'; 

class NearbyMedicalCentersScreen extends StatefulWidget {
  final int patientId; 

  const NearbyMedicalCentersScreen({super.key, required this.patientId});

  @override
  _NearbyMedicalCentersScreenState createState() =>
      _NearbyMedicalCentersScreenState();
}

class _NearbyMedicalCentersScreenState
    extends State<NearbyMedicalCentersScreen> {
  late Future<List<Map<String, dynamic>>> _hospitalFuture;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _hospitalFuture = HospitalApi.fetchHospitals();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
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
                        patientId: widget.patientId, 
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
                  return Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: hospitals.length,
                        itemBuilder: (context, index) {
                          final hospital = hospitals[index];
                          return Container(
                            width: 350.0,
                            margin: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: HospitalCard(
                              hospital: hospital,
                              patientId: widget.patientId, 
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ],
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
  final int patientId;

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
                  hospitalId: hospital['id'],
                  patientId: patientId,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  hospital['image'] ??
                      'https://teacarchitect.com/wp-content/uploads/2021/09/Royal-Phnom-Penh-Hospital.jpg',
                  height: 220,
                  width: 350,
                  fit: BoxFit.cover,
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
