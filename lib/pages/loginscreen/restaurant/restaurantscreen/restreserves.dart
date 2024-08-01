import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:google_bootcamp_60/districts.dart';

class RestReserve extends StatefulWidget {
  const RestReserve({super.key});

  @override
  _RestReserveState createState() => _RestReserveState();
}

class _RestReserveState extends State<RestReserve> {
  bool showCart = true;
  List<DocumentSnapshot> foods = [];
  List<Map<String, dynamic>> reservations = [];
  String selectedLocation = '';
  bool isLoading = true;
  String userUID = '';

  @override
  void initState() {
    super.initState();
    _getUserUID();
  }

  Future<void> _getUserUID() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userUID = user.uid;
        });
        await _fetchUserLocation();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppOpenScreen()),
        );
      }
    } catch (e) {
      print('Kullanıcı UID alınırken hata oluştu: $e');
    }
  }

  Future<void> _fetchUserLocation() async {
    try {
      for (String district in Districts.istanbulDistricts) {
        DocumentSnapshot? userDoc = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(district)
            .collection('details')
            .doc(userUID)
            .get();

        if (userDoc.exists) {
          setState(() {
            selectedLocation = district;
          });
          break;
        }
      }
      await _fetchFoods();

    } catch (e) {
      print('Kullanıcının lokasyonu alınırken hata oluştu: $e');
    }
  }

  Future<void> _fetchFoods() async {
    if (selectedLocation.isEmpty) return;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(selectedLocation)
          .collection('details')
          .doc(userUID)
          .collection('yemekler')
          .get();
      setState(() {
        foods = snapshot.docs;
      });
      await _fetchReservations();
    } catch (e) {
      print('Veri çekme hatası: $e');
    }
  }

  Future<void> _fetchReservations() async {
    if (selectedLocation.isEmpty) return;
    try {
      final reservationsSnapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(selectedLocation)
          .collection('details')
          .doc(userUID)
          .collection('reservations')
          .get();

      List<Map<String, dynamic>> tempReservations = [];

      for (var doc in reservationsSnapshot.docs) {
        var reservationData = doc.data();
        String foodId = reservationData['foodId'];
        String userId = reservationData['userId'];

        // Fetch food details
        DocumentSnapshot foodSnapshot = await FirebaseFirestore.instance
            .collection('restaurants')
            .doc(selectedLocation)
            .collection('details')
            .doc(userUID)
            .collection('yemekler')
            .doc(foodId)
            .get();

        // Fetch user details
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        tempReservations.add({
          'yemekAdet': reservationData['yemekAdet'],
          'yemekTuru': foodSnapshot['yemekTuru'],
          'aciklama': foodSnapshot['aciklama'],
          'ilanBasligi': foodSnapshot['ilanBasligi'],
          'userName': userSnapshot['name'],
          'userPhone': userSnapshot['phone'],
        });
      }
      print("DENEME:"+ tempReservations.toString());

      setState(() {
        reservations = tempReservations;
        isLoading = false;
      });
    } catch (e) {
      print('Rezervasyon verisi çekme hatası: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
          // Background circles (unchanged)
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
                Expanded(
                  child: showCart ? buildCartContent() : buildReservationsContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartContent() {
    // Unchanged
    return foods.isEmpty
        ? Center(child: Text('Sepetiniz boş.'))
        : ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        var food = foods[index];
        return FoodCard(
          food: food,
          onQuantityChanged: (newQuantity) {
            _updateFoodQuantity(food.id, newQuantity);
          },
          onDelete: () {
            _deleteFood(food.id);
          },
        );
      },
    );
  }

  Widget buildReservationsContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return reservations.isEmpty
        ? Center(child: Text('Rezervasyon bulunmamaktadır.'))
        : ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        var reservation = reservations[index];
        return ReservationCard(reservation: reservation);
      },
    );
  }

  void _updateFoodQuantity(String docId, int newQuantity) {
    // Unchanged
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(selectedLocation)
        .collection('details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yemekler')
        .doc(docId)
        .update({'yemekMiktari': newQuantity});
  }

  void _deleteFood(String docId) {
    // Unchanged
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(selectedLocation)
        .collection('details')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('yemekler')
        .doc(docId)
        .delete()
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Yemek başarıyla silindi.'))
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Yemek silinirken hata oluştu: $error'))
      );
    });
  }
}

class FoodCard extends StatelessWidget {
  // Unchanged
  final DocumentSnapshot food;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

  const FoodCard({
    required this.food,
    required this.onQuantityChanged,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController(text: food['yemekMiktari'].toString());
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
          Image.network(food['imageUrl'], width: 80.0, height: 80.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food['ilanBasligi'], style: TextStyle(fontSize: 18.0)),
                Text(food['yemekTuru'], style: TextStyle(fontSize: 16.0)),
                Text(food['adres'], style: TextStyle(fontSize: 14.0)),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 60,
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    labelText: 'Miktar',
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    int? newQuantity = int.tryParse(value);
                    if (newQuantity != null) {
                      onQuantityChanged(newQuantity);
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('SİL', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final Map<String, dynamic> reservation;

  const ReservationCard({required this.reservation, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reservation['ilanBasligi'], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          Text('Yemek Türü: ${reservation['yemekTuru']}', style: TextStyle(fontSize: 16.0)),
          Text('Açıklama: ${reservation['aciklama']}', style: TextStyle(fontSize: 14.0)),
          Text('Adet: ${reservation['yemekAdet']}', style: TextStyle(fontSize: 14.0)),
          Divider(),
          Text('Rezerve Eden: ${reservation['userName']}', style: TextStyle(fontSize: 14.0)),
          Text('Telefon: ${reservation['userPhone']}', style: TextStyle(fontSize: 14.0)),
        ],
      ),
    );
  }
}