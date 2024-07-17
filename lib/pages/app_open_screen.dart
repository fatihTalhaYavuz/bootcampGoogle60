import 'package:flutter/material.dart';

class app_open_screen extends StatefulWidget {
  const app_open_screen({super.key});

  @override
  State<app_open_screen> createState() => _app_open_screenState();
}

class _app_open_screenState extends State<app_open_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uygulama Açılış Ekranı'),
      ),
      body: const Center(
        child: Text('Merhaba Flutter Grubu 60!'),
      ),
    );
  }
}