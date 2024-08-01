import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:google_bootcamp_60/districts.dart';

class ResAddScreen extends StatefulWidget {
  const ResAddScreen({super.key});

  @override
  _ResAddScreenState createState() => _ResAddScreenState();
}

class _ResAddScreenState extends State<ResAddScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mealTimeController = TextEditingController();
  final TextEditingController _portionEstimateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mapLinkController = TextEditingController();
  String _mealType = 'Sandviç';
  int _mealAmount = 1;
  File? _imageFile;


  @override
  void dispose() {
    _titleController.dispose();
    _mealTimeController.dispose();
    _portionEstimateController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _mapLinkController.dispose();
    super.dispose();
  }


  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _storage.ref().child('restaurant_images/$fileName');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }


  Future<DocumentReference?> _getRestaurantDetails(String uid) async {
    for (String district in Districts.istanbulDistricts) {
      DocumentSnapshot doc = await _firestore
          .collection('restaurants')
          .doc(district)
          .collection('details')
          .doc(uid)
          .get();

      if (doc.exists) {
        return doc.reference;
      }
    }
    return null;
  }

  Future<void> _saveData(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    final String uid = user.uid;
    DocumentReference? restaurantDocRef = await _getRestaurantDetails(uid);

    if (restaurantDocRef != null) {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImage(_imageFile!);
      }

      await restaurantDocRef.collection('yemekler').add({
        'ilanBasligi': _titleController.text,
        'yemekTuru': _mealType,
        'yemekMiktari': _mealAmount,
        'yemekZamani': _mealTimeController.text,
        'tahminiPorsiyonAdet': _portionEstimateController.text,
        'aciklama': _descriptionController.text,
        'adres': _addressController.text,
        'haritaLink': _mapLinkController.text,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veriler başarıyla kaydedildi')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restoran bilgileri bulunamadı')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar yüksekliği
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/zerogoal.png',
              width: 50.0, // Sepet ikonunun genişliği arttırıldı
              height: 50.0, // Sepet ikonunun yüksekliği arttırıldı
            ),
            onPressed: () {
              // Sepet butonu fonksiyonu
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Üst yeşil daire
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Alt yeşil daire
          Positioned(
            bottom: -180,
            right: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Form ve içerik
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: kToolbarHeight + 80), // AppBar sonrası boşluk
                  Center(
                    child: Image.asset(
                      'assets/bagis.png',
                      height: 80.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'İlan Başlığı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    value: _mealType,
                    items: <String>['Sandviç', 'Çorba', 'Tatlı']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _mealType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Yemek Türü',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),DropdownButtonFormField<int>(
                    value: _mealAmount,
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()), // `value` int olduğundan `Text(value)` yerine `Text(value.toString())` kullanmalısınız.
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _mealAmount = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Yemek Miktarı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _mealTimeController,
                    decoration: InputDecoration(
                      labelText: 'Yemek Zamanı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _portionEstimateController,
                    decoration: InputDecoration(
                      labelText: 'Tahmini Porsiyon Adet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Adres',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: _mapLinkController,
                    decoration: InputDecoration(
                      labelText: 'Harita Link',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      _pickImage(); // Görsel seçimi
                    },
                    child: Text('Görsel Ekle'),
                  ),
                  SizedBox(height: 10.0),
                  if (_imageFile != null)
                    Image.file(
                      _imageFile!,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      _saveData(context); // Form gönderme işleme
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: TextStyle(fontSize: 18.0),
                    ),
                    child: Text('YÜKLE'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255), // Şeffaf arka plan
        elevation: 0, // Gölge yok
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0), // Boyut arttırıldı
              onPressed: () {
                // Ana sayfa butonu fonksiyonu
              },
            ),
            SizedBox(width: 90.0), // Yüzer aksiyon butonu için boşluk
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0), // Boyut arttırıldı
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResProfile(),
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
              builder: (context) => ResAddScreen(), // `const` kaldırıldı
            ),
          );
        },
        backgroundColor: Colors.transparent, // Şeffaf arka plan
        elevation: 0, // Gölge yok
        child: Image.asset('assets/plus.png', width: 130.0, height: 130.0), // Ekle butonunun boyutu arttırıldı
      ),
    );
  }
}
