import 'package:flutter/material.dart';
import 'dart:async';

// Define Challenge class as before...
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

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List<Challenge> challenges = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(challenges[index].title),
                  subtitle: Text(
                      'Duration: ${_formatDuration(challenges[index].duration)}, Repeat: ${challenges[index].repeatCount}, Reward: ${challenges[index].reward}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final editedChallenge = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateChallengeScreen(
                                challenge: challenges[index],
                              ),
                            ),
                          );
                          if (editedChallenge != null) {
                            setState(() {
                              challenges[index] = editedChallenge;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteDialog(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newChallenge = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateChallengeScreen()),
          );
          if (newChallenge != null) {
            setState(() {
              challenges.add(newChallenge);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 255, 127, 80),
        foregroundColor: Colors.white,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Challenge"),
          content: Text("Are you sure you want to delete this challenge?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  challenges.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}

class CreateChallengeScreen extends StatefulWidget {
  final Challenge? challenge;

  CreateChallengeScreen({this.challenge});

  @override
  _CreateChallengeScreenState createState() => _CreateChallengeScreenState();
}

class _CreateChallengeScreenState extends State<CreateChallengeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _repeatCount = 1;
  int _reward = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.challenge?.title ?? '');
    if (widget.challenge != null) {
      _hours = widget.challenge!.duration.inHours;
      _minutes = widget.challenge!.duration.inMinutes.remainder(60);
      _seconds = widget.challenge!.duration.inSeconds.remainder(60);
      _repeatCount = widget.challenge!.repeatCount;
      _reward = widget.challenge!.reward;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.challenge == null ? 'Create Challenge' : 'Edit Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _hours.toString(),
                      decoration: InputDecoration(labelText: 'Hours'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _hours = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: _minutes.toString(),
                      decoration: InputDecoration(labelText: 'Minutes'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _minutes = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      initialValue: _seconds.toString(),
                      decoration: InputDecoration(labelText: 'Seconds'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _seconds = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _repeatCount.toString(),
                decoration: InputDecoration(labelText: 'Repeat Count'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _repeatCount = int.tryParse(value) ?? 1;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _reward.toString(),
                decoration: InputDecoration(labelText: 'Reward'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _reward = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newChallenge = Challenge(
                          title: _titleController.text,
                          duration: Duration(hours: _hours, minutes: _minutes, seconds: _seconds),
                          repeatCount: _repeatCount,
                          reward: _reward,
                        );
                        Navigator.pop(context, newChallenge);
                      }
                    },
                    child: Transform.translate(
                      offset: Offset(-2, -5), // Adjust the offset values to move the icon
                      child: Icon(Icons.check, size: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 173, 180),
                      foregroundColor: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      fixedSize: Size(56, 56),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to previous screen
                  },
                  child: Icon(Icons.home),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
