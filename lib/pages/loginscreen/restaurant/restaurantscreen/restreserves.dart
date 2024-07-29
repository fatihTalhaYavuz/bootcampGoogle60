import 'package:flutter/material.dart';

class RestReserve extends StatefulWidget {
  const RestReserve({super.key});

  @override
  _RestReserveState createState() => _RestReserveState();
}

class _RestReserveState extends State<RestReserve> {
  bool showCart = true; // Başlangıç durumu sepeti gösterir


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0,
        flexibleSpace: Center(
          child: Image.asset(
            'assets/allgotur.png',
            height: 90.0,
            width: 90.0,
            fit: BoxFit.contain,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

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

                SizedBox(height: kToolbarHeight + 50.0),
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
