import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  bool _isPlaying = false;
  String _audioFilePath = '';

  @override
  void initState() {
    super.initState();
    _initPlayer();
    _loadAudioFilePath();
  }

  Future<void> _initPlayer() async {
    try {
      await _player.openPlayer();
    } catch (e) {
      print('Error opening player: $e');
      // Handle error opening player
    }
  }

  Future<void> _loadAudioFilePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _audioFilePath = prefs.getString('audioFilePath') ?? '';
    });
  }

  Future<void> _saveAudioFilePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('audioFilePath', path);
  }

  Future<void> _pickAudioFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Use a file picker or any other method to select an audio file
      // For simplicity, we'll assume the file path is obtained directly here
      // Replace the next line with your file picker logic
      String filePath = '/path/to/your/audio/file.aac';

      if (await File(filePath).exists()) {
        setState(() {
          _audioFilePath = filePath;
        });
        await _saveAudioFilePath(filePath);
      } else {
        print('Selected file does not exist');
        // Handle file not found error
      }
    } else {
      print('Storage permission denied');
      // Handle storage permission denied
    }
  }

  Future<void> _startPlayback() async {
    try {
      if (_audioFilePath.isNotEmpty) {
        await _player.startPlayer(
          fromURI: _audioFilePath,
          codec: Codec.aacADTS,
          whenFinished: () {
            setState(() {
              _isPlaying = false;
            });
          },
        );

        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      print('Error starting playback: $e');
      // Handle playback start error
    }
  }

  Future<void> _stopPlayback() async {
    try {
      await _player.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error stopping playback: $e');
      // Handle playback stop error
    }
  }

  void _deleteRecording() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Recording"),
          content: Text("Are you sure you want to delete this recording?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteFile();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteFile() async {
    try {
      await _player.stopPlayer();
      if (_audioFilePath.isNotEmpty) {
        File file = File(_audioFilePath);
        if (await file.exists()) {
          await file.delete();
          setState(() {
            _audioFilePath = '';
            _isPlaying = false;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('audioFilePath');
        }
      }
    } catch (e) {
      print('Error deleting file: $e');
      // Handle file deletion error
    }
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_audioFilePath.isNotEmpty)
              Text('Audio File: $_audioFilePath'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: _pickAudioFile,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                  onPressed: () {
                    if (_isPlaying) {
                      _stopPlayback();
                    } else {
                      _startPlayback();
                    }
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _audioFilePath.isNotEmpty ? _deleteRecording : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}