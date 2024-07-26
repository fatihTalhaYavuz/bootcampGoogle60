import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/colors.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/login1register/user_login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
late String  email, password;
final formkey=GlobalKey<FormState>();
final firebaseAuth= FirebaseAuth.instance;
class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = true; // Checkbox'un başlangıç durumu

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
                child: Form(
                  key: formkey,
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

                      usernameTextField(), // isim soyisim metodu
                      const SizedBox(height: 20.0),

                      mobileNumberTextField(), //tel no metodu
                      const SizedBox(height: 20.0),

                      emailTextField(), //e-mail metodu
                      const SizedBox(height: 20.0),

                      passwordTextField(),//şifre metodu
                      const SizedBox(height: 20.0),

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

                      registerButton(context),

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
          ),
        ],
      ),
    );
  }
}

TextFormField usernameTextField(){
  return TextFormField(
    decoration: customInputDecoration("Ad Soyad"),

  );
}
TextFormField mobileNumberTextField(){
  return TextFormField(
    decoration: customInputDecoration("Telefon Numarası"),

  );
}TextFormField emailTextField(){
  return TextFormField(
    validator: (value){
      if(value!.isEmpty){
        return "Bilgileri Eksiksiz Doldurunuz.";
      }else {

      }
    },
    onSaved: (value){
      email=value!;

    },
    decoration: customInputDecoration("E-mail"),

  );
}TextFormField passwordTextField(){
  return TextFormField(
    validator: (value){
      if(value!.isEmpty){
        return "Bilgileri Eksiksiz Doldurunuz.";
      }else {

      }
    },
    onSaved: (value){
      password=value!;

    },
    decoration: customInputDecoration("Şifre"),
    obscureText: true,

  );
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
  );// Placeholder yazısını siyah yapar)

}
Center registerButton(BuildContext context){
  return Center(
    child:TextButton(
      onPressed: () async {
        if(formkey.currentState!.validate()){ //firebase için tıkladığında veriyi alıp gönderm

          formkey.currentState!.save();
          try{
            var userResult=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
            formkey.currentState!.reset();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Kayıt başarılı, lütfen giriş sayfasına gidin.")),
            );
          } catch (e) {
            print(e.toString());

          }catch(e){
            print(e.toString());
          }
        } else{}
        // Kayıt ol işlemi
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
  );
}
