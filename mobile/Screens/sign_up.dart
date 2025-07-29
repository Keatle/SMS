import 'package:byte_blossoms/Screens/sign_in.dart';
import 'package:byte_blossoms/controller/userController.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final UserController userController = UserController();

  String? errorMessage;
    bool _obscurePassword = true;

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
              padding: EdgeInsets.only(top: 80.0, left: 22),
              
              child: Text(
               
                'Hello\nSign up!',
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
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        // Student Number Input
                        TextFormField(
                          controller: studentNumberController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
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
                        // Name Input
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Names',
                              style: TextStyle(
                                 fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 122, 12),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Name field required' : null,
                        ),
                        const SizedBox(height: 20),
                        // Surname Input
                        TextFormField(
                          controller: surnameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Surname',
                              style: TextStyle(
                                 fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 122, 12),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Surname field required' : null,
                        ),
                        const SizedBox(height: 20),
                        // Email Input
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Gmail',
                              style: TextStyle(
                                 fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 122, 12),
                              ),
                            ),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Email field required' : null,
                        ),
                        const SizedBox(height: 20),
                        // Password Input
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
                        
                        const SizedBox(height: 20),
                        const SizedBox(height: 30),
                        // Signup Button
                                              // Button
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
                                    .createAccount(
                                      studentN: studentNumberController.text,
                                      name: nameController.text,
                                      surname: surnameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    )
                                    .then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    })
                                    .catchError((error) {
                                      setState(() {
                                        errorMessage = 'An error occurred: $error';
                                      });
                                    });
                              }
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 248, 122, 12),
                                ),
                              ),
                            
                            
                            ),
                      ],
                    ),
        ]),
                ),
              ),
            ),
          ),
      ), ],
      ),
    );
  }
}
