import 'package:flutter/material.dart';
import 'package:cshack_app/route_util.dart';
import 'game_screen.dart';
import 'dart:async';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({Key? key}) : super(key: key);

  @override
  _BreathingScreenState createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  double _outerCircleSize = 400.0;
  double _innerCircleSize = 200.0;
  bool _isAnimating = false;
  bool _isPaused = false;
  bool _showNextButton = false; // Variable to show/hide the "Next" button

  // Parameters for animation control
  double _enlargeDuration = 2.5; // Duration to enlarge inner circle to outer circle size
  double _pauseDuration = 4.0;   // Duration to pause at outer circle size before shrinking
  double _shrinkDuration = 1.5;  // Duration to shrink inner circle back to size 200.0
  double _beatingDuration = 1.0; // Duration for beating animation
  double _iterationPauseDuration = 3.0; // Duration to pause between iterations (1 second)

  int _animationCount = 0; // Counter for the number of iterations
  int _maxIterations = 3; // Maximum number of iterations

  Timer? _beatingTimer;
  Timer? _countdownTimer;
  int _countdownSeconds = 3; // Countdown duration in seconds
  bool _showCountdown = false;

  @override
  void dispose() {
    _beatingTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownSeconds = 3; // Initialize countdown seconds to 3
    _showCountdown = true; // Set showCountdown to true to display countdown numbers

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          _countdownTimer?.cancel();
          _showCountdown = false;
          _startAnimation();
        }
      });
    });
  }

  void _startAnimation() {
    setState(() {
      _isAnimating = true;
      _innerCircleSize = _outerCircleSize; // Enlarge inner circle to outer circle size
    });

    // After _enlargeDuration seconds, start beating animation
    Timer(Duration(seconds: _enlargeDuration.toInt()), () {
      _startBeatingAnimation();
    });
  }

  void _startBeatingAnimation() {
    setState(() {
      _isPaused = true;
    });

    // Start beating animation
    _beatingTimer = Timer.periodic(Duration(milliseconds: (_beatingDuration * 1000).toInt()), (timer) {
      setState(() {
        _innerCircleSize = _outerCircleSize - 60.0; // Slightly smaller size
      });
      Timer(Duration(milliseconds: (_beatingDuration * 500).toInt()), () {
        if (!_isPaused) {
          timer.cancel();
          return;
        }
        setState(() {
          _innerCircleSize = _outerCircleSize; // Return to outer circle size
        });
      });
    });

    // Wait for _pauseDuration seconds before starting shrink animation
    Timer(Duration(seconds: _pauseDuration.toInt()), () {
      _resetAnimation();
    });
  }

  void _resetAnimation() {
    setState(() {
      _isPaused = false;
    });

    // Shrink inner circle back to size 200.0
    Timer.periodic(Duration(milliseconds: (_shrinkDuration * 1000 / 10).toInt()), (timer) {
      setState(() {
        _innerCircleSize -= (100 / 10); // Shrink step by step over _shrinkDuration
        if (_innerCircleSize <= 200.0) {
          _innerCircleSize = 200.0;
          timer.cancel();
          _animationCount++;
          if (_animationCount < _maxIterations) {
            // Introduce a brief pause before starting the next iteration
            Timer(Duration(seconds: _iterationPauseDuration.toInt()), () {
              _startAnimation(); // Restart the animation loop
            });
          } else {
            setState(() {
              _isAnimating = false;
              _animationCount = 0; // Reset the counter
              _showNextButton = true; // Show the "Next" button
            });
          }
        }
      });
    });
  }

  Widget _buildInnerCircle() {
    return Container(
      width: _innerCircleSize,
      height: _innerCircleSize,
      child: Center(
        child: Image.asset(
          'assets/circle_icon.png', // Adjust path as per your project structure
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int sec = _countdownSeconds + 1; // Define sec variable here


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breathing Exercise',
          style: TextStyle(
            fontSize: 24.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Make it bold
            shadows: [
              BoxShadow(color: Color.fromARGB(255, 0, 173, 180), blurRadius: 2)
            ], // Add shadow
          ),
        ),
        centerTitle: true,
        elevation: 4, // Adjust elevation for shadow intensity
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/8.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content of the screen
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 200), // Adjust opacity transition duration as needed
                opacity: _showCountdown ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    '$sec', // Display sec instead of _countdownSeconds
                    style: TextStyle(
                        fontSize: 80, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 127, 80) ),// Adjust fontSize here
                  ),
                ),
              ),
              Container(
                height: 30.0, // Fixed height to occupy space when countdown text is not visible
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: _outerCircleSize,
                        height: _outerCircleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 173, 180),
                              width: 2.0),
                        ),
                      ),
                      _isPaused
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: (_beatingDuration * 1000).toInt()),
                              width: _innerCircleSize,
                              height: _innerCircleSize,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 0, 173, 180),
                                shape: BoxShape.circle,
                              ),
                            )
                          : AnimatedContainer(
                              duration: Duration(
                                  seconds: _isAnimating
                                      ? _shrinkDuration.toInt()
                                      : _enlargeDuration.toInt()),
                              width: _innerCircleSize,
                              height: _innerCircleSize,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 255, 127, 80), // Inner circle color when not paused
                                shape: BoxShape.circle,
                              ),
                            ),
                      // Centered image widget
                      Positioned(
                        child: _buildInnerCircle(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Visibility(
                  visible: !_showNextButton,
                  child: GestureDetector(
                    onTap: () {
                      if (!_isAnimating) {
                        _animationCount = 0;
                        _startCountdown(); // Start the countdown before animation
                        _showNextButton = false; // Hide the "Next" button when animation starts
                      }
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 173, 180), width: 2.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 40.0,
                          color: Color.fromARGB(
                              255, 255, 127, 80), // Play button icon color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showNextButton)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        createSlideRoute(const GameScreen()),
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.arrow_forward, color: Color.fromARGB(255, 225, 225, 225),),
                    label: Text(
                      'Next',
                      style: TextStyle(fontSize: 20.0, color: Color.fromARGB(225, 255, 225, 225)),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(140, 60), // Consistent size
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 225, 123, 80), // Background color
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
