import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/pwreset.dart';
import 'package:google_bootcamp_60/pages/loginscreen/register.dart';

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
        iconTheme: const IconThemeData(color: Colors.black), // AppBar simge rengi
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
                      'assets/logoallgotur.png', // Logo dosyasının yolu
                      height: 150.0,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Kullanıcı girişi',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // 'Kullanıcı girişi' yazı rengi
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // E-mail TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        hintStyle: TextStyle(
                          color: Colors.black, // 'E-mail' ipucu yazı rengi
                        ),
                        filled: true,
                        fillColor: lgnback, // TextField arka plan rengi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // Girilen e-posta yazı rengi
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Şifre TextField
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Şifre',
                        hintStyle: TextStyle(
                          color: Colors.black, // 'Şifre' ipucu yazı rengi
                        ),
                        filled: true,
                        fillColor: lgnback, // TextField arka plan rengi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black, // Girilen şifre yazı rengi
                      ),
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
                                builder: (context) => const PwResetScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Şifremi Unuttum!',
                            style: TextStyle(
                              color: Colors.black, // 'Şifremi Unuttum!' yazı rengi
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Kayıt Ol!',
                            style: TextStyle(
                              color: Colors.black, // 'Kayıt Ol!' yazı rengi
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    ElevatedButton(
                      onPressed: () {
                        // Giriş yap işlemi
                      },
                      child: const Text(
                        'Giriş Yap!',
                        style: TextStyle(
                          color: Colors.white, // Buton yazı rengi
                        ),
                      ),
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