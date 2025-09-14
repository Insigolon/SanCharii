import 'package:flutter/material.dart';

class RoleSelecScreen extends StatelessWidget {
  final String userEmail; // 👈 Pass the logged-in user's email from login page

  const RoleSelecScreen({super.key, required this.userEmail});

  Future<void> _selectRole(BuildContext context, String role) async {
    // TODO: Replace this with backend call to store role with email
    // Example: await saveUserRoleToServer(userEmail, role);

    // Navigate to respective page
    if (role == "passenger") {
      Navigator.pushReplacementNamed(context, '/passengerHome');
    } else {
      Navigator.pushReplacementNamed(context, '/conductorHome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Entire page background image (optional - can remove if you only want images behind buttons)
          Positioned.fill(
            child: Image.asset(
              'assets/bg_pattern.png', // 👈 Replace with your generic background pattern
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Passenger Button with image background
                  GestureDetector(
                    onTap: () => _selectRole(context, "passenger"),
                    child: Container(
                      width: 250,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/passenger_bg.png',
                          ), // 👈 Replace with your image
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Passenger",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Pick One that suits you best!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Conductor Button with image background
                  GestureDetector(
                    onTap: () => _selectRole(context, "conductor"),
                    child: Container(
                      width: 250,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/conductor_bg.png',
                          ), // 👈 Replace with your image
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Conductor",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
