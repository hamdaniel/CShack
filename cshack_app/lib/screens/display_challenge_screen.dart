import 'package:flutter/material.dart';
import 'dart:async';

class DisplayChallengesScreen extends StatefulWidget {
  const DisplayChallengesScreen({Key? key}) : super(key: key);

  @override
  _DisplayChallengesScreenState createState() => _DisplayChallengesScreenState();
}

class Challenge {
  String title;
  Duration duration;
  int repeatCount;
  int reward;

  Challenge({
    required this.title,
    required this.duration,
    required this.repeatCount,
    required this.reward,
  });
}

class _DisplayChallengesScreenState extends State<DisplayChallengesScreen> {
  late List<Challenge> challenges;
  List<Duration> timeElapsed = [];
  List<int> timesCompleted = [];
  List<Timer?> timers = [];

  @override
  void initState() {
    super.initState();

    // Initialize the challenges
    challenges = [
      Challenge(
        title: 'Visit the Park',
        duration: Duration(minutes: 15),
        repeatCount: 2,
        reward: 500,
      ),
      Challenge(
        title: 'Imaginal Exposure',
        duration: Duration(minutes: 25),
        repeatCount: 1,
        reward: 1500,
      ),
    ];

    // Initialize other lists based on the number of challenges
    timeElapsed = List.generate(challenges.length, (_) => Duration());
    timesCompleted = List.generate(challenges.length, (_) => 0);
    timers = List.generate(challenges.length, (_) => null);
  }

  void _startChallenge(int index) {
    if (timers[index] == null) {
      setState(() {
        timers[index] = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            timeElapsed[index] += Duration(seconds: 1);
            if (timeElapsed[index] >= challenges[index].duration) {
              timeElapsed[index] = Duration();
              timesCompleted[index]++;
              if (timesCompleted[index] >= challenges[index].repeatCount) {
                timers[index]?.cancel();
                timers[index] = null;
              }
            }
          });
        });
      });
    }
  }

  @override
  void dispose() {
    // Cancel all timers when disposing the screen
    timers.forEach((timer) {
      timer?.cancel();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Challenges'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Replace with your image name
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            final elapsedTime = timeElapsed[index];
            final repeatCount = challenge.repeatCount;
            final timesCompletedCount = timesCompleted[index];
            final isInProgress = timers[index] != null;
            final formattedElapsedTime =
                "${elapsedTime.inHours.toString().padLeft(2, '0')}:${elapsedTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${elapsedTime.inSeconds.remainder(60).toString().padLeft(2, '0')}";

            return Card(
              margin: EdgeInsets.all(10),
              color: Colors.white.withOpacity(0.9), // Adjust opacity here
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      challenge.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: elapsedTime.inSeconds / challenge.duration.inSeconds,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                    SizedBox(height: 10),
                    Text(formattedElapsedTime, style: TextStyle(fontSize: 18, color: Colors.black)),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: timesCompletedCount / repeatCount,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$timesCompletedCount / $repeatCount times completed',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: isInProgress ? null : () => _startChallenge(index),
                      child: Text(isInProgress ? 'In Progress' : 'Start', style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 173, 180), // background color
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/carrot.png', // Replace with your image path
                            height: 35.0,
                            width: 35.0,
                          ),
                          SizedBox(width: 5),
                          Text(challenge.reward.toString(), style: TextStyle(fontSize: 16, color: Colors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
