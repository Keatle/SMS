import 'package:byte_blossoms/Screens/fontSizeProvider.dart';
import 'package:byte_blossoms/Screens/otpVerification.dart';
import 'package:byte_blossoms/Screens/resetPassword.dart';
import 'package:byte_blossoms/Screens/sendOTP.dart';
import 'package:byte_blossoms/Screens/sign_in.dart';
import 'package:byte_blossoms/screens/colorProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {

  
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontSizeProvider()), 
        ChangeNotifierProvider(create: (_) => ColorProvider()), 
      ],
      child: const MyApp(), // Wrap MyApp in MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Byte Blossoms',
      theme: ThemeData(
        primarySwatch: Colors.green, //was purple
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>LoginPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/verifyOTP': (context) => VerifyOTPPage(),
        '/resetPassword': (context) => ResetPasswordPage(),
        '/login': (context) => LoginPage(),
      },
      
    );
  }
}
