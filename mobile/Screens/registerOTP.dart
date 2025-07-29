import 'package:flutter/material.dart';
import 'package:byte_blossoms/services/otpRegister_service.dart';
import 'package:byte_blossoms/screens/login.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final Function onVerificationSuccess;

  OTPVerificationScreen({required this.email, required this.onVerificationSuccess});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final otpController = TextEditingController();
  final OTPService otpService = OTPService();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final otp = otpController.text;
                try {
                  final isVerified = await otpService.verifyOTP(widget.email, otp);
                  if (isVerified) {
                    widget.onVerificationSuccess();
                  } else {
                    setState(() {
                      errorMessage = 'Invalid OTP. Please try again.';
                    });
                  }
                } catch (e) {
                  setState(() {
                    errorMessage = 'Error verifying OTP. Please try again.';
                  });
                }
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
