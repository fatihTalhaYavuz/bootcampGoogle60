import 'package:flutter/material.dart';

class UserReserve extends StatefulWidget {
  const UserReserve({super.key});

  @override
  _UserReserveState createState() => _UserReserveState();
}

class _UserReserveState extends State<UserReserve> {
  bool showCart = true; // Initial state shows the cart
  String selectedLocation = 'Kadıköy'; // Default selection
  final List<String> locations = ['Kadıköy', 'Beşiktaş', 'Şişli'];

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
          alignment: Alignment(0.0, 0), // Centered
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
                      // Confirm reservation
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
                  icon: Icon(Icons.remove, color: Colors.green), // Decrease icon
                  onPressed: () {
                    // Reduce item count
                  },
                  iconSize: 24.0, // İkon boyutu
                ),
              ),
              Text('1', style: TextStyle(fontSize: 18.0)),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2), // Hafif yeşil arka plan
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Colors.green), // Increase icon
                  onPressed: () {
                    // Increase item count
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
        // Add more reservation items here
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
