import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/user_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_bootcamp_60/districts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = true; // Checkbox'un başlangıç durumu

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String selectedDistrict = '';


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
                      'Kayıt OL!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Başlık yazısını siyah yapar
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Ad Soyad TextField
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Ad Soyad',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Telefon Numarası TextField
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'Telefon Numarası',
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintStyle: const TextStyle(color: Colors.black), // Placeholder yazısını siyah yapar
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Mail TextField
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Mail',
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
                      controller: _passwordController,
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
                    // İlçe Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedDistrict.isEmpty ? null : selectedDistrict,
                      hint: const Text('İlçe seçiniz'),
                      items: Districts.istanbulDistricts.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDistrict = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: lgnback,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Kullanım ve Gizlilik Şartları
                    CheckboxListTile(
                      title: const Text(
                        'Kullanım ve Gizlilik Şartları\'nı okudum ve kabul ediyorum.',
                        style: TextStyle(color: Colors.black), // Metin yazısını siyah yapar
                      ),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      checkColor: Colors.white, // Checkbox tik rengini beyaz yapar
                      activeColor: Colors.black, // Checkbox arka plan rengini siyah yapar
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Kayıt ol işlemi
                        if (_nameController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            !isChecked ||
                            selectedDistrict.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Lütfen tüm alanları doldurun ve şartları kabul edin.')),
                          );
                          return;
                        }

                        try {
                          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          await _firestore.collection('users').doc(userCredential.user!.uid).set({
                            'name': _nameController.text,
                            'phone': _phoneController.text,
                            'email': _emailController.text,
                            'district': selectedDistrict,
                            'role': 'user',
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserLoginScreen(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Kayıt sırasında bir hata oluştu: $e')),
                          );
                        }
                      },
                      child: const Text(
                        'Kayıt OL!',
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
                    const SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserLoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Hesabım VAR!',
                        style: TextStyle(color: Colors.black), // Metin yazısını siyah yapar
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
