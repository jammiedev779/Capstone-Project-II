import 'package:doc_care/screens/login_&_register/register_screen.dart';
import 'package:doc_care/services/patient_api.dart';
import 'package:doc_care/shared/utils/bottom_nav_bars/main_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/app_icon.svg',
                  height: 60,
                ),
                SizedBox(height: 25),
                Text(
                  'Hi, Welcome Back!',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Hope you\'re doing fine.',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.outlineVariant,
                  ),
                ),
                SizedBox(height: 50),
                // Phone number input
                TextField(
                  controller: phoneNumberController,
                  obscureText: false,
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
                // Sign In button
                SizedBox(
                  width: double.parse('300'),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _loginUser(context, phoneNumberController.text,
                          passwordController.text);
                    },
                    icon: Image.asset(
                      'assets/icons/login_icon.png',
                      width: 20,
                    ),
                    label: Text('Sign In'),
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
                Text('or'),
                SizedBox(height: 10),
                // Sign In with Telegram
                // SizedBox(
                //   width: double.parse('300'),
                //   child: ElevatedButton.icon(
                //     onPressed: () {},
                //     icon: Image.asset(
                //       'assets/icons/telegram_icon.png',
                //       width: 20,
                //     ),
                //     label: Text('Sign In with Telegram'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: colorScheme.onPrimary,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //         side: BorderSide(color: colorScheme.primary),
                //       ),
                //       padding: EdgeInsets.symmetric(vertical: 15),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(color: colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser(
      BuildContext context, String phoneNumber, String password) async {
    final Map<String, String> credentials = {
      'phone_number': phoneNumber,
      'password': password,
    };

    final response = await ApiService.loginPatient(credentials);

    if (response['status'] == 200) {
      String token = response['token'];
      int? patientId = response['patient_id'];
      if (patientId == null) {
        print('Error: patientId is null');
        _showErrorDialog(context, 'An error occurred. Please try again.');
        return;
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MainNavBar(token: token, patientId: patientId),
              ),
            );
          });
          return AlertDialog(
            title: const Text('Login Successfully'),
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
      _showErrorDialog(context,
          response['message'] ?? 'An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
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
