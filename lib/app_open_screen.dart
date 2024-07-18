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
      body: Stack(
        children: [
          // Üst yeşil daire
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Alt yeşil daire
          Positioned(
            bottom: -180,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // İçerik
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png', // Logo dosyasının yolu
                  height: 100.0,
                  width: 100.0,
                ),
                SizedBox(height: 20.0),
                // Hoş geldin mesajı
                Text(
                  'All Götür\'e Hoş Geldin!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Restoranların israfını engellemek amacıyla\nsen de uygun saati yakala, bedava yemeğini kap!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30.0),
                // Butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Kullanıcı girişi butonu
                    ElevatedButton(
                      onPressed: () {
                        // Kullanıcı girişi işlemi
                      },
                      child: Text('Kullanıcı girişi'),
                    ),
                    SizedBox(width: 20.0),
                    // Restoran girişi butonu
                    ElevatedButton(
                      onPressed: () {
                        // Restoran girişi işlemi
                      },
                      child: Text('Restoran girişi'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
