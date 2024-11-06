import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _authService = AuthService();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool otpSent = false;

  void sendOtp() async {
    await _authService.sendOtp(_phoneController.text);
    setState(() {
      otpSent = true;
    });
  }

  void resetPassword() async {
    bool isValidOtp = await _authService.resetPassword(_phoneController.text,
        _otpController.text, _newPasswordController.text);
    if (isValidOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successful')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone/Email')),
            if (!otpSent)
              ElevatedButton(onPressed: sendOtp, child: const Text('Send OTP'))
            else ...[
              PinCodeTextField(
                appContext: context,
                length: 6,
                onChanged: (value) {},
                controller: _otpController,
              ),
              TextField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true),
              ElevatedButton(
                  onPressed: resetPassword, child: const Text('Reset Password'))
            ],
          ],
        ),
      ),
    );
  }
}
