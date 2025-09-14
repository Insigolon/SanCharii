import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 2 seconds, then check login status
    Future.delayed(const Duration(seconds: 2), _checkLoginStatus);
  }

  void _checkLoginStatus() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User already signed in → go to role selection, pass email as argument
      Navigator.pushNamed(
        context,
        AppRouter.roleSelec,
        arguments: user.email ?? '',
      );
    } else {
      // User not signed in → go to login page
      Navigator.pushNamed(context, AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/SANCHARI.png',
          width: MediaQuery.of(context).size.width * 0.6,
        ),
      ),
    );
  }
}
