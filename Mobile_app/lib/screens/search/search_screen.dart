import 'package:doc_care/screens/search/doctor_detail.dart';
import 'package:doc_care/services/search_doctor_api.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
      appBar: AppBar(
        title: const Text("Search"),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              // Location filter action
            },
          ),
        ],
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
                hintText: "Search doctors, symptoms, hospitals...",
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
                    builder: (context) => DoctorDetailScreen(doctor: doctor),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12.0),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1722297600&semt=ais_hybrid'),
                  ),
                  title: Text('${doctor['first_name']} ${doctor['last_name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Medical Officer'),
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
                      const SizedBox(height: 8),
                      Text('Hisglory Specialist Hospitals'),
                    ],
                  ),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
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
