import 'package:flutter/material.dart';

class ConductorDashScreen extends StatefulWidget {
  const ConductorDashScreen({super.key});

  @override
  State<ConductorDashScreen> createState() => _ConductorDashScreenState();
}

class _ConductorDashScreenState extends State<ConductorDashScreen> {
  List<String?> stops = List.generate(6, (_) => null); // 6 stop slots

  void _addStop(int index) {
    final TextEditingController _stopController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(141, 0, 0, 0),
        title: const Text("Add Stop", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _stopController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter stop name",
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              if (_stopController.text.trim().isNotEmpty) {
                setState(() {
                  stops[index] = _stopController.text.trim();
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //  Background Image
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Bus_stop.png',
              height: 500, // Adjust size so it’s subtle
              fit: BoxFit.contain,
            ),
          ),

          //  Foreground Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Conductor Name / Route / Locations
                  const Text(
                    "Conductor: User Name",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),

                  _buildInputField("Route No."),
                  const SizedBox(height: 10),
                  _buildInputField("Starting Location"),
                  const SizedBox(height: 10),
                  _buildInputField("Destination"),

                  const SizedBox(height: 30),

                  //  "Add stops here" text
                  const Text(
                    "Add stops here:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Stops Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                    itemCount: stops.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _addStop(index),
                        child: stops[index] == null
                            ? const Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.black,
                              )
                            : Text(
                                stops[index]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.teal[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
