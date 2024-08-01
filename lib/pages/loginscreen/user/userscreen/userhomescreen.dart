import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product2.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product3.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userprofilescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userreservescreen.dart';
import 'package:google_bootcamp_60/districts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String _selectedDistrict = 'Arnavutköy'; // Varsayılan değer
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();

  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      DocumentSnapshot? detailsDoc = await _getRestaurantDetails(uid);

      if (detailsDoc != null && detailsDoc.exists) {
        setState(() {
          _selectedDistrict = detailsDoc['district'];
        });
      }
      _loadProducts();
    }
  }

  Future<DocumentSnapshot?> _getRestaurantDetails(String uid) async {
    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    return doc;
  }

  Future<void> _loadProducts() async {

    products.clear();
    QuerySnapshot restaurantSnapshot = await _firestore
        .collection('restaurants')
        .doc(_selectedDistrict)
        .collection('details')
        .get();

    for (var restaurantDoc in restaurantSnapshot.docs) {
      String restaurantName = restaurantDoc['name'];
      print("DENEME:"+ restaurantName);
      QuerySnapshot foodSnapshot = await restaurantDoc.reference.collection('yemekler').get();

      for (var foodDoc in foodSnapshot.docs) {
        products.add({
          'restaurantName': restaurantName,
          'imageUrl': foodDoc['imageUrl'],
          'yemekMiktari': foodDoc['yemekMiktari'],
          'aciklama': foodDoc['aciklama'],
          'yemekTuru': foodDoc['yemekTuru'],
          'restaurantId': restaurantDoc.id,
          'foodId': foodDoc.id,
        });
      }
      print(products);
    }
    setState(() {});
  }
  Future<void> _addToCart(Map<String, dynamic> product) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      String restaurantId = product['restaurantId'];
      String foodId = product['foodId'];

      try {
        // Get the current quantity available for the food item
        DocumentSnapshot foodDoc = await _firestore
            .collection('restaurants')
            .doc(_selectedDistrict) // Assuming you have _selectedDistrict available here
            .collection('details')
            .doc(restaurantId)
            .collection('yemekler')
            .doc(foodId)
            .get();

        if (!foodDoc.exists) {
          throw Exception('Food item not found.');
        }

        int availableQuantity = foodDoc['yemekMiktari'] as int;

        // Check if the item already exists in the cart
        QuerySnapshot cartSnapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('cart')
            .where('foodId', isEqualTo: foodId)
            .get();

        if (cartSnapshot.docs.isNotEmpty) {
          // Item exists, update the quantity
          DocumentSnapshot cartDoc = cartSnapshot.docs.first;
          int currentQuantity = (cartDoc['yemekAdet'] as int? ?? 0);
          int newQuantity = currentQuantity + 1;

          if (newQuantity <= availableQuantity) {
            await _firestore
                .collection('users')
                .doc(uid)
                .collection('cart')
                .doc(cartDoc.id)
                .update({'yemekAdet': newQuantity});

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ürün sepetteki miktar artırıldı')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Stok yetersiz')),
            );
          }
        } else {
          // Item does not exist, add it to the cart with quantity 1
          if (availableQuantity > 0) {
            await _firestore.collection('users').doc(uid).collection('cart').add({
              'restaurantId': restaurantId,
              'foodId': foodId,
              'restaurantName': product['restaurantName'],
              'imageUrl': product['imageUrl'],
              'yemekAdet': 1, // Set initial quantity to 1
              'aciklama': product['aciklama'],
              'yemekTuru': product['yemekTuru'],
              'addedAt': FieldValue.serverTimestamp(),
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Ürün sepete eklendi')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Stok bulunmuyor')),
            );
          }
        }
      } catch (e) {
        print('Error adding to cart: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bir hata oluştu. Lütfen tekrar deneyin')),
        );
      }
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
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Container(
                width: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'İstanbul',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.green,
                      ),
                    ),
                    DropdownButton<String>(
                      value: _selectedDistrict,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue!;
                          _loadProducts(); // Yeni ilçe seçildiğinde ürünleri yeniden yükle
                        });
                      },
                      items: Districts.istanbulDistricts
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(right: 60.0),
                  child: Image.asset(
                    'assets/allgotur.png',
                    height: 80.0,
                    width: 80.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 85),
              Container(
                height: 200.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: PageView(
                  children: [
                    Image.asset('assets/banner3.png', fit: BoxFit.cover),
                    Image.asset('assets/banner1.png', fit: BoxFit.cover),
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return _buildProductItem(
                      context,
                      products[index]['imageUrl'],
                      products[index]['restaurantName'],
                      products[index]['aciklama'],
                      products[index]['yemekMiktari'],
                      Colors.green,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2),
                          () => _addToCart(products[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0),
              onPressed: () {
                // Ana sayfa buton fonksiyonu
              },
            ),
            SizedBox(width: 90.0),
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
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
              builder: (context) => const UserReserve(),
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Image.asset('assets/shopping.png', width: 130.0, height: 130.0),
      ),
    );
  }

  Widget _buildProductItem(
      BuildContext context,
      String imageUrl,
      String title,
      String subtitle,
      int amount,
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
              child: Image.network(imageUrl, width: 60.0, height: 60.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Stok:"+ amount.toString(), style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: onTap,
                  child: Text('Sepete Ekle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}