import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar yüksekliği
        backgroundColor: Colors.transparent, // Şeffaf arkaplan
        elevation: 0, // Gölge yok
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Geri ok ikonu
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment(0.3, 0), // Biraz sola hizalanmış
          child: Image.asset(
            'assets/allgotur.png',
            height: 90.0, // Logo boyutu
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/sepet.png',
              height: 50.0,
              width: 50.0,
            ),
          ),
        ],
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight + 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'İstanbul',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Kadıköy',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Kendi mantığını ekleyin
                            },
                            child: Text(
                              '22.00-22.30',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          VerticalDivider(color: Colors.black),
                          GestureDetector(
                            onTap: () {
                              // Kendi mantığını ekleyin
                            },
                            child: Icon(Icons.close, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/taking_food.png', width: 100.0, height: 100.0),
                        Text(
                          'Taking Food',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Taking Food, 1980’den beri lezzet ve toplumsal sorumluluğu bir araya getiren yenilikçi bir yemek şirketidir. Fazla gıdaları toplayıp ve ihtiyaç sahiplerine ulaştırıyoruz. Sıfır atık politikamızla hem çevreyi koruyor hem de insanlara yardım ediyoruz. Lezzetli ve sürdürülebilir çözümlerle, her lokmada dünyayı daha iyi bir yer yapıyoruz.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Yemek Türü: ',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Akdeniz Mutfağı',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Konumu: ',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                'Taking Food, Kadıköy, İstanbul',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on, color: Colors.green),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                'Adres: Bağdat Caddesi No:123, Kadıköy, İstanbul, Türkiye',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[100],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              if (itemCount > 1) {
                                itemCount--;
                              }
                            });
                          },
                        ),
                        Text('$itemCount', style: TextStyle(fontSize: 18.0)),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              itemCount++;
                            });
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Sepete ekle
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text('SEPETE EKLE', style: TextStyle(fontSize: 18.0)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
