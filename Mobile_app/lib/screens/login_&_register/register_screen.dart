import 'package:doc_care/screens/login_&_register/additional_page.dart';
import 'package:doc_care/screens/login_&_register/login_screen.dart';
import 'package:doc_care/services/patient_api.dart';
import 'package:doc_care/shared/utils/bottom_nav_bars/main_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/app_icon.svg',
                height: 60,
              ),
              SizedBox(height: 25),
              Text(
                'Hi, Welcome!',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Create your account to get started.',
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.outlineVariant,
                ),
              ),
              SizedBox(height: 50),
              // Phone number input
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Your Number',
                  prefixIcon: Icon(Icons.phone),
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
              SizedBox(height: 20),
              // Password input
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
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
              SizedBox(height: 50),
              SizedBox(
                width: double.parse('300'),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdditionalInfoPage(
                          phoneNumber: phoneNumberController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text('Create Account'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: colorScheme.primary),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Sign In button
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Do you have an account? Sign in',
                  style: TextStyle(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

