
import 'package:flutter/material.dart';
import 'screens/breathing_screen.dart';
import 'screens/game_screen.dart';
import 'screens/challenge_screen.dart';
import 'screens/display_challenge_screen.dart';
//import 'screens/story_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Example')),
      body: const Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    SliderScreen(),
    TextBoxScreen(),
    AnimatedCircleScreen(),
    GameScreen(),
    ChallengeScreen(),
    DisplayChallengesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedIndex = (_selectedIndex + 1) % _screens.length;
            });
          },
          child: const Text('Switch Screen'),
        ),
        const SizedBox(height: 25),
        Expanded(child: _screens[_selectedIndex]),
      ],
    );
  }
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _sliderValue,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          Text('Slider Value: $_sliderValue'),
        ],
      ),
    );
  }
}

class TextBoxScreen extends StatelessWidget {
  const TextBoxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: const InputDecoration(
            labelText: 'Enter Text',
          ),
        ),
      ),
    );
  }
}