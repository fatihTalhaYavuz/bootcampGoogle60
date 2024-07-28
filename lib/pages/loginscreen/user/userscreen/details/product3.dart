import 'package:flutter/material.dart';

class Product3 extends StatelessWidget {
  const Product3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar height
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment(-0.1, 0), // Slightly left-aligned
          child: Image.asset(
            'assets/reshome.png',
            height: 130.0, // Logo size
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
                              // Add your logic here
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
                              // Add your logic here
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
                        Image.asset('assets/grill.png', width: 100.0, height: 100.0),
                        Text(
                          'Grill',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Grill, en iyi et yemeklerini sunan bir restorandır. Taze ve lezzetli etlerle hazırlanan yemeklerimizle unutulmaz bir deneyim yaşayın.',
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
                              'Izgara Et',
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
                                'Grill, Kadıköy, İstanbul',
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
                            // Decrease item count
                          },
                        ),
                        Text('1', style: TextStyle(fontSize: 18.0)),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.black),
                          onPressed: () {
                            // Increase item count
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add to cart
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
