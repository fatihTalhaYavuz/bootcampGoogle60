import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Klavye açıldığında yeniden boyutlandırmayı engeller
      extendBodyBehindAppBar: true, // AppBar'ın arka plana yayılmasını sağlar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          // Üst yeşil daire
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
          // Alt yeşil daire
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
          // İçerik
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                    const Text(
                      'Kullanıcı girişi',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // E-mail TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Şifre TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Şifre',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Şifremi unuttum işlemi
                          },
                          child: const Text('Şifremi Unuttum!'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Kayıt ol işlemi
                          },
                          child: const Text('Kayıt Ol!'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    ElevatedButton(
                      onPressed: () {
                        // Giriş yap işlemi
                      },
                      child: const Text('Giriş Yap!'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lgnbttns.withOpacity(0.72), // Buton arka plan rengini yüzde 72 şeffaf yapar
                        padding: const EdgeInsets.symmetric(
                          horizontal: 125.0,
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
