import 'package:flutter/material.dart';

class NearbyMedicalCentersScreen extends StatelessWidget {
  final List<MedicalCenter> medicalCenters = [
    MedicalCenter(
      imageUrl:
          'https://via.placeholder.com/150', // replace with actual image URL
      name: 'Sunrise Health Clinic',
      address: '123 Oak Street, CA 98765',
      rating: 5.0,
      reviewsCount: 58,
      distance: 2.5,
      time: 40,
      type: 'Hospital',
    ),
    MedicalCenter(
      imageUrl:
          'https://via.placeholder.com/150', // replace with actual image URL
      name: 'Golden Cardiology Center',
      address: '555 Bridge Street, Golden City',
      rating: 4.9,
      reviewsCount: 108,
      distance: 2.5,
      time: 40,
      type: 'Cardiology',
    ),
    // Add more MedicalCenter objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0, // Set the height to fit your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: medicalCenters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MedicalCenterCard(
              medicalCenter: medicalCenters[index],
            ),
          );
        },
      ),
    );
  }
}

class MedicalCenter {
  final String imageUrl;
  final String name;
  final String address;
  final double rating;
  final int reviewsCount;
  final double distance;
  final int time;
  final String type;

  MedicalCenter({
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.distance,
    required this.time,
    required this.type,
  });
}

class MedicalCenterCard extends StatelessWidget {
  final MedicalCenter medicalCenter;

  const MedicalCenterCard({
    required this.medicalCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Container(
          width: 250.0, // Set a fixed width for horizontal cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.network(
                  medicalCenter.imageUrl,
                  height: 150.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicalCenter.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      medicalCenter.address,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16.0),
                        SizedBox(width: 4.0),
                        Text(
                          '${medicalCenter.rating}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4.0),
                        Text('(${medicalCenter.reviewsCount} Reviews)'),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.directions_walk, size: 16.0),
                        SizedBox(width: 4.0),
                        Text(
                            '${medicalCenter.distance} km/${medicalCenter.time} min'),
                        SizedBox(width: 16.0),
                        Icon(Icons.local_hospital, size: 16.0),
                        SizedBox(width: 4.0),
                        Text(medicalCenter.type),
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
