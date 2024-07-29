import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product2.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product3.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userprofilescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userreservescreen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

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
              padding: const EdgeInsets.only(right: 16.0), // Logo ile konum seçimi arasına boşluk ekler
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İstanbul',
                        style: TextStyle(
                          fontSize: 14.0, // Küçük yazı tipi boyutu
                          color: Colors.green,
                        ),
                      ),
                      DropdownButton<String>(
                        value: 'Kadıköy', // Varsayılan değer
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        onChanged: (String? newValue) {
                          // Konum değişikliğini işle
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
              'assets/sepet.png',
              width: 50.0, // Sepet simgesinin genişliği artırıldı
              height: 50.0, // Sepet simgesinin yüksekliği artırıldı
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserReserve(), // Uygun ekran ile güncelle
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
              // AppBar'dan sonraki boşluk
              SizedBox(height: kToolbarHeight + 65), // AppBar yüksekliği + 65 piksel

              // Banner bölümü
              Container(
                height: 200.0, // Banner yüksekliği
                margin: const EdgeInsets.symmetric(horizontal: 10.0), // Yatay margin
                child: PageView(
                  children: [
                    Image.asset('assets/banner3.png', fit: BoxFit.cover), // Banner resimleri
                    Image.asset('assets/banner1.png', fit: BoxFit.cover),
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Bannerların altındaki boşluk

              // Ürün listesi
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildProductItem(
                      context,
                      'assets/taking_food.png', // Ürün logo yolu
                      'Taking Food',
                      'Şirket Yemek Belirtmedi',
                      '22.00-22.30',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2), // Güncellenen renk
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product(), // TakingFoodScreen'e git
                          ),
                        );
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/bonfire.png', // Ürün logo yolu
                      'Bonfire',
                      'Domates Çorbası',
                      '23.00-23.30',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2), // Güncellenen renk
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product2(), // BonfireScreen'e git
                          ),
                        );
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/grill.png', // Ürün logo yolu
                      'Grill',
                      'Şirket Çeşit Belirtmedi',
                      '23.45-23.59',
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2), // Güncellenen renk
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Product3(), // GrillScreen'e git
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
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0), // Boyut artırıldı
              onPressed: () {
                // Ana sayfa buton fonksiyonu
              },
            ),
            SizedBox(width: 90.0), // Yüzen eylem düğmesi için boşluk
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0), // Boyut artırıldı
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(), // UserProfileScreen'e git
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
              builder: (context) => const UserReserve(), // Uygun ekran ile güncelle
            ),
          );
        },
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        child: Image.asset('assets/shopping.png', width: 130.0, height: 130.0), // Ekleme düğmesinin boyutu artırıldı
      ),
    );
  }

  // Ürün kartı oluşturma fonksiyonu
  Widget _buildProductItem(
      BuildContext context,
      String logoPath,
      String title,
      String subtitle,
      String time,
      Color logoBgColor,
      Color cardBgColor,
      VoidCallback onTap) {
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
              child: Image.asset(logoPath, width: 60.0, height: 60.0), // Logo boyutu artırıldı
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)), // Yazı tipi boyutu ve kalınlığı artırıldı
                  Text(subtitle, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])), // Yazı tipi boyutu artırıldı
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)), // Yazı tipi boyutu ve kalınlığı artırıldı
                const Icon(Icons.access_time, size: 20.0), // Simge boyutu ayarlandı
              ],
            ),
          ],
        ),
      ),
    );
  }
}
