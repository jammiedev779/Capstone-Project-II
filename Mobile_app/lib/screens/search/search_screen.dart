import 'package:doc_care/services/search_doctor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    _filteredDoctors = _doctors;
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
                hintText: "Doctors, Symptoms, Hospitals...",
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
                : _searchController.text.isEmpty
                    ? _buildInitialGrid()
                    : _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildGridItem("Book an Appointment", Icons.calendar_today, Colors.purple[100]!),
          _buildGridItem("Request a Physical Consultation", Icons.phone, Colors.green[100]!),
          _buildGridItem("Find a Health Center", Icons.local_hospital, Colors.blue[100]!),
          _buildGridItem("Locate a Pharmacy", Icons.local_pharmacy, Colors.red[100]!),
          _buildGridItem("Order a Lab Test", Icons.science, Colors.orange[100]!),
          _buildGridItem("Emergency Situation", Icons.warning, Colors.purple[100]!),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredDoctors.isEmpty) {
      return _buildNoResults();
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _filteredDoctors.length,
          itemBuilder: (context, index) {
            final doctor = _filteredDoctors[index];
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12.0),
                leading: CircleAvatar(
                  radius: 60, 
                  backgroundImage: NetworkImage('https://i.pinimg.com/736x/83/1f/01/831f015888b5a0cd588e89b865ed12d0.jpg'),
                ),
                title: Text('${doctor['first_name']} ${doctor['last_name']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16),
                        const SizedBox(width: 4),
                        Text('${doctor['phone_number']}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.info, size: 16),
                    //     const SizedBox(width: 4),
                    //     Text('${doctor['status']}'),
                    //   ],
                    // ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                        const Icon(Icons.star, size: 16, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
                trailing: TextButton(
                  child: const Text('Detail'),
                  onPressed: () {
                    // Booking action
                  },
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
