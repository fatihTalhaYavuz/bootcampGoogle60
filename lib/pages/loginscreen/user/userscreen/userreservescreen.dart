import 'package:flutter/material.dart';

class UserReserve extends StatefulWidget {
  const UserReserve({super.key});

  @override
  _UserReserveState createState() => _UserReserveState();
}

class _UserReserveState extends State<UserReserve> {
  bool showCart = true; // Başlangıçta sepet gösterilir
  String selectedLocation = 'Kadıköy'; // Varsayılan seçim
  final List<String> locations = ['Kadıköy', 'Beşiktaş', 'Şişli'];
  int itemCount = 1; // Başlangıçta ürün sayısı

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
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment(-0.2, 0), // Ortalanmış
          child: Image.asset(
            'assets/allgotur.png',
            height: 100.0, // Logo boyutu
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: kToolbarHeight + 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 80.0),
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
                            'SEPETİM',
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
                            'REZERVLERİM',
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
                  child: showCart ? buildCartContent() : buildReservationsContent(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              painter: HalfCirclePainter(),
              child: Container(
                height: 100, // Butonun yüksekliğini artırdık
                width: double.infinity,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // Rezervasyonu onayla
                    },
                    child: Text(
                      'REZERVASYONU ONAYLA',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
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
              Image.asset('assets/taking_food.png', width: 50.0, height: 50.0),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Taking Food', style: TextStyle(fontSize: 18.0)),
                ],
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2), // Hafif yeşil arka plan
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.remove, color: Colors.green), // Azaltma ikonu
                  onPressed: () {
                    setState(() {
                      if (itemCount > 0) {
                        itemCount--;
                      }
                    });
                  },
                  iconSize: 24.0, // İkon boyutu
                ),
              ),
              Text('$itemCount', style: TextStyle(fontSize: 18.0)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2), // Hafif yeşil arka plan
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.green), // Artırma ikonu
                  onPressed: () {
                    setState(() {
                      itemCount++;
                    });
                  },
                  iconSize: 24.0, // İkon boyutu
                ),
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
              Image.asset('assets/taking_food.png', width: 50.0, height: 50.0),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Taking Food', style: TextStyle(fontSize: 18.0)),
                ],
              ),
              Spacer(),
              Text('1', style: TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
        // Daha fazla rezervasyon öğesi ekleyin
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
