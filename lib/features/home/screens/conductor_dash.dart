import 'package:flutter/material.dart';

class ConductorDashScreen extends StatelessWidget {
  const ConductorDashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conductor Dashboard")),
      body: const Center(child: Text("Welcome to Conductor Dashboard")),
    );
  }
}
