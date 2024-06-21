import 'package:cshack_app/screens/avatar_selection_screen.dart';
import 'package:cshack_app/screens/game_screen.dart';
import 'package:cshack_app/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'breathing_screen.dart';
import 'plan_screen.dart';
import 'profile_screen.dart';
import 'stats_screen.dart';
import 'display_challenge_screen.dart';
import 'challenge_screen.dart';
import 'help_screen.dart';
import 'video_screen.dart';
import '../route_util.dart'; // Import the route utility file

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Replace with your image asset
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
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

          // Top right text ("streak") with image
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

          // Center image with text
          Positioned(
            top: 45.0, // Adjust positioning as needed
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/avatar1.png', // Replace with your image path
                  height: 130.0,
                  width: 130.0,
                ),
                const SizedBox(height: 8.0), // Spacing between image and text
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
            bottom: 150.0, // Adjust positioning as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createFadeRoute(const VideoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 141, 51), // Background color
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Text color
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0), // Padding
                    minimumSize: const Size(200, 60), // Minimum size of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/play.png', // Replace with your image path
                        height: 35.0,
                        width: 35.0,
                      ),
                      const SizedBox(width: 8.0), // Spacing between image and text
                      const Text(
                        'Start Daily Task!',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0), // Fixed spacing between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createFadeRoute(const DisplayChallengesScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 141, 51), // Background color
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Text color
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0), // Padding
                    minimumSize: const Size(200, 60), // Minimum size of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/target.png', // Replace with your image path
                        height: 35.0,
                        width: 35.0,
                      ),
                      const SizedBox(width: 8.0), // Spacing between image and text
                      const Text(
                        'My Challenges',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                    Navigator.of(context).push(createSlideRoute(const AvatarSelectionScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 105, 202, 205), // Background color
                    foregroundColor: const Color.fromARGB(255, 224, 118, 31), // Text color
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
                    Navigator.of(context).push(createSlideRoute(PlanScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 174, 180), // Background color
                    foregroundColor: const Color.fromARGB(255, 252, 141, 51), // Text color
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
                    Navigator.of(context).push(createSlideRoute( StatisticsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 174, 180), // Background color
                    foregroundColor: const Color.fromARGB(255, 252, 141, 51), // Text color
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
