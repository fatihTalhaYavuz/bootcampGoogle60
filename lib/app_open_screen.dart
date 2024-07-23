import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'pages/loginscreen/user_login_screen.dart';
import 'pages/loginscreen/restaurant_login_screen.dart';

class AppOpenScreen extends StatefulWidget {
  const AppOpenScreen({super.key});

  @override
  State<AppOpenScreen> createState() => _AppOpenScreenState();
}

class _AppOpenScreenState extends State<AppOpenScreen> {
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
                // Eski logo
                Image.asset(
                  'assets/logoallgotur.png', // Eski logo dosyasının yolu
                  height: 150.0,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 20.0),
                // Yeni logo ve hoş geldiniz mesajı
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Yeni logo
                    Image.asset(
                      'assets/allgotur.png', // Yeni logo dosyasının yolu
                      height: 50.0,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 10.0), // Logo ile metin arasında boşluk bırakır
                    // Hoş geldin mesajı
                    const Text(
                      'Hoş Geldiniz!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Restoranların israfını engellemek amacıyla\nsen de uygun saati yakala, bedava yemeğini kap!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                // Butonlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Kullanıcı girişi butonu
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserLoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Kullanıcı girişi',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonrenkana,
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    // Restoran girişi butonu
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantLoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Restoran girişi',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonrenkana,
                      ),
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
