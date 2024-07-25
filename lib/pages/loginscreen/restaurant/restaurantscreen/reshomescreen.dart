import 'package:flutter/material.dart';

class ResHomeScreen extends StatelessWidget {
  const ResHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar yüksekliğini ayarlayın
        title: Center(
          child: Image.asset(
            'assets/reshome.png',
            height: 130.0, // Başlığın boyutunu ayarlayın
          ),
        ),
        backgroundColor: Colors.transparent, // AppBar arka planını şeffaf yapar
        elevation: 0, // AppBar'ın gölgesini kaldırır
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/sepet.png',
              width: 30.0, // Sepet simgesinin genişliğini ayarlayın
            ),
            onPressed: () {
              // Sepet tıklama işlevini buraya ekleyin
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // AppBar'dan sonra gelen boşluk
          SizedBox(height: 120.0), // Banner ile AppBar arasındaki boşluk
          // Orta üstteki kayar şey
          Container(
            height: 200.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0), // Yatayda boşluk
            child: PageView(
              children: [
                Image.asset('assets/banner1.png', fit: BoxFit.cover), // Banner resimleri
                Image.asset('assets/banner2.png', fit: BoxFit.cover),
                Image.asset('assets/banner3.png', fit: BoxFit.cover),
              ],
            ),
          ),
          // Ürün listesi
          Expanded(
            child: ListView(
              children: [
                _buildProductItem(
                  context,
                  'assets/taking_food.png', // Ürün logosunun yolu
                  'Taking Food',
                  'Şirket Yemek Belirtmedi',
                  '22.00-22.30',
                ),
                _buildProductItem(
                  context,
                  'assets/bonfire.png', // Ürün logosunun yolu
                  'Bonfire',
                  'Domates Çorbası',
                  '23.00-23.30',
                ),
                _buildProductItem(
                  context,
                  'assets/grill.png', // Ürün logosunun yolu
                  'Grill',
                  'Şirket Çeşit Belirtmedi',
                  '23.45-23.59',
                ),
                // Diğer ürünleri burada ekleyin
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sepetim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  // Ürün kartı oluşturma fonksiyonu
  Widget _buildProductItem(BuildContext context, String logoPath, String title, String subtitle, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        leading: Image.asset(logoPath, width: 50.0, height: 50.0),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time),
            const Icon(Icons.anchor),
          ],
        ),
        onTap: () {
          // Ürün tıklama işlevini buraya ekleyin
        },
      ),
    );
  }
}
