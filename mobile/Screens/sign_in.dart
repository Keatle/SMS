import 'dart:convert';
import 'package:byte_blossoms/Screens/chairpersonDashboard.dart';
import 'package:byte_blossoms/Screens/member_noticeboard.dart';
import 'package:byte_blossoms/Screens/secreraryDashboard.dart';
import 'package:byte_blossoms/Screens/secretary_noticeboard.dart';
import 'package:byte_blossoms/Screens/sendOTP.dart';
import 'package:byte_blossoms/Screens/sign_up.dart';
import 'package:byte_blossoms/controller/userController.dart';
import 'package:byte_blossoms/model/user_model.dart';
import 'package:byte_blossoms/screens/leader_noticeboard.dart';
import 'package:byte_blossoms/screens/secretary_noticeboard.dart';
import 'package:byte_blossoms/screens/sendOTP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginPage extends StatefulWidget {
 
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserController userController = UserController();
  final storage = FlutterSecureStorage();

  String? storedToken;
  String? storedStudentN;
  bool _obscurePassword = true;  // Toggle state for password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Color.fromARGB(214, 1, 1, 1),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: studentNumberController,
                          decoration: const InputDecoration(
                            label: Text(
                              'Student Number',
                              style: TextStyle(
                                 fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 122, 12),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Student number field required' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword; // Toggle visibility
                                });
                              },
                            ),
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                 fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 122, 12),
                              ),
                            ),
                          ),
                          obscureText: _obscurePassword, // Handle visibility
                          validator: (value) =>
                              value!.isEmpty ? 'Password field required' : null,
                        ),
                        
                        
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Navigate to the OTP Verification Screen or handle forgot password logic
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Align(
                          alignment: Alignment.centerRight, // Aligns to the right
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color.fromARGB(255, 248, 122, 12),
                            ),
                          ),
                        ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: MaterialButton(
                            minWidth: double.maxFinite,
                            color: Color.fromARGB(255, 248, 122, 12),
                            height: 60,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                userController
                                    .login(
                                      studentN: studentNumberController.text,
                                      password: passwordController.text,
                                    )
                                    .then((response) async {
                                  if (response.statusCode == 200) {
                                    final resp = jsonDecode(response.body);
                                    final user = UserModel.fromJson(resp);
                                    final studentN = studentNumberController.text;
                                    final userID = user.user?.userID;
                                    final token = resp['token']; 

                                    if (userID != null) {
                                      await storage.write(key: 'user_id', value: userID.toString());
                                      await storage.write(key: 'user_studentN', value: studentN);
                                      await storage.write(key: 'token', value: token);

                                      setState(() {
                                        storedToken = token;
                                        storedStudentN = studentN;
                                      });

                                      switch (studentN[0]) {
                                        case 'C':
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DashboardChairperson(
                                                  userID: userID.toString(),
                                                  studentN: studentN),
                                            ),
                                          );
                                          break;
                                        case 'S':
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SecretaryNoticeboard(
                                                  userID: userID.toString(),
                                                  studentN: studentN),
                                            ),
                                          );
                                          break;
                                        case 'T':
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LeaderNoticeboard(
                                                  userID: userID.toString(),
                                                  ),
                                            ),
                                          );
                                          break;
                                        default:
                                          if (RegExp(r'^\d{9}$').hasMatch(studentN)) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DashboardStudent(
                                                    userID: userID.toString(),
                                                    studentN: studentN),
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text('Invalid Student Number'),
                                                  content: const Text('The student number is invalid. Please try again.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          break;
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Login Failed'),
                                            content: const Text('Failed to retrieve user ID. Please try again.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Login Failed'),
                                          content: const Text('Invalid credentials. Please try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }).catchError((error) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Login Error'),
                                        content: const Text('An error occurred while logging in. Please try again.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(fontSize: 17),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 248, 122, 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        if (storedToken != null && storedStudentN != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Token: $storedToken',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Student Number: $storedStudentN',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
