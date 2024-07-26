import 'package:flutter/material.dart';

class ResProfile extends StatelessWidget {
  const ResProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Profile Screen '),
      ),
      body: Center(
        child: const Text('Restaurant Profile Screen Content'),
      ),
    );
  }
}
