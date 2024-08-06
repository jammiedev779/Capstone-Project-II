import 'package:doc_care/screens/hospital/hospital_detail.dart';
import 'package:flutter/material.dart';
import 'package:doc_care/services/favorite_hospital_api.dart';


class FavoriteHospitalScreen extends StatefulWidget {
  final int patientId;

  const FavoriteHospitalScreen({super.key, required this.patientId});

  @override
  _FavoriteHospitalScreenState createState() => _FavoriteHospitalScreenState();
}

class _FavoriteHospitalScreenState extends State<FavoriteHospitalScreen> {
  late Future<List<Map<String, dynamic>>> _favoriteHospitalFuture;

  @override
  void initState() {
    super.initState();
    // Replace fetchHospitals with your API method to fetch favorite hospitals
    _favoriteHospitalFuture = FavoriteHospitalApi.getFavoriteHospitals(widget.patientId);
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
                'Favorite Hospitals',
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
        future: _favoriteHospitalFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite hospitals found.'));
          } else {
            final hospitals = snapshot.data!;
            return ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return FavoriteHospitalCard(
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


class FavoriteHospitalCard extends StatelessWidget {
  final Map<String, dynamic> hospital;
  final int patientId;

  const FavoriteHospitalCard({required this.hospital, required this.patientId});

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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hospital['kh_name'] ?? 'Unknown Name',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 24,
                      ),
                    ],
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
