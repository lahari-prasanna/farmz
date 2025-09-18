import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'home_page.dart'; // We will create this next
import 'main_scaffold.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Function to request permissions
  Future<void> requestPermissions(BuildContext context) async {
    // Request location
    var locationStatus = await Permission.location.request();

    // Request notification
    var notificationStatus = await Permission.notification.request();

    // Check if both granted
    if (locationStatus.isGranted && notificationStatus.isGranted) {
      // Navigate to Home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Show alert if permission denied
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Permissions required'),
          content: const Text(
              'Location and Notification permissions are required to use the app.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // light green background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 60), // top spacing
              
              // Logo
              ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // App Name
              const Text(
                'FarmZ Farmer',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 40),

              // Login Fields
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // Request location
                  var locationStatus = await Permission.location.request();

                  // Request notification
                  var notificationStatus = await Permission.notification.request();

                  if (locationStatus.isGranted && notificationStatus.isGranted) {
                    // Both permissions granted → go to HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScaffold()),
                    );

                  } else {
                    // Any permission denied → show popup
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Permissions required'),
                        content: const Text(
                            'Location and Notification permissions are required to use the app.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // close popup
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              openAppSettings(); // takes user to App Settings
                              Navigator.pop(context);
                            },
                            child: const Text('Open Settings'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
