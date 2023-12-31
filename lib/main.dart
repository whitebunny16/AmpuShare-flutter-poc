import 'package:ampushare/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "AmpuShare",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff009781)),
      useMaterial3: true,
    ),
    home: const LoginPage(),
  ));
}
