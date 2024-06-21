import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../route_util.dart'; // Import the route utility file

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the help screen. Here you can provide some useful information about the app.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  createFadeRoute(const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('Back to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
