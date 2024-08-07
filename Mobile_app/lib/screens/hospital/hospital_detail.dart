import 'package:doc_care/services/favorite_hospital_api.dart';
import 'package:flutter/material.dart';
import 'package:doc_care/services/hospital_api.dart';

class HospitalDetailScreen extends StatefulWidget {
  final int hospitalId;
  final int patientId;

  HospitalDetailScreen({required this.hospitalId, required this.patientId});

  @override
  _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  late Future<Map<String, dynamic>> _hospitalFuture;
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _hospitalFuture = HospitalApi.fetchHospitalDetails(widget.hospitalId);
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      final isFavorite = await FavoriteHospitalApi.isFavorite(
          widget.patientId, widget.hospitalId);
      setState(() {
        _isFavorite = isFavorite;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // _showErrorDialog('Failed to load favorite status.');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      setState(() {
        _isFavorite = !_isFavorite;
        _isLoading = true;
      });

      if (_isFavorite) {
        await FavoriteHospitalApi.addFavorite(
            widget.patientId, widget.hospitalId);
      } else {
        await FavoriteHospitalApi.removeFavorite(
            widget.patientId, widget.hospitalId);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
  
        _isFavorite = !_isFavorite;
      });
      // _showErrorDialog('Failed to update favorite status.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            centerTitle: true,
            title: FutureBuilder<Map<String, dynamic>>(
              future: _hospitalFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...', style: TextStyle(color: Colors.white));
                } else if (snapshot.hasError) {
                  return Text('Error', style: TextStyle(color: Colors.white));
                } else if (!snapshot.hasData) {
                  return Text('No Data', style: TextStyle(color: Colors.white));
                } else {
                  final hospital = snapshot.data!;
                  return Text(
                    hospital['kh_name'] ?? 'Unknown Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: _isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ),
            ],
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        hospital['image'] ??
                            'https://teacarchitect.com/wp-content/uploads/2021/09/Royal-Phnom-Penh-Hospital.jpg',
                        fit: BoxFit.cover,
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
