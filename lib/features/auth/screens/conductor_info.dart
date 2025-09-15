import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConductorInfoScreen extends StatefulWidget {
  const ConductorInfoScreen({super.key});

  @override
  State<ConductorInfoScreen> createState() => _ConductorInfoScreenState();
}

class _ConductorInfoScreenState extends State<ConductorInfoScreen> {
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _saveConductorInfo() async {
    final routeNumber = _routeController.text.trim();
    final conductorName = _nameController.text.trim();
    final user = FirebaseAuth.instance.currentUser;

    if (routeNumber.isEmpty || conductorName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both fields must be filled!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No user logged in! Please log in again."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show blocking loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    try {
      final firestore = FirebaseFirestore.instance;

      // Add timeout protection
      await firestore
          .collection("conductors")
          .doc(user.email)
          .set({
            "email": user.email,
            "routeNumber": routeNumber,
            "conductorName": conductorName,
            "registered": true,
            "timestamp": FieldValue.serverTimestamp(),
          })
          .timeout(const Duration(seconds: 5));

      if (!mounted) return;

      Navigator.pop(context); // close loading dialog
      Navigator.pushReplacementNamed(context, '/conductorDash');
    } on TimeoutException catch (_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Request timed out. Please check your internet."),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving info: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Conductor_icon.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),

                  // Route Number Field
                  TextField(
                    controller: _routeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Route Number",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.alt_route,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Conductor Name Field
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Conductor Name / ID",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.badge, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Go to Dashboard Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveConductorInfo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Go to Dashboard",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
