import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';

class ResRegScreen extends StatelessWidget {
  const ResRegScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Klavye açıldığında yeniden boyutlandırmayı engeller
      extendBodyBehindAppBar: true, // AppBar'ın arka plana yayılmasını sağlar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar'ı şeffaf yapar
        elevation: 0, // AppBar'ın gölgesini kaldırır
        iconTheme: const IconThemeData(color: Colors.black), // Geri butonunun rengini siyah yapar
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
                      'Kayıt Ol',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Başlık yazısını siyah yapar
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Kullanıcı Adı TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Kullanıcı Adı',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
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
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
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
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
                      ),
                      obscureText: true, // Şifre alanını gizli yapar
                    ),
                    const SizedBox(height: 20.0),
                    // Şifre Onayı TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Şifre Onayı',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
                      ),
                      obscureText: true, // Şifre alanını gizli yapar
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Kayıt işlemi yapılacak yer
                      },
                      child: const Text(
                        'Kayıt Ol!',
                        style: TextStyle(color: Colors.white), // Buton içindeki yazıyı beyaz yapar
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lgnbttns.withOpacity(0.72), // Buton arka plan rengini yüzde 72 şeffaf yapar
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
