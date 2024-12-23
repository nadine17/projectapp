import 'package:flutter/material.dart';
import 'get_started.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
        },
        child: Stack(
          fit: StackFit
              .expand, // Makes the background image fill the entire screen
          children: [
            // Full-screen background image
            Image.asset(
              'assets/images/splash.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),

            // Foreground content
          ],
        ),
      ),
    );
  }
}
