import 'package:doc_care/screens/screens.dart';
import 'package:doc_care/services/booking_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final int doctorId;
  final int patientId;

  BookingScreen({required this.doctorId, required this.patientId});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _dateController.dispose();
    _reasonController.dispose();
    _locationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = combinedDateTime;
          _dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(combinedDateTime);
        });
      }
    }
  }
  
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final Map<String, dynamic> bookingData = {
        'doctor_id': widget.doctorId,
        'patient_id': widget.patientId,
        'appointment_date': _dateController.text,
        'location': _locationController.text,
        'status': 0, // Default status (Pending)
        'user_status': 0, // Default user status (Pending)
        'doctor_status': 0, // Default doctor status (Pending)
        'reason': _reasonController.text,
        'note': _noteController.text,
      };

      final response = await BookingApi.createBooking(bookingData);

      if (response['statusCode'] == 201) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Booking created successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentScreen(patientId: widget.patientId)),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(response['data']['message'] ?? 'Something went wrong'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  InputDecoration _buildInputDecoration(String labelText, String hintText) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
              colors: [Color(0xFF245252), Color(0xFF67A59B)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Book Appointment',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date & Time'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dateController,
                decoration: _buildInputDecoration('Appointment Date', 'Select date and time'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an appointment date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Reason'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                decoration: _buildInputDecoration('Reason', 'Why do you need this appointment?'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Location'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: _buildInputDecoration('Location', 'Enter the location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Note'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                decoration: _buildInputDecoration('Note', 'Additional notes (optional)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a note';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF245252), // Match the AppBar gradient color
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
