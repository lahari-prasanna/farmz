import 'package:flutter/material.dart';
import 'dart:async'; // add this for Timer
import 'login_page.dart'; // import the new login page

void main() {
  runApp(const FarmZApp());
}

// --------------------- Root App ---------------------
class FarmZApp extends StatelessWidget {
  const FarmZApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmZ Farmer',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),
    );
  }
}

// --------------------- Splash Screen ---------------------


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to LoginPage after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
