import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Home Screen - Work in Progress',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
