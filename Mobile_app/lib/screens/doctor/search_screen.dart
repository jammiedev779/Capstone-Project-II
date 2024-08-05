import 'package:doc_care/screens/doctor/doctor_detail.dart';
import 'package:doc_care/services/search_doctor_api.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final int patientId;

  const SearchScreen({super.key, required this.patientId});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _doctors = [];
  List<Map<String, dynamic>> _filteredDoctors = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final results = await SearchDoctorApi.getAllDoctors();
      setState(() {
        _doctors = results;
        _filteredDoctors = results;
      });
    } catch (e) {
      setState(() {
        _doctors = [];
        _filteredDoctors = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _filterDoctors(String query) async {
    if (query.isEmpty) {
      setState(() {
        _filteredDoctors = _doctors;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        final results = await SearchDoctorApi.searchDoctors(query);
        setState(() {
          _filteredDoctors = results;
        });
      } catch (e) {
        setState(() {
          _filteredDoctors = [];
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2d595a), Color(0xFF65a399)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 4),
                blurRadius: 6.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Doctor',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterDoctors,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search doctors...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildDoctorList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    if (_filteredDoctors.isEmpty) {
      return _buildNoResults();
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = _filteredDoctors[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorDetailScreen(
                        doctor: doctor, patientId: widget.patientId),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          doctor['profile_picture_url'] ??
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
                              '${doctor['first_name']} ${doctor['last_name']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              height: 10,
                              color: Colors.grey[300],
                            ),
                            Text(
                              doctor['specialist_title'] ??
                                  'Specialist not available',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                                  '${doctor['hospital_name']}',
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildNoResults() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
