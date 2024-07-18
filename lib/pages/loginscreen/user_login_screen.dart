import 'package:flutter/material.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Girişi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Kullanıcı Girişi Ekranı',
              style: TextStyle(fontSize: 24.0),
            ),
            // Diğer kullanıcı girişi içerikleri burada olacak
          ],
        ),
      ),
    );
  }
}
