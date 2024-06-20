import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../route_util.dart'; // Import the route utility file

class Screen2 extends StatelessWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen 2'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              createFadeRoute(const HomeScreen()),
              (route) => false,
            );
          },
          child: const Text('Go Back to Home Screen'),
        ),
      ),
    );
  }
}
