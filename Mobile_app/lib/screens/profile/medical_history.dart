import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
class MedicalHistory extends StatefulWidget {
  MedicalHistory({super.key});

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final List<Record> records = [
    buildCardMedicalHistory(
      doctorType: 'Dentist',
      date: 'January 4th, 2018',
      time: '09:00am',
      disease: 'Dental hygiene',
      attendingDoctor: 'John Smith, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'ENT doctor',
      date: 'December 17th, 2017',
      time: '10:30am',
      disease: 'Sore throat',
      attendingDoctor: 'Matt Ryerson, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Cardiologist',
      date: 'August 25th, 2017',
      time: '4:15pm',
      disease: 'Circulatory problems',
      attendingDoctor: 'Ronald Boyd, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Dentist',
      date: 'January 4th, 2018',
      time: '09:00am',
      disease: 'Dental hygiene',
      attendingDoctor: 'John Smith, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'ENT doctor',
      date: 'December 17th, 2024',
      time: '10:30am',
      disease: 'Sore throat',
      attendingDoctor: 'Matt Ryerson, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Cardiologist',
      date: 'August 25th, 2017',
      time: '4:15pm',
      disease: 'Circulatory problems',
      attendingDoctor: 'Ronald Boyd, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Pediatrician',
      date: 'March 10th, 2019',
      time: '2:00pm',
      disease: 'Routine check-up',
      attendingDoctor: 'Sarah Johnson, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Orthopedist',
      date: 'November 5th, 2020',
      time: '11:15am',
      disease: 'Knee pain',
      attendingDoctor: 'Michael Adams, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Dermatologist',
      date: 'July 21st, 2021',
      time: '1:30pm',
      disease: 'Skin rash',
      attendingDoctor: 'Emily Davis, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Gynecologist',
      date: 'February 14th, 2022',
      time: '3:00pm',
      disease: 'Routine check-up',
      attendingDoctor: 'Jessica Wilson, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Neurologist',
      date: 'September 30th, 2022',
      time: '10:00am',
      disease: 'Migraines',
      attendingDoctor: 'Robert Brown, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Ophthalmologist',
      date: 'December 1st, 2022',
      time: '9:45am',
      disease: 'Vision problems',
      attendingDoctor: 'Linda Taylor, MD',
    ),
    buildCardMedicalHistory(
      doctorType: 'Endocrinologist',
      date: 'April 18th, 2023',
      time: '1:00pm',
      disease: 'Thyroid issues',
      attendingDoctor: 'William Harris, MD',
    ),
  ];

  String selectedTab = 'allRecordsTab';

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
                  // Color(0xFF245252),
                  // Color(0xFF54968B),
                  
                  Color(0xFF245252),
                  Color(0xFF67A59B),
                  // Color(0xFF7734EB)!,
                  // Color(0xFF4B95EA)!,
                  // Color(0xFF84BCFD)!
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
      body: buildBodyMedicalHistory(),
    );
  }

  //widget that take the card to display as the ListView
  Widget buildBodyMedicalHistory() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: getFilteredRecords().length,
        itemBuilder: (context, index) {
          final record = getFilteredRecords()[index];
          return RecordCard(record: record);
        },
      ),
    );
  }

  //the list split to search for the year of the record
  List<Record> getFilteredRecords() {
    if (selectedTab == 'allRecordsTab') {
      return records;
    }
    return records.where((record) {
      final year = record.date.split(' ')[2];
      return year == selectedTab.replaceAll('Tab', '');
    }).toList();
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
}

//widget that take the data from the list to prepare as a card
Record buildCardMedicalHistory({
  required String doctorType,
  required String disease,
  required String date,
  required String time,
  required String attendingDoctor,
}) {
  return Record(doctorType, disease, date, time, attendingDoctor);
}

class Record {
  final String doctorType;
  final String disease;
  final String date;
  final String time;
  final String attendingDoctor;

  Record(this.doctorType, this.disease, this.date, this.time,
      this.attendingDoctor);
}

class RecordCard extends StatelessWidget {
  final Record record;

  RecordCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.doctorType,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  record.date,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
                Text(
                  record.disease,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Scheduled at: ${record.time}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attending doctor: ${record.attendingDoctor}',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xFF4F7E76),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
