import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resaddscreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/restreserves.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product2.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product3.dart';

class ResHomeScreen extends StatelessWidget {
  const ResHomeScreen({super.key});

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
      body: Stack(
        children: [
          // Arka plan daireleri
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
              // AppBar sonrası boşluk
              SizedBox(height: kToolbarHeight + 65), // AppBar yüksekliği + 65 piksel
              // Banner bölümü
              Container(
                height: 200.0, // Banner yüksekliği
                margin: const EdgeInsets.symmetric(horizontal: 10.0), // Yatay margin
                child: PageView(
                  children: [
                    Image.asset('assets/banner1.png', fit: BoxFit.cover), // Banner resimleri
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                    Image.asset('assets/banner3.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Banner altındaki boşluk
              // Ürün listesi
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildProductItem(
                      context,
                      'assets/taking_food.png', // Ürün logosu yolu
                      'Taking Food',
                      'Şirket Yemek Belirtmedi',
                      '22.00-22.30',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2), // Ana yazı rengi
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product(), // TakingFoodScreen'e yönlendir
                          ),
                        );
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/bonfire.png', // Ürün logosu yolu
                      'Bonfire',
                      'Domates Çorbası',
                      '23.00-23.30',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2), // Ana yazı rengi
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product2(), // BonfireScreen'e yönlendir
                          ),
                        );
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/grill.png', // Ürün logosu yolu
                      'Grill',
                      'Şirket Çeşit Belirtmedi',
                      '23.45-23.59',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2),// Ana yazı rengi
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product3(), // GrillScreen'e yönlendir
                          ),
                        );
                      },
                    ),
                    // Diğer ürünleri buraya ekleyin
                  ],
                ),
              ),
            ],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResHomeScreen(),
                  ),
                );
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

  // Ürün kartı oluşturma fonksiyonu
  Widget _buildProductItem(BuildContext context, String logoPath, String title, String subtitle, String time, Color logoBgColor, Color cardBgColor, VoidCallback onTap) {
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
              child: Image.asset(logoPath, width: 60.0, height: 60.0), // Logonun boyutu arttırıldı
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)), // Font boyutu arttırıldı ve kalın yapıldı
                  Text(subtitle, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])), // Font boyutu arttırıldı
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)), // Font boyutu arttırıldı ve kalın yapıldı
                const Icon(Icons.access_time, size: 20.0), // İkon boyutu ayarlandı
              ],
            ),
          ],
        ),
      ),
    );
  }
}
