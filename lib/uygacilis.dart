import 'package:flutter/material.dart';

class UygAcilis extends StatefulWidget {
  const UygAcilis({super.key});

  @override
  State<UygAcilis> createState() => _UygAcilisState();
}

class _UygAcilisState extends State<UygAcilis> {
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