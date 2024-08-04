import 'package:doc_care/screens/doctor/doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:doc_care/services/favorite_doctor_api.dart';

class FavoriteDoctorsScreen extends StatefulWidget {
  final int patientId;

  const FavoriteDoctorsScreen({required this.patientId, Key? key}) : super(key: key);

  @override
  _FavoriteDoctorsScreenState createState() => _FavoriteDoctorsScreenState();
}

class _FavoriteDoctorsScreenState extends State<FavoriteDoctorsScreen> {
  List<Map<String, dynamic>> _favoriteDoctors = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteDoctors();
  }

  Future<void> _fetchFavoriteDoctors() async {
    try {
      final favoriteDoctors = await FavoriteDoctorApi.getFavoriteDoctors(widget.patientId);
      setState(() {
        _favoriteDoctors = favoriteDoctors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('Failed to load favorite doctors.');
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
        title: Text('Favorite Doctors'),
        backgroundColor: appBarColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _favoriteDoctors.length,
              itemBuilder: (context, index) {
                final doctor = _favoriteDoctors[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      doctor['profile_picture_url'] ??
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiO1ABhTbJ30hyaTS5yGuX0cFk_PN51aKV9g&s',
                    ),
                  ),
                  title: Text('${doctor['first_name']} ${doctor['last_name']}'),
                  subtitle: Text(doctor['specialist_title'] ?? 'Specialist not available'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetailScreen(
                          doctor: doctor,
                          patientId: widget.patientId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
