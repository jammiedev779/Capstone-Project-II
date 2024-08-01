import 'package:doc_care/services/patient_api.dart';
import 'package:doc_care/shared/utils/bottom_nav_bars/main_nav_bar.dart';
import 'package:flutter/material.dart';
class AdditionalInfoPage extends StatelessWidget {
  final String phoneNumber;
  final String password;

  AdditionalInfoPage({required this.phoneNumber, required this.password});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Fill Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SvgPicture.asset(
            //   'assets/icons/app_icon.svg',
            //   height: 60,
            // ),
            SizedBox(height: 25),
            Text(
              'Fill Your Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colorScheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _registerUser(context);
              },
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: colorScheme.primary),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    final Map<String, String> userData = {
      'name': nameController.text,
      'address': addressController.text,
      'gender': genderController.text,
      'age': ageController.text,
      'email': emailController.text,
      'phone_number': phoneNumber,
      'password': password,
    };

    final response = await ApiService.registerPatient(userData);

    if (response['status'] == 200) {
      String token = response['token'];
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(); 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavBar(token: token),
              ),
            );
          });
          return AlertDialog(
            title: const Text('Congratulations!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(
                  Icons.check_circle,
                  size: 100,
                  color: Colors.green,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your account is ready to use. You will be redirected to the Home Page.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16.0),
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(response['message']),
          );
        },
      );
    }
  }
}
