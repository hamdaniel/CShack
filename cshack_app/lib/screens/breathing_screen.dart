import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedCircleScreen extends StatefulWidget {
  const AnimatedCircleScreen({Key? key}) : super(key: key);

  @override
  _AnimatedCircleScreenState createState() => _AnimatedCircleScreenState();
}

class _AnimatedCircleScreenState extends State<AnimatedCircleScreen> {
  double _circleSize = 50.0;
  double _animationDuration = 2.0;
  int _countdown = 3;
  Timer? _timer;
  bool _isAnimating = false;

  void _startAnimation() {
    setState(() {
      _circleSize = 200.0;
      _isAnimating = true;
    });
  }

  void _startCountdown() {
    _countdown = 3;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
        _startAnimation();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void _resetAnimation() {
    setState(() {
      _circleSize = 50.0;
      _isAnimating = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: _animationDuration,
          min: 0.5,
          max: 5.0,
          divisions: 9,
          label: '${_animationDuration.toStringAsFixed(1)} seconds',
          onChanged: (newValue) {
            setState(() {
              _animationDuration = newValue;
            });
          },
        ),
        GestureDetector(
          onLongPressStart: (_) {
            _startCountdown();
          },
          onLongPressEnd: (_) {
            if (!_isAnimating) {
              _timer?.cancel();
              setState(() {
                _countdown = 3;
              });
            }
          },
          child: ElevatedButton(
            onPressed: _isAnimating ? _resetAnimation : null,
            child: Text(_isAnimating ? 'Reset Animation' : 'Press and Hold for Animation'),
          ),
        ),
        const SizedBox(height: 20),
        if (_countdown < 3 && !_isAnimating)
          Text(
            '$_countdown',
            style: TextStyle(fontSize: 32),
          ),
        AnimatedContainer(
          duration: Duration(seconds: _animationDuration.toInt()),
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          onEnd: () {
            _resetAnimation();
          },
        ),
      ],
    );
  }
}