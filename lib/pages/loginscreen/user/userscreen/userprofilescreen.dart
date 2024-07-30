import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userreservescreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false; // Düzenleme modunu kontrol eder
  final TextEditingController emailController = TextEditingController(text: 'all.gotur@gmail.com');
  final TextEditingController nameController = TextEditingController(text: 'ALİ GÖTÜR');
  final TextEditingController phoneController = TextEditingController(text: '0 505 505 55 00');
  final TextEditingController addressController = TextEditingController(text: 'Kadıköy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar yüksekliği
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Geri ok ikonu
          onPressed: () {
            Navigator.pop(context); // Önceki ekrana dön
          },
        ),
        title: Align(
          alignment: Alignment(-0.2, 0), // Hafif sola hizalanmış
          child: Image.asset(
            'assets/allgotur.png',
            height: 80.0, // Logo boyutu
          ),
        ),
      ),
      body: Stack(
        children: [
          // Üst daire
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.3),
              ),
            ),
          ),
          // Alt daire
          Positioned(
            bottom: -180,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.3),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: kToolbarHeight + 50), // AppBar yüksekliği + 20 piksel boşluk
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Text(
                        'KULLANICI HESABIM',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _buildInfoRow(Icons.email, emailController.text), // E-posta bilgisi
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.person, nameController.text), // İsim bilgisi
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.phone, phoneController.text), // Telefon bilgisi
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.location_on, addressController.text), // Adres bilgisi
                      const SizedBox(height: 30.0), // Butonlar arasındaki boşluk artırıldı
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const AppOpenScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Arka plan rengi
                          padding: EdgeInsets.symmetric(horizontal: 50.0), // Buton yastığı
                        ),
                        child: Text('ÇIKIŞ YAP'),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing; // Düzenleme modunu değiştir
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Arka plan rengi
                          padding: EdgeInsets.symmetric(horizontal: 50.0), // Buton yastığı
                        ),
                        child: Text(isEditing ? 'Kaydet' : 'Bilgilerimi Düzenle'), // Buton metni
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Yüzen eylem düğmesi
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0), // Alt yastık
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserReserve(), // Uygun ekran ile güncelle
                    ),
                  );
                },
                backgroundColor: Colors.transparent, // Şeffaf arka plan
                elevation: 0, // Gölge yok
                child: SizedBox.shrink(), // Boş düğme
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // Notch şekli
        notchMargin: 10.0, // Notch marjı
        color: Color.fromARGB(255, 255, 255, 255), // Arka plan rengi
        elevation: 0, // Gölge yok
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png',
                  width: 80.0, height: 80.0), // Boyut ayarlandı
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserHomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 40.0), // Ana sayfa ve profil arasında boşluk
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserReserve(),
                  ),
                );
              },
              backgroundColor: Colors.transparent, // Şeffaf arka plan
              elevation: 0, // Gölge yok
              child: Image.asset('assets/shopping.png',
                  width: 100.0, height: 100.0), // Boyut ayarlandı
            ),
            SizedBox(width: 40.0), // Profil ve yüzen düğme arasında boşluk
            IconButton(
              icon: Image.asset('assets/profile.png',
                  width: 80.0, height: 80.0), // Boyut ayarlandı
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Bilgi satırı oluşturma fonksiyonu
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 30.0), // İkon boyutu
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: TextEditingController(text: text), // Metin kontrolcüsü
            enabled: isEditing, // Düzenleme moduna göre etkinleştirilir
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0), // Kenar yuvarlama
              ),
              filled: true,
              fillColor: Colors.green.withOpacity(0.1), // Doldurulmuş arka plan rengi
            ),
          ),
        ),
      ],
    );
  }
}
