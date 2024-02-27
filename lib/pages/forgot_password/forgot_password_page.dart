import 'dart:async';

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

    final isTimerCounting = useState<bool>(false);
    final remainingSecondsState = useState<int>(120);

    final emailController = useTextEditingController();

    final minutes = (remainingSecondsState.value / 60).floor();
    final seconds = remainingSecondsState.value % 60;

    void handleCheckEmail() {
      if (!isTimerCounting.value) {
        Timer.periodic(const Duration(seconds: 1), (_) {
          remainingSecondsState.value--;
          if (remainingSecondsState.value <= 0) {
            isTimerCounting.value = false;
            remainingSecondsState.value = 120;
            _.cancel();
          }
        });
        isTimerCounting.value = true;
      }
    }

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
                  Container(
                    width: screenWidth * 0.8,
                    // height: screenHeight * 0.37,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 6,
                          offset: Offset(1, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Send OTP to your email',
                              style: TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 25,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: emailController,
                            style: const TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff009781), width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                    color: Color(0xff009781), width: 1.0),
                              ),
                              prefixIcon: const Icon(
                                Icons.alternate_email,
                                color: Color(0xff9B9B9B),
                              ),
                              suffixIcon: isTimerCounting.value
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$minutes:${formatSecond(seconds)}",
                                          style: const TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  : IconButton(
                                      onPressed: handleCheckEmail,
                                      icon: const Icon(
                                        Icons.send_rounded,
                                        color: Color(0xff009781),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '*check your inbox or your spam folder',
                              style: TextStyle(
                                color: Color(0xFF9B9B9B),
                                fontSize: 11,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 1.0,
                                color: Color(0xFF009781),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size.fromHeight(52),
                            ),
                            child: const Text(
                              'Back to Login',
                              style: TextStyle(
                                color: Color(0xFF009781),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          )
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

  String formatSecond(int seconds) {
    return seconds.toString().padLeft(2, '0');
  }
}
