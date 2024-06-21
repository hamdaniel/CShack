import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../route_util.dart'; // Import the route utility file

class WellDoneScreen extends StatelessWidget {
  const WellDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Replace with your image asset
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Centered "Well done!" and "+50"
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Well done!',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 16.0), // Spacing between texts
                
                Row(
                children: [
                  Text(
                    '+50',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 8.0), // Spacing between image and text
                  Image.asset(
                    'assets/carrot.png', // Replace with your image path
                    height: 50.0,
                    width: 50.0,
                  ),
                ],
              ),
              ],
            ),
          ),
          // Bottom "Homepage" button
          Positioned(
            bottom: 32.0, // Adjust positioning as needed
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                  createFadeRoute(const HomeScreen()),
                  (route) => false,
                );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Homepage',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
