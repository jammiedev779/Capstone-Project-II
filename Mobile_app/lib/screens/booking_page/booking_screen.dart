import 'package:doc_care/services/booking_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
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
        'doctor_id': 1, // Replace with actual doctor ID
        'patient_id': 90, // Replace with actual patient ID
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
        // Show success message or navigate to another screen
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Booking created successfully!'),
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

  InputDecoration buildInputDecoration(String labelText, String hintText, ColorScheme colorScheme) {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date & Time', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dateController,
                decoration: buildInputDecoration(
                  'Select Date & Time',
                  'YYYY-MM-DD HH:MM',
                  colorScheme,
                ).copyWith(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date and time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Reason', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                decoration: buildInputDecoration('Enter reason', 'Reason for appointment', colorScheme),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Location', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: buildInputDecoration('Enter location', 'Location of appointment', colorScheme),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text('Note', style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 8),
              TextFormField(
                controller: _noteController,
                decoration: buildInputDecoration('', 'Additional notes', colorScheme),
                maxLines: 4, // Allows for multiple lines of text
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green, // Set the button color to green
                  ),
                  child: const Text('Submit Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
