import 'package:ampushare/pages/login/login_page.dart';
import 'package:ampushare/widgets/layouts/auth_layout/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ForgotPasswordPage extends HookWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const AuthLayout(),
          SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.45,
                      child: Column(
                        children: [
                          Text("Send OTP to your Email"),
                          TextField(),
                          Text("*check your inbox or your spam folder"),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text("Back to Login"))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
