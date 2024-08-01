import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resaddscreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/restreserves.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_bootcamp_60/districts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // AnimatedTextKit paketi

class ResHomeScreen extends StatefulWidget {
  const ResHomeScreen({super.key});

  @override
  _ResHomeScreenState createState() => _ResHomeScreenState();
}

class _ResHomeScreenState extends State<ResHomeScreen> {
  String userUID = ''; // Kullanıcı UID'si
  String selectedLocation = ''; // Dinamik lokasyon
  final PageController _controller = PageController(); // Kaydırma
  bool _isTextVisible = true; // Metin görünürlüğü kontrolü

  @override
  void initState() {
    super.initState();
    _getUserUID();
  }

  Future<void> _getUserUID() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userUID = user.uid;
        });
        await _fetchUserLocation(); // Kullanıcının lokasyonunu çek
      } else {
        // Kullanıcı mevcut değilse, kullanıcıyı giriş yapmaya yönlendir
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AppOpenScreen(), // Giriş ekranına yönlendir
          ),
        );
      }
    } catch (e) {
      print('Kullanıcı UID alınırken hata oluştu: $e');
    }
  }

  Future<void> _fetchUserLocation() async {
    try {
      // Tüm lokasyonları çek
      List<String> districts = ['Adalar', 'Arnavutköy', 'Üsküdar']; // Örnek lokasyonlar

      for (String district in Districts.istanbulDistricts) {
        DocumentSnapshot? userDoc = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(district)
            .collection('details')
            .doc(userUID)
            .get();

        if (userDoc.exists) {
          setState(() {
            selectedLocation = district; // Kullanıcının bulunduğu lokasyonu ayarla
          });
          break; // Kullanıcı bulundu, döngüden çık
        }
      }
    } catch (e) {
      print('Kullanıcının lokasyonu alınırken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 90.0),
                  child: Image.asset(
                    'assets/allgotur.png',
                    height: 90.0,
                    width: 90.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Image.asset(
                'assets/zerogoal.png',
                width: 90.0,
                height: 90.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RestReserve(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
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
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 85),
              Container(
                height: 220.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 5)],
                ),
                clipBehavior: Clip.antiAlias,
                child: PageView(
                  controller: _controller,
                  children: [
                    Image.asset('assets/banner5.gif', fit: BoxFit.cover),
                    Image.asset('assets/banner4.gif', fit: BoxFit.cover),
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 16,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 318,
            left: 5,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RestReserve(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/chat.gif',
                  width: 120,
                  height: 120,
                ),
                heroTag: 'chatBotScreen',
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
          Positioned(
            bottom: 318, // Adjust this value based on your design
            left: 120, // Adjust this value based on your design
            child: AnimatedOpacity(
              opacity: _isTextVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 30), // Animation duration
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TypewriterAnimatedTextKit(
                  text: [
                    'Bana sürdürülebilir yaşam \nhedefleri hakkında soru sor...',
                  ],
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                  speed: Duration(milliseconds: 100), // Yazma hızı
                  repeatForever: true,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResHomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 90.0),
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResProfile(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResAddScreen(),
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset('assets/plus.png', width: 130.0, height: 130.0),
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('restaurants')
          .doc(selectedLocation)
          .collection('details')
          .doc(userUID)
          .collection('yemekler')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Yemek bulunamadı.'));
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return _buildProductItem(
              context,
              data['imageUrl'] ?? '',
              data['aciklama'] ?? 'Açıklama yok',
              data['yemekMiktari'] ?? 'Miktar yok',
              data['yemekTuru'] ?? 'Tür yok',
              data['ilanBasligi'] ?? 'Başlık yok',
              '${data['yemekZamani'] ?? '0.0'}',
              Colors.grey[200]!,
              Colors.white,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RestReserve(),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildProductItem(BuildContext context, String logoPath, String exp,
      int quantity, String type, String baslik, String time, Color logoBgColor,
      Color cardBgColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: logoBgColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.network(logoPath, width: 60.0, height: 60.0, fit: BoxFit.cover),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(baslik, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Text(type, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
                  Text(exp, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                Text(quantity.toString(), style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
