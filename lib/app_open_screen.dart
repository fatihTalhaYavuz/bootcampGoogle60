import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/reshomescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'pages/loginscreen/user/login1register/user_login_screen.dart';
import 'pages/loginscreen/restaurant/login2register/restaurant_login_screen.dart';

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
                // Logo
                Image.asset(
                  'assets/logo.png', // Logo dosyasının yolu
                  height: 100.0,
                  width: 100.0,
                ),
                const SizedBox(height: 20.0),
                // Hoş geldin mesajı
                const Text(
                  'All Götür\'e Hoş Geldin!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
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
                        style: TextStyle(color: Colors.black), // Metin rengini mavi yapar
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonrenkana, // Buton arka plan rengini sarı yapar
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
                        style: TextStyle(color: Colors.black), // Metin rengini mavi yapar
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonrenkana, // Buton arka plan rengini turuncu yapar
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Sağ alttaki iki buton
          Positioned(
            bottom: 30,
            right: 30,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserHomeScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.person),
                  heroTag: 'userHomeScreen',
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResHomeScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.restaurant),
                  heroTag: 'resHomeScreen',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
