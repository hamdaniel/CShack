import 'package:flutter/material.dart';
import 'screen1.dart';
import 'plan_screen.dart';
import 'profile_screen.dart';
import 'stats_screen.dart';
import 'help_screen.dart';
import '../route_util.dart'; // Import the route utility file

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color could be added here if desired

          // Top left text ("carrots") with image
          Positioned(
            top: 32.0, // Adjust positioning as needed
            left: 16.0,
            child: Row(
              children: [
                Image.asset(
                  'assets/carrot.png', // Replace with your image path
                  height: 35.0,
                  width: 35.0,
                ),
                const SizedBox(width: 8.0), // Spacing between image and text
                const Text(
                  'carrots',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Top right text ("streak")
          Positioned(
            top: 32.0, // Adjust positioning as needed
            right: 16.0,
            child: Row(
              children: [
                Image.asset(
                  'assets/fire.png', // Replace with your image path
                  height: 35.0,
                  width: 35.0,
                ),
                const SizedBox(width: 8.0), // Spacing between image and text
                const Text(
                  'streak',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // bunny
          Positioned(
            top: 45.0, // Adjust positioning as needed
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/rabbit.png', // Replace with your image path
                  height: 130.0,
                  width: 130.0,
                ),
                const SizedBox(width: 8.0), // Spacing between image and text
                const Text(
                  'You',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Center buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 100.0, // Adjust positioning as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createFadeRoute(const Screen1()));
                  },
                  child: const Text('Start Daily Task!'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createFadeRoute(const HelpScreen()));
                  },
                  child: const Text('My Challenges'),
                ),
              ],
            ),
          ),

          // Bottom row of buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 5.0, // Adjust positioning as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createSlideRoute(const ProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 105, 202, 205), // Background color
                    foregroundColor: Color.fromARGB(255, 184, 83, 0), // Text color
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 36.0), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/user.png', // Replace with your image path
                        height: 50.0,
                        width: 50.0,
                      ),
                      const SizedBox(height: 5.0), // Spacing between image and text
                      const Text('Profile'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createSlideRoute(const PlanScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 174, 180), // Background color
                    foregroundColor: Color.fromARGB(255, 252, 141, 51), // Text color
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 36.0), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/planning.png', // Replace with your image path
                        height: 50.0,
                        width: 50.0,
                      ),
                      const SizedBox(height: 5.0), // Spacing between icon and text
                      const Text('Plan'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createSlideRoute(const StatsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 174, 180), // Background color
                    foregroundColor: Color.fromARGB(255, 252, 141, 51), // Text color
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 36.0), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/stats.png', // Replace with your image path
                        height: 50.0,
                        width: 50.0,
                      ),
                      const SizedBox(height: 5.0), // Spacing between icon and text
                      const Text('Stats'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}