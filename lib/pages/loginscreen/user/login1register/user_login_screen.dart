import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/pwreset.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/register.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';


late String email, password;
final formKey = GlobalKey<FormState>();
final firebaseAuth = FirebaseAuth.instance;

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
          Form(
            key: formKey,
            child: Center(
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
                      emailTextField(),
                      const SizedBox(height: 20.0),
                      // Şifre TextField
                      passwordTextField(),
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
                      const SizedBox(height: 20.0),
                      loginButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: lgnback,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    hintStyle: const TextStyle(color: Colors.black),
  ); // Placeholder yazısını siyah yapar
}

TextFormField emailTextField() {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return "Bilgileri Eksiksiz Doldurunuz.";
      }
      return null;
    },
    onSaved: (value) {
      email = value!;
    },
    decoration: customInputDecoration("E-mail"),
  );
}

TextFormField passwordTextField() {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return "Bilgileri Eksiksiz Doldurunuz.";
      }
      return null;
    },
    onSaved: (value) {
      password = value!;
    },
    decoration: customInputDecoration("Şifre"),
    obscureText: true,
  );
}

Center loginButton(BuildContext context) {
  return Center(
    child: TextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) { //firebase için tıkladığında veriyi alıp gönderm
          formKey.currentState!.save();

          try {
            await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const UserHomeScreen()), // UserHomePage yönlendirmesi
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Giriş başarılı")),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Giriş başarısız: ${e.toString()}")),
            );
          }
        }
      },
      child: const Text(
        'Giriş Yap!',
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
  );
}
