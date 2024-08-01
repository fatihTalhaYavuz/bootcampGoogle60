import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product2.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/details/product3.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userprofilescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userreservescreen.dart';
import 'package:google_bootcamp_60/districts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_bootcamp_60/chatbot_screen.dart'; // ChatBot ekranı için oluşturduğunuz dosya
import 'package:animated_text_kit/animated_text_kit.dart'; // AnimatedTextKit paketi

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
  final PageController _controller = PageController();
  bool _isTextVisible = true; // Metin görünürlüğü kontrolü

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
        DocumentSnapshot foodDoc = await _firestore
            .collection('restaurants')
            .doc(_selectedDistrict)
            .collection('details')
            .doc(restaurantId)
            .collection('yemekler')
            .doc(foodId)
            .get();

        if (!foodDoc.exists) {
          throw Exception('Food item not found.');
        }

        int availableQuantity = foodDoc['yemekMiktari'] as int;

        QuerySnapshot cartSnapshot = await _firestore
            .collection('users')
            .doc(uid)
            .collection('cart')
            .where('foodId', isEqualTo: foodId)
            .get();

        if (cartSnapshot.docs.isNotEmpty) {
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
          if (availableQuantity > 0) {
            await _firestore.collection('users').doc(uid).collection('cart').add({
              'restaurantId': restaurantId,
              'foodId': foodId,
              'restaurantName': product['restaurantName'],
              'imageUrl': product['imageUrl'],
              'yemekAdet': 1,
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
      backgroundColor: Color(0xFFF8F8FF),
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
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: DropdownButton<String>(
                        value: _selectedDistrict,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDistrict = newValue!;
                            _loadProducts();
                          });
                        },
                        items: Districts.istanbulDistricts
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, softWrap: false, overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 50.0),
                  child: Image.asset(
                    'assets/allgotur.png',
                    height: 1000.0,
                    width: 1000.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Image.asset(
                'assets/zerogoal.png',
                width: 80.0,
                height: 80.0,
              ),
              onPressed: () {},
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
            right: -180,
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
                height: 220.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [BoxShadow(color: Colors.blueGrey, blurRadius: 5)],
                ),
                clipBehavior: Clip.antiAlias,
                child: PageView(
                  controller: _controller,
                  children: [
                    Image.asset('assets/banner4.gif', fit: BoxFit.cover),
                    Image.asset('assets/banner5.gif', fit: BoxFit.cover),
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 16,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
              SizedBox(height: 5.0),
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
                      Colors.orangeAccent,
                      const Color.fromARGB(255, 111, 111, 111).withOpacity(0.2),
                          () => _addToCart(products[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 300,
            left: 5,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.transparent,
                  width: 0,
                ),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatBotScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/chat.gif',
                  width: 120,
                  height: 120,
                ),
                heroTag: 'chatBotScreen',
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
          Positioned(
            bottom: 318, // Adjust this value based on your design
            left: 120, // Adjust this value based on your design
            child: AnimatedOpacity(
              opacity: _isTextVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 30), // Animation duration
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TypewriterAnimatedTextKit(
                  text: [
                    'Bana sürdürülebilir yaşam \nhedefleri hakkında soru sor...',
                  ],
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                  speed: Duration(milliseconds: 100), // Yazma hızı
                  repeatForever: true,
                ),
              ),
            ),
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
        child: Image.asset('assets/shopping.png', width: 200.0, height: 200.0),
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
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
