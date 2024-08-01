import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/login2register/restaurant_login_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/user_login_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/reshomescreen.dart';
import 'chatbot_screen.dart'; // ChatBot ekranı için oluşturduğunuz dosya

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
                Container(
                  child: Image.asset(
                    'assets/logo.png', // Eski logo dosyasının yolu
                    height: 300.0,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 5.0),
                // Yeni logo ve hoş geldiniz mesajı
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Yeni logo
                    Image.asset(
                      'assets/allgoture.png', // Yeni logo dosyasının yolu
                      height: 50.0,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 0.0), // Logo ile metin arasında boşluk bırakır
                    // Hoş geldin mesajı
                    const Text(
                      ' Hoş Geldin!',
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

              ],
            ),
          ),
          // Sol alttaki chatbot butonu
          Positioned(
            bottom: 30,
            left: 5,
            child: Container(
              width: 120, // Yeni genişlik
              height: 120, // Yeni yükseklik
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent, // Şeffaf arka plan
                border: Border.all(
                  color: Colors.transparent, // Kenarlık rengi
                  width: 0,
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatBotScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/chat.gif', // Path to your GIF file
                  width: 120, // GIF boyutu
                  height: 120, // GIF boyutu
                ),
                heroTag: 'chatBotScreen',
                backgroundColor: Colors.transparent, // Şeffaf arka plan
                elevation: 0, // Gölgeyi kaldırır
              ),
            ),
          ),

        ],
      ),
    );
  }
}
