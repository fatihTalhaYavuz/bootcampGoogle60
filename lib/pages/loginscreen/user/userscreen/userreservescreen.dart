import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserReserve extends StatefulWidget {
  const UserReserve({super.key});

  @override
  _UserReserveState createState() => _UserReserveState();
}

class _UserReserveState extends State<UserReserve> {
  String _selectedDistrict = 'Arnavutköy'; // Varsayılan değer
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool showCart = true; // Başlangıçta sepet gösterilir
  String useruid = '';
  List<Map<String, dynamic>> cartItems = []; // Sepet öğeleri

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchCartItems();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      useruid = user.uid;
      DocumentSnapshot? detailsDoc = await _getRestaurantDetails(user.uid);

      if (detailsDoc != null && detailsDoc.exists) {
        setState(() {
          _selectedDistrict = detailsDoc['district'];
        });
      }
    }
  }

  Future<DocumentSnapshot?> _getRestaurantDetails(String uid) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    return doc;
  }

  Future<void> fetchCartItems() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .collection('cart')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        cartItems = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>
          };
        }).toList();
      });
    });
  }

  Future<void> updateCartItemQuantity(String cartDocId, int newQuantity) async {
    DocumentReference cartDoc = _firestore
        .collection('users')
        .doc(useruid)
        .collection('cart')
        .doc(cartDocId);

    DocumentSnapshot cartSnapshot = await cartDoc.get();
    if (cartSnapshot.exists) {
      await cartDoc.update({'yemekAdet': newQuantity});
    }
  }
  Future<void> _confirmReservation() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      // Fetch cart items
      QuerySnapshot cartSnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('cart')
          .get();

      // Process each cart item
      for (var doc in cartSnapshot.docs) {
        Map<String, dynamic> cartItem = doc.data() as Map<String, dynamic>;
        String restaurantId = cartItem['restaurantId'];
        String foodId = cartItem['foodId'];
        int yemekAdet = cartItem['yemekAdet'];

        // Move cart item to reservations
        await _firestore.collection('users').doc(uid).collection('reserves').add({
          'restaurantId': restaurantId,
          'foodId': foodId,
          'restaurantName': cartItem['restaurantName'],
          'imageUrl': cartItem['imageUrl'],
          'yemekAdet': yemekAdet,
          'aciklama': cartItem['aciklama'],
          'yemekTuru': cartItem['yemekTuru'],
          'addedAt': FieldValue.serverTimestamp(),
        });

        // Add to restaurant reservations
        await _firestore.collection('restaurants')
            .doc(_selectedDistrict)
            .collection('details')
            .doc(restaurantId)
            .collection('reservations')
            .add({
          'userId': uid,
          'foodId': foodId,
          'yemekAdet': yemekAdet,
        });

        // Update food quantity in the restaurant
        DocumentReference foodDoc = _firestore
            .collection('restaurants')
            .doc(_selectedDistrict)
            .collection('details')
            .doc(restaurantId)
            .collection('yemekler')
            .doc(foodId);

        await _firestore.runTransaction((transaction) async {
          DocumentSnapshot foodSnapshot = await transaction.get(foodDoc);

          if (foodSnapshot.exists) {
            int currentQuantity = foodSnapshot['yemekMiktari'] as int;
            int updatedQuantity = currentQuantity - yemekAdet;

            if (updatedQuantity < 0) {
              throw Exception('Not enough quantity available');
            }

            transaction.update(foodDoc, {'yemekMiktari': updatedQuantity});
          } else {
            throw Exception('Food item does not exist');
          }
        });
      }

      // Remove items from cart
      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      // Update UI and navigate to reservations page
      setState(() {
        cartItems.clear();
        showCart = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rezervasyon başarılı')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen giriş yapın')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment(-0.2, 0),
          child: Image.asset(
            'assets/allgotur.png',
            height: 100.0,
          ),
        ),
      ),
      body: Stack(
        children: [
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
          if (showCart)
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomPaint(
                painter: HalfCirclePainter(),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: Center(
                    child: TextButton(
                      onPressed: _confirmReservation,
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
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Image.network(item['imageUrl'], width: 50.0, height: 50.0),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['aciklama'], style: TextStyle(fontSize: 18.0)),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.remove, color: Colors.green),
                onPressed: () {
                  setState(() {
                    if (item['yemekAdet'] > 0) {
                      item['yemekAdet']--;
                      updateCartItemQuantity(item['id'], item['yemekAdet']);
                    }
                  });
                },
                iconSize: 24.0,
              ),
              Text('${item['yemekAdet']}', style: TextStyle(fontSize: 18.0)),
              IconButton(
                icon: Icon(Icons.add, color: Colors.green),
                onPressed: () async {
                  final cartDocId = item['id'];

                  DocumentReference cartDoc = FirebaseFirestore.instance
                      .collection('users')
                      .doc(useruid)
                      .collection('cart')
                      .doc(cartDocId);

                  DocumentSnapshot cartSnapshot = await cartDoc.get();
                  if (cartSnapshot.exists) {
                    int currentQuantity = cartSnapshot['yemekAdet'];

                    DocumentReference foodDoc = FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(_selectedDistrict)
                        .collection('details')
                        .doc(item['restaurantId'])
                        .collection('yemekler')
                        .doc(item['foodId']);

                    DocumentSnapshot foodSnapshot = await foodDoc.get();
                    if (foodSnapshot.exists) {
                      int availableQuantity = foodSnapshot['yemekMiktari'];

                      if (availableQuantity > currentQuantity) {
                        setState(() {
                          item['yemekAdet']++;
                          updateCartItemQuantity(cartDocId, item['yemekAdet']);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Yeterli miktar yok!'),
                          ),
                        );
                      }
                    }
                  }
                },
                iconSize: 24.0,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildReservationsContent() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .doc(useruid)
          .collection('reserves')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final reserves = snapshot.data!.docs;

        return ListView.builder(
          itemCount: reserves.length,
          itemBuilder: (context, index) {
            final reserve = reserves[index].data() as Map<String, dynamic>;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: Image.network(reserve['imageUrl']),
                title: Text(reserve['aciklama']),
                subtitle: Text('Miktar: ${reserve['yemekAdet']}'),
                // Buradaki trailing kısmını kaldırdık
                trailing: SizedBox.shrink(),
              ),
            );
          },
        );
      },
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


