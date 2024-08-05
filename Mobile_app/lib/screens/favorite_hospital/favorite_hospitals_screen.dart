import 'package:flutter/material.dart';
import 'package:doc_care/services/favorite_hospital_api.dart';

class FavoriteHospitalScreen extends StatefulWidget {
  final int patientId;

  const FavoriteHospitalScreen({required this.patientId, Key? key})
      : super(key: key);

  @override
  _FavoriteHospitalScreenState createState() => _FavoriteHospitalScreenState();
}

class _FavoriteHospitalScreenState extends State<FavoriteHospitalScreen> {
  List<Map<String, dynamic>> _favoriteHospitals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteHospitals();
  }

  Future<void> _fetchFavoriteHospitals() async {
    try {
      final favoriteHospitals = await FavoriteHospitalApi.getFavoriteHospitals(widget.patientId);
      print('Fetched favorite hospitals: $favoriteHospitals'); // Debugging
      setState(() {
        _favoriteHospitals = favoriteHospitals;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching favorite hospitals: $e'); // Debugging
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to load favorite hospitals.');
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
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Favorite Hospitals'),
        centerTitle: true,
        backgroundColor: appBarColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _favoriteHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _favoriteHospitals[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            hospital['image'] ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiO1ABhTbJ30hyaTS5yGuX0cFk_PN51aKV9g&s',
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hospital['kh_name'] ?? 'Hospital Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                hospital['description'] ?? 'Description not available',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    hospital['location'] ?? 'Location not available',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.orange),
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text('1031 Ratings'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Implement action when pressing the favorite icon
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
