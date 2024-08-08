import 'package:flutter/material.dart';
import 'package:doc_care/screens/home/category_specialize.dart';
import 'package:doc_care/screens/home/medical_center.dart';
import 'package:doc_care/screens/home/notification_page.dart';
import 'package:doc_care/services/search_doctor_api.dart';
import 'package:doc_care/screens/doctor/doctor_detail.dart'; 
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  final int patientId;
  final String token;

  const HomeView({super.key, required this.token, required this.patientId});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _doctors = [];
  List<Map<String, dynamic>> _filteredDoctors = [];
  bool _isLoading = false;
  bool _isSearching = false;

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
        _isSearching = false;
        _filteredDoctors = _doctors;
      });
    } else {
      setState(() {
        _isSearching = true;
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 80.0),
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
          
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: null,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/app_icon.svg',
                      height: 30.0,
                      width: 30.0,
                    ),
                    // Center: Home
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 48.0), 
                  ],
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 2.0),
                    // padding: EdgeInsets.all(2.0),
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   color: Color.fromARGB(255, 200, 196, 196), 
                    // ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotificationPage()),
                        );
                      },
                      icon: Icon(Icons.notifications),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      iconSize: 22.0, 
                      padding: EdgeInsets.all(4.0), 
                      constraints: BoxConstraints(
                        minWidth: 22.0, 
                        minHeight: 22.0, 
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterDoctors,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Address, Specialist, Name of Doctors...",
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
              ),
            ],
          ),
        ),
      ),
      body: _isSearching
          ? _buildDoctorList()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage('assets/images/slide1_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Booking Your',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Appointment Now!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Schedule an appointment',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'with our doctors.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: CategoriesScreen(),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: NearbyMedicalCentersScreen(
                        patientId: widget.patientId,  
                      ),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDoctorList() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_filteredDoctors.isEmpty) {
      return Center(child: Text('No results found'));
    }

    return ListView.builder(
      itemCount: _filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = _filteredDoctors[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDetailScreen(
                  token: widget.token,
                  doctor: doctor,
                  patientId: widget.patientId,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
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
                      doctor['image'] ??
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
                          doctor['specialist_title'] ?? 'Specialist not available',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              doctor['address'] ?? 'address not available',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(
                              doctor['phone_number'] ?? 'Phone not available',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
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
    );
  }
}
