import 'package:flutter/material.dart';

class RoleSelecScreen extends StatelessWidget {
  final String userEmail;

  const RoleSelecScreen({super.key, required this.userEmail});

  Future<void> _selectRole(BuildContext context, String role) async {
    // ADARSH YOU NEED TO MAKE SURE THE ROLE IS SAVED WITH THE USER IN FIREBASE

    if (role == "passenger") {
      Navigator.pushNamed(context, '/passenger');
    } else {
      Navigator.pushNamed(context, '/conductorInfo');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Role_Selection.png',
              fit: BoxFit.cover,
            ),
          ),

          // Passenger button fixed distance from top
          Positioned(
            top: screenHeight * 0.28, // 15% from top
            left: 0,
            right: 0,
            child: Center(
              child: _roleButton(
                context,
                'Passenger',
                'assets/passenger_bg.png',
                () => _selectRole(context, "passenger"),
              ),
            ),
          ),

          // Center text
          Positioned(
            top: screenHeight * 0.45, // roughly center
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                "Pick One that suits you best!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Conductor button - fixed distance from bottom
          Positioned(
            bottom: screenHeight * 0.22, // 15% from bottom
            left: 0,
            right: 0,
            child: Center(
              child: _roleButton(
                context,
                'Conductor',
                'assets/conductor_bg.png',
                () => _selectRole(context, "conductor"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleButton(
    BuildContext context,
    String label,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF19ABC2), // top color
              Color(0xFF0C515C), // bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            // optional overlay for text readability
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
