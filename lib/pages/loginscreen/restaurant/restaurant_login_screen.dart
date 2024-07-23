import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/respwreset.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/resregister.dart'; // Kayıt ekranı dosyasını import ettik

class RestaurantLoginScreen extends StatelessWidget {
  const RestaurantLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -150,
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
          Positioned(
            bottom: -180,
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
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: 100.0,
                      width: 100.0,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Restoran girişi',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Şifre',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResPwResScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Şifresmi Unuttum!',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ResRegScreen(), // Kayıt ekranı yönlendirmesi
                              ),
                            );
                          },
                          child: const Text(
                            'Kayıt OL!',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Giriş yap işlemi
                      },
                      child: const Text(
                        'Giriş Yap!',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lgnbttns.withOpacity(0.72),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80.0,
                          vertical: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
