import 'package:cshack_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cshack_app/route_util.dart';

class DailyPlanningScreen extends StatefulWidget {
  const DailyPlanningScreen({Key? key}) : super(key: key);

  @override
  _DailyPlanningScreenState createState() => _DailyPlanningScreenState();
}

class _DailyPlanningScreenState extends State<DailyPlanningScreen> {
  final List<Map<String, dynamic>> _exercises = [
    {'task': 'Exercise', 'sliderValue': 1.0},
    {'task': 'Meditate', 'sliderValue': 1.0},
  ];

  final List<Map<String, dynamic>> _games = [
    {'task': 'Play Chess', 'sliderValue': 1.0},
    {'task': 'Play Basketball', 'sliderValue': 1.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Planning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Exercises',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._exercises.map((exercise) => _buildSliderTile(exercise)),
                  const SizedBox(height: 16),
                  const Text(
                    'Games',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ..._games.map((game) => _buildSliderTile(game)),
                ],
              ),
            ),
            const SizedBox(height: 50),  // Increased height to raise the button more
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        createSlideRoute(const HomeScreen()),
                        (route) => false,
                      );
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderTile(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['task']),
          Row(
            children: [
              const Text('1'),
              Expanded(
                child: Slider(
                  value: item['sliderValue'],
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: item['sliderValue'].round().toString(),
                  activeColor: Colors.orange,  // Set the active color to orange
                  inactiveColor: Colors.orange.shade100,  // Set the inactive color to a lighter shade of orange
                  onChanged: (newValue) {
                    setState(() {
                      item['sliderValue'] = newValue;
                    });
                  },
                ),
              ),
              const Text('5'),
            ],
          ),
        ],
      ),
    );
  }
}
