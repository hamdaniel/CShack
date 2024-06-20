import 'package:cshack_app/screens/avatar_selection_screen.dart';
import 'package:cshack_app/screens/daily_planning_screen.dart';
import 'package:cshack_app/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'screens/breathing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    AvatarSelectionScreen(),
    DailyPlanningScreen(), 
    StatisticsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedIndex = (_selectedIndex + 1) % _screens.length;
            });
          },
          child: const Text('Switch Screen'),
        ),
        const SizedBox(height: 20),
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