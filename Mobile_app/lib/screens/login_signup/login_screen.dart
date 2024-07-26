import 'package:doc_care/services/patient_api.dart';
import 'package:doc_care/shared/utils/bottom_nav_bars/main_nav_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            const Icon(
              Icons.medical_services_outlined,
              size: 50,
            ),
            const Text(
              'DocCare',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Text(
              'Login to your Account',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'We are here to help you!',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Your Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _loginUser(context, phoneNumberController.text, passwordController.text);
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const Spacer(flex: 2),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Please kindly fill the information to login'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> _loginUser(BuildContext context, String phoneNumber, String password) async {
    final Map<String, String> credentials = {
      'phone_number': phoneNumber,
      'password': password,
    };

    final response = await ApiService.loginPatient(credentials);

    if (response['status'] == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavBar(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }
}
