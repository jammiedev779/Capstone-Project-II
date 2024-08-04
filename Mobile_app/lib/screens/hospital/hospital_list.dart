import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:flutter/material.dart';

class HospitalListScreen extends StatelessWidget {
  final List<Hospital> hospitals = [
    Hospital(
      name: "Sunrise Health Clinic",
      address: "123 Oak Street, CA 98765",
      rating: 5.0,
      reviews: 128,
      distance: "2.5 km/40min",
      type: "Hospital",
      imagePath: "assets/images/hospital/sunrise_health_clinic.jpg",
    ),
    Hospital(
      name: "Golden Cardiology Center",
      address: "555 Bridge Street, Golden Gate",
      rating: 4.9,
      reviews: 58,
      distance: "2.5 km/40min",
      type: "Clinic",
      imagePath: "assets/images/hospital/golden_cardiology_center.jpg",
    ),
    Hospital(
      name: "Orthopedic Surgery Center",
      address: "555 Bridge Street, Golden Gate",
      rating: 4.9,
      reviews: 48,
      distance: "2.5 km/40min",
      type: "Clinic",
      imagePath: "assets/images/hospital/orthopedic_surgery_center.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return HospitalCard(hospital: hospital);
        },
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Handle tap event
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetailScreen(hospital: hospital),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                hospital.imagePath,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(hospital.address),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        '${hospital.rating} ★',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text('(${hospital.reviews} Reviews)'),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.directions_walk, size: 16),
                      SizedBox(width: 5),
                      Text(hospital.distance),
                      Spacer(),
                      Icon(Icons.local_hospital, size: 16),
                      SizedBox(width: 5),
                      Text(hospital.type),
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

class Hospital {
  final String name;
  final String address;
  final double rating;
  final int reviews;
  final String distance;
  final String type;
  final String imagePath;

  Hospital({
    required this.name,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.type,
    required this.imagePath,
  });
}
