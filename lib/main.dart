import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/logo.png', // your logo path
            width: 200,
            height: 200,
            fit: BoxFit.cover, // ensures image fills the circle
          ),
        ),
      ),
    );
  }
}
