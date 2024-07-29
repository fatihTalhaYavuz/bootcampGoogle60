import 'package:flutter/material.dart';

class RestReserve extends StatefulWidget {
  const RestReserve({super.key});

  @override
  _RestReserveState createState() => _RestReserveState();
}

class _RestReserveState extends State<RestReserve> {
  bool showCart = true; // Başlangıç durumu sepeti gösterir
  String selectedLocation = 'Kadıköy'; // Varsayılan seçim
  final List<String> locations = ['Kadıköy', 'Beşiktaş', 'Şişli']; // Lokasyonlar listesi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.0, // AppBar yüksekliği (azaltılmış)
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Geri ok ikonu
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment(0.0, 0), // Ortalanmış
          child: Image.asset(
            'assets/allgotur.png',
            height: 100.0, // Azaltılmış logo boyutu
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/sepet.png',
              height: 40.0,
              width: 40.0,
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
          Padding(
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
                        DropdownButton<String>(
                          value: selectedLocation,
                          icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocation = newValue!;
                            });
                          },
                          items: locations.map<DropdownMenuItem<String>>((String value) {
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
                            setState(() {
                              showCart = true;
                            });
                          },
                          child: Text(
                            'BAĞIŞLARIM',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: showCart ? Colors.black : Colors.black38,
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.black),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showCart = false;
                            });
                          },
                          child: Text(
                            'REZERVLER',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: !showCart ? Colors.black : Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: showCart ? buildCartContent() : buildReservationsContent(), // İçeriği göster
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                // Yeni öğe ekle
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartContent() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Image.asset('assets/taking_food.png', width: 80.0, height: 80.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Taking Food', style: TextStyle(fontSize: 18.0)),
                    Text('20 adet', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Öğeyi düzenle
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('DÜZENLE', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 5.0),
                  Text('22.00-22.30', style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReservationsContent() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Image.asset('assets/taking_food.png', width: 80.0, height: 80.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Taking Food', style: TextStyle(fontSize: 18.0)),
                    Text('20 adet', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Öğeyi düzenle
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('DÜZENLE', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 5.0),
                  Text('22.00-22.30', style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ],
          ),
        ),
        // Daha fazla rezervasyon öğesi buraya ekle
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, -size.height, size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
