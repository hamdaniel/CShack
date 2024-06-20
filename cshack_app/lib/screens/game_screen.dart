import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Game variables
  double birdY = 0;
  double initialBirdY = 0;
  double time = 0;
  double height = 0;
  double gravity = -4.9;
  double velocity = 2.8;
  bool gameHasStarted = false;
  double birdWidth = 0.1; // 10% of screen width
  double birdHeight = 0.1; // 10% of screen height
  int score = 0;
  int highScore = 0;

  // Obstacle variables
  static double obstacleX = 1;
  static double obstacleWidth = 0.2; // 20% of screen width
  static List<double> obstacleHeight = [0.6, 0.4]; // Heights of the two obstacles
  double obstacleGap = 0.2; // 20% of screen height

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  void _loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = (prefs.getInt('highScore') ?? 0);
    });
  }

  void _updateHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (score > highScore) {
      setState(() {
        highScore = score;
      });
      prefs.setInt('highScore', highScore);
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialBirdY = birdY;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialBirdY - height;
        obstacleX -= 0.08;

        // Check if obstacle is out of screen
        if (obstacleX < -1.5) {
          obstacleX += 3;
          obstacleHeight = [Random().nextDouble() * 0.6, Random().nextDouble() * 0.4];
          score++;
        }

        // Check for collision with ground or ceiling
        if (birdY > 1 || birdY < -1) {
          timer.cancel();
          gameHasStarted = false;
          _updateHighScore();
          showGameOverDialog();
        }

        // Check for collision with obstacles
        if (obstacleX < birdWidth && obstacleX > -birdWidth) {
          if (birdY < -1 + obstacleHeight[0] || birdY > 1 - obstacleHeight[1]) {
            timer.cancel();
            gameHasStarted = false;
            _updateHighScore();
            showGameOverDialog();
          }
        }
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your score: $score\nHigh score: $highScore"),
          actions: <Widget>[
            TextButton(
              child: Text("Restart"),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      birdY = 0;
      initialBirdY = 0;
      time = 0;
      height = 0;
      gravity = -4.9;
      velocity = 2.8;
      gameHasStarted = false;
      obstacleX = 1;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        // Bird
                        Center(
                          child: Container(
                            alignment: Alignment(0, birdY),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Obstacles
                        Container(
                          alignment: Alignment(obstacleX, 1.1),
                          child: Container(
                            width: MediaQuery.of(context).size.width * obstacleWidth / 2,
                            height: MediaQuery.of(context).size.height * obstacleHeight[0] / 3,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        Container(
                          alignment: Alignment(obstacleX, -1.1),
                          child: Container(
                            width: MediaQuery.of(context).size.width * obstacleWidth / 2,
                            height: MediaQuery.of(context).size.height * obstacleHeight[1] / 3,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        // Score
                        Positioned(
                          top: 50,
                          left: 20,
                          child: Text(
                            'Score: $score',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.blueAccent,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // High Score
                        Positioned(
                          top: 50,
                          right: 20,
                          child: Text(
                            'High Score: $highScore',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.blueAccent,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}