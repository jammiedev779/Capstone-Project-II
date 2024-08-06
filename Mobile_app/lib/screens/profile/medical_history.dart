// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MedicalHistoryScreen extends StatefulWidget {
  final int patientId;

  MedicalHistoryScreen({required this.patientId});

  @override
  _MedicalHistoryScreenState createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  String selectedTab = 'allRecordsTab';
  late Future<List<Map<String, dynamic>>> _medicalHistoryFuture;

  // Endpoint API local For chrome developer
  // static const String _baseUrl = 'http://127.0.0.1:8002/api/medical_history';

  // Endpoint API local for emulator developer
  static const String _baseUrl = 'http://10.0.2.2:8002/api/medical_history';

  // Add endpoint API server here..
  // static const String _baseUrl = 'http://54.151.252.168/api/medical_history';

  @override
  void initState() {
    super.initState();
    _medicalHistoryFuture = fetchMedicalHistory(widget.patientId);
  }

  Future<List<Map<String, dynamic>>> fetchMedicalHistory(int patientId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$patientId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['medical'];
      return jsonData.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load medical history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 80.0),
        child: Container(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF245252),
                  Color(0xFF67A59B),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
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
                    'Medical History',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  color: Colors.green[50],
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabButton('allRecordsTab', 'All Records'),
                        _buildTabButton('2024Tab', '2024'),
                        _buildTabButton('2023Tab', '2023'),
                        _buildTabButton('2022Tab', '2022'),
                        _buildTabButton('2021Tab', '2021'),
                        _buildTabButton('2020Tab', '2020'),
                        _buildTabButton('2019Tab', '2019'),
                        _buildTabButton('2018Tab', '2018'),
                        _buildTabButton('2017Tab', '2017'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _medicalHistoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No medical history found.'));
          } else {
            final medicalHistory = getFilteredRecords(snapshot.data!);
            return ListView.builder(
              itemCount: medicalHistory.length,
              itemBuilder: (context, index) {
                final record = medicalHistory[index];
                return MedicalHistoryCard(record: record);
              },
            );
          }
        },
      ),
    );
  }

  //widget costumize the button
  Widget _buildTabButton(String tab, String label) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedTab = tab;
          // updateYear(tab);
        });
      },
      style: TextButton.styleFrom(
        backgroundColor:
            selectedTab == tab ? Color(0xFF4F7E76) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selectedTab == tab ? Colors.white : Colors.black,
          fontWeight: selectedTab == tab ? FontWeight.bold : FontWeight.bold,
        ),
      ),
    );
  }
    //the list split to search for the year of the record
  List<Map<String, dynamic>> getFilteredRecords(List<Map<String, dynamic>> records) {
    if (selectedTab == 'allRecordsTab') {
      return records;
    }
    return records.where((record) {
      final year = (record['visit_date'] ?? '').split('-')[0];
      return year == selectedTab.replaceAll('Tab', '');
    }).toList();
  }
}

class MedicalHistoryCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const MedicalHistoryCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF4F7E76),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Text(
                  '${record['diagnosis'] ?? 'No Diagnosis'}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Spacer(),
                Icon(Icons.more_time_outlined, size: 16, color: Colors.white, ),
                SizedBox(width: 5),
                Text(
                  '${record['visit_date'] ?? 'No Date'}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Treatment: ${record['treatment'] ?? 'No Treatment'}',style: TextStyle(fontSize: 14,),),
                SizedBox(height: 5),
                Text(
                    'Follow-Up Date: ${record['follow_up_date'] ?? 'No Date'}',style: TextStyle(fontSize: 14,)),
                SizedBox(height: 5),
                Text(
                    'Doctor: ${record['doctor_firstName']} ${record['doctor_lastName']}',style: TextStyle(fontSize: 14,)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.note_alt_outlined, size: 16),
                    SizedBox(width: 5),
                    Text('Note: ${record['note'] ?? 'No Note'}',style: TextStyle(fontSize: 14,)),
                    Spacer(),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4F7E76),
                      ),
                      child: Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
