import 'package:flutter/material.dart';
// Adjust path if needed
import '/app_router.dart'; // Import router to navigate by route name

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to login after 2.5 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRouter.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // matches your Figma design
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo image
            Center(
              child: Image.asset(
                'assets/images/SANCHARI.png',
                width:
                    MediaQuery.of(context).size.width *
                    0.6, // 60% of screen width
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
