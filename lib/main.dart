import 'package:ampushare/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
