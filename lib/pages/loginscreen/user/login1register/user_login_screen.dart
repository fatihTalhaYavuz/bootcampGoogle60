import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/pwreset.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/register.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
  }

  class _UserLoginScreenState extends State<UserLoginScreen> {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void _loginUser() async{

      try {
        // Firebase Authentication ile kullanıcı girişi
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Kullanıcının Firestore'da mevcut olup olmadığını kontrol et
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          // Kullanıcı mevcut, ana sayfaya yönlendir
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const UserHomeScreen(),
            ),
          );
        } else {
          // Kullanıcı Firestore'da mevcut değil
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Hata'),
              content: Text('Kullanıcı hesabınız yok.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Giriş işlemi başarısız
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Hata'),
            content: Text('Giriş yapılamadı. Lütfen bilgilerinizi kontrol edin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          ),
        );
      }
    }

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
                        color: Colors.black, // 'Kullanıcı girişi' yazı rengi
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // E-mail TextField
                    TextField(
                      controller: _emailController,
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
                      controller: _passwordController,
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
                      onPressed: _loginUser,
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