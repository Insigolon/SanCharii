import 'dart:math' as math;
import 'package:flutter/material.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({Key? key}) : super(key: key);

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

//things that dont work and stuff
// the map, the search bar, The routes (its just placeholders rn),
//The loading bar for the bus, Yea most of the functionality is not there da
// its just UI rn

class _PassengerScreenState extends State<PassengerScreen> {
  final List<Map<String, String>> previousBuses = [
    {"number": "MF21", "image": "assets/images/Bus1.png"},
    {"number": "25B", "image": "assets/images/Bus2.png"},
    {"number": "10A", "image": "assets/images/Bus2.png"},
  ];

  bool isLoading = false;
  String? selectedBus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Placeholder for MAP
          Positioned.fill(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Text(
                  "Map Will Go Here",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
            ),
          ),

          /// SEARCH BAR (only when no bus is selected)
          if (selectedBus == null)
            Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: isLoading
                  ? const LinearProgressIndicator(
                      minHeight: 8,
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    )
                  : Column(
                      children: [
                        _buildSearchField("Start Location"),
                        const SizedBox(height: 4),
                        _buildSearchField("Destination"),
                        const SizedBox(height: 4),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Set Start Location Manually"),
                        ),
                      ],
                    ),
            ),

          /// DRAGGABLE PANEL
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.15,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return ClipPath(
                clipper: TicketClipper(),
                child: Container(
                  color: Colors.black,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    children: [
                      const SizedBox(height: 16),

                      if (selectedBus == null) ...[
                        const Text(
                          "Previous Buses Taken",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...previousBuses.map(
                          (bus) => GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                                selectedBus = bus["number"];
                              });

                              Future.delayed(const Duration(seconds: 2), () {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                            },
                            child: _buildBusCard(
                              context,
                              bus["number"]!,
                              bus["image"]!,
                            ),
                          ),
                        ),
                      ],

                      if (selectedBus != null && !isLoading)
                        _buildBusInfoPanel(selectedBus!),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Search Field Widget
  Widget _buildSearchField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.black,
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  /// Previous Bus Card
  Widget _buildBusCard(
    BuildContext context,
    String busNumber,
    String imagePath,
  ) {
    return Card(
      color: Colors.cyan[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 9),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                busNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  /// UPDATED Bus Info Panel with flipped bus + circle + proper mandala layering
  Widget _buildBusInfoPanel(String busNumber) {
    return Stack(
      children: [
        /// Mandala behind everything
        Positioned(
          bottom: 0,
          right: 0,
          child: Opacity(
            opacity: 0.75,
            child: Image.asset(
              "assets/images/Mandala.png",
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "35 Mins",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Row with bus number + flipped image + circle
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  busNumber,
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24, // makes it pop
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Image.asset(
                          "assets/images/Bus2.png",
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 1),
            const Text(
              "Route no.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Fare Price   ₹ 20",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(
                8,
              ), // change the value to adjust roundness
              child: LinearProgressIndicator(
                value: 0.4,
                minHeight: 8,
                backgroundColor: Colors.white30,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            ),

            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStopTile("STOP 1 (Where You get on )", Colors.teal[900]!),
                _buildStopTile("STOP 2 stops in btw", Colors.teal[300]!),
                _buildStopTile("STOP 3 (where you get off)", Colors.teal[800]!),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "STOP 4 (remaining stops)",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Stop tile widget
  static Widget _buildStopTile(String label, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

/// Ticket-shaped clipper
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double notchWidth = 60;
    double notchDepth = 20;
    double curveControl = 12;

    path.moveTo(0, curveControl);
    path.quadraticBezierTo(0, 0, curveControl, 0);
    path.lineTo(size.width / 2 - notchWidth / 2, 0);
    path.quadraticBezierTo(
      size.width / 2 - notchWidth / 2 + curveControl,
      notchDepth,
      size.width / 2,
      notchDepth,
    );
    path.quadraticBezierTo(
      size.width / 2 + notchWidth / 2 - curveControl,
      notchDepth,
      size.width / 2 + notchWidth / 2,
      0,
    );
    path.lineTo(size.width - curveControl, 0);
    path.quadraticBezierTo(size.width, 0, size.width, curveControl);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
