import 'package:flutter/material.dart';

class app_open extends StatefulWidget {
  const app_open({super.key});

  @override
  State<app_open> createState() => _app_openState();
}

class _app_openState extends State<app_open> {
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