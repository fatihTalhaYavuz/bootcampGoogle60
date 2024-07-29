import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';

class ResAddScreen extends StatelessWidget {
  const ResAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar yüksekliği
        title: Row(
          children: [
            // Konum seçimi bölümü
            Padding(
              padding: const EdgeInsets.only(right: 16.0), // Logo ve konum seçimi arasına boşluk ekle
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İstanbul',
                        style: TextStyle(
                          fontSize: 14.0, // Daha küçük font boyutu
                          color: Colors.green,
                        ),
                      ),
                      DropdownButton<String>(
                        value: 'Kadıköy', // Varsayılan değer
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        onChanged: (String? newValue) {
                          // Konum değişikliği işleme
                        },
                        items: <String>['Kadıköy', 'Beşiktaş', 'Şişli']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Logo bölümü
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft, // Resmi sola hizalar
                child: Container(
                  margin: const EdgeInsets.only(right: 60.0), // Resmi sola kaydırmak için margin ekleyin
                  child: Image.asset(
                    'assets/allgotur.png',
                    height: 120.0, // Resmin boyutunu ayarlayın
                    width: 120.0, // Genişlik ayarı
                    fit: BoxFit.contain, // Resmin orantılı şekilde görünmesini sağlar
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/zerogoal.png',
              width: 50.0, // Sepet ikonunun genişliği arttırıldı
              height: 50.0, // Sepet ikonunun yüksekliği arttırıldı
            ),
            onPressed: () {
              // Sepet butonu fonksiyonu
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Üst yeşil daire
          Positioned(
            top: -150,
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
          // Alt yeşil daire
          Positioned(
            bottom: -180,
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
          // Form ve içerik
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: kToolbarHeight + 30), // AppBar sonrası boşluk
                  Center(
                    child: Image.asset(
                      'assets/bagis.png',
                      height: 80.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Bağış Oluştur',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'İlan Başlığı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    value: 'Sandviç',
                    items: <String>['Sandviç', 'Çorba', 'Tatlı']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Değişiklik işleme
                    },
                    decoration: InputDecoration(
                      labelText: 'Yemek Türü',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Yemek Miktarı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Yemek Zamanı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tahmini Porsiyon Adet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Adres',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Harita Link',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Görsel yükleme işleme
                    },
                    child: Text('Görsel Ekle'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Form gönderme işleme
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: TextStyle(fontSize: 18.0),
                    ),
                    child: Text('YÜKLE'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255), // Şeffaf arka plan
        elevation: 0, // Gölge yok
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0), // Boyut arttırıldı
              onPressed: () {
                // Ana sayfa butonu fonksiyonu
              },
            ),
            SizedBox(width: 90.0), // Yüzer aksiyon butonu için boşluk
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0), // Boyut arttırıldı
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
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        child: Image.asset('assets/plus.png', width: 130.0, height: 130.0), // Ekle butonunun boyutu arttırıldı
      ),
    );
  }
}
