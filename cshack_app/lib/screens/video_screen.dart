import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'screen2.dart';
import '../route_util.dart'; // Import the route utility file

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://www.youtube.com/watch?v=t3uK039WdaM', // Replace with your video URL
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Screen'),
      ),
      body: Column(
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.of(context).pushAndRemoveUntil(
                    createSlideRoute(const Screen2()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
