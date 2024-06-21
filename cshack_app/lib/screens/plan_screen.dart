import 'package:flutter/material.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Screen'),
      ),
      body: Center(
        child: const Text('This is the Plan Screen'),
      ),
    );
  }
}
