import 'package:flutter/material.dart';

class RestaurantLoginScreen extends StatelessWidget {
  const RestaurantLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restoran Girişi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Restoran Girişi Ekranı',
              style: TextStyle(fontSize: 24.0),
            ),
            // Diğer restoran girişi içerikleri burada olacak
          ],
        ),
      ),
    );
  }
}
