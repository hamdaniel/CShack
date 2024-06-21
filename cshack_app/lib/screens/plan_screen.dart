import 'package:cshack_app/screens/challenge_screen.dart';
import 'package:cshack_app/screens/daily_planning_screen.dart';
import 'package:flutter/material.dart';
import 'package:cshack_app/route_util.dart';
import 'screen2.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  String _selectedPlan = 'Button 1'; // Default selected plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Replace with your image name
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildCustomButton('Water Bodies Plan', 'Water Bodies Plan'),
              SizedBox(height: 16.0),
              buildCustomButton('Crowded Places Plan', 'Crowded Places Plan'),
              SizedBox(height: 16.0),
              buildCustomButton('Loud Noises Plan', 'Loud Noises Plan'),
              SizedBox(height: 16.0),
              buildChoiceButton('Customized Plan (Therapist)'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomButton(String buttonText, String planName) {
    bool isSelected = _selectedPlan == planName;

    return Container(
      height: 100.0, // Adjust height as needed
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.orange.withOpacity(0.5), // Filled with orange
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected ? Colors.red : Colors.transparent, // Red outline if selected
          width: isSelected ? 4.0 : 2.0, // Thick border if selected, otherwise thin
        ),
      ),
      child: TextButton(
        onPressed: () {
          _selectPlan(planName);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildChoiceButton(String buttonText) {
    bool isSelected = _selectedPlan == 'Customized Plan (Therapist)';

    return Container(
      height: 100.0, // Adjust height as needed
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.orange.withOpacity(0.5), // Filled with orange
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected ? Colors.red : Colors.transparent, // Red outline if selected
          width: isSelected ? 4.0 : 2.0, // Thick border if selected, otherwise thin
        ),
      ),
      child: TextButton(
        onPressed: () {
          _showChoiceDialog();
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _selectPlan(String planName) {
    setState(() {
      _selectedPlan = planName;
    });
    print('Selected Plan: $_selectedPlan');
  }

  void _showChoiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose type of activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    createSlideRoute(ChallengeScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 173, 180)), // Background color
                  foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
                  minimumSize: MaterialStateProperty.all(Size(150, 50)), // Button width and height
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Button border radius
                    ),
                  ),
                ),
                child: Text(
                  'Daily',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16.0),
             ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    createSlideRoute(ChallengeScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 173, 180)), // Background color
                  foregroundColor: MaterialStateProperty.all(Colors.white), // Text color
                  minimumSize: MaterialStateProperty.all(Size(150, 50)), // Button width and height
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Button border radius
                    ),
                  ),
                ),
                child: Text(
                  'Challenge',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        _selectPlan(value);
      }
    });
  }
}