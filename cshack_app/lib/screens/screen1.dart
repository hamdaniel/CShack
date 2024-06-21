import 'package:flutter/material.dart';
import 'screen2.dart';
import '../route_util.dart'; // Import the route utility file

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  bool _showNewButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          //Positioned.fill(
          //  child: Image.asset(
          //    'assets/background.jpg',
          //    fit: BoxFit.cover,
          //  ),
          //),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showNewButton = true;
                    });
                  },
                  child: const Text('Pop'),
                ),
                if (_showNewButton)
                  ElevatedButton(
                    onPressed: () {
                      // Handle the press of "New Button"
                      print('New button pressed!');
                    },
                    child: const Text('New Button'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                    createSlideRoute(const Screen2()),
                    (route) => false,
                  );
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
