import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resaddscreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResHomeScreen extends StatelessWidget {
  const ResHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar height
        title: Center(
          child: Image.asset(
            'assets/reshome.png',
            height: 130.0, // Logo size
          ),
        ),
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/zerogoal.png',
              width: 50.0, // Increased cart icon width
              height: 50.0, // Increased cart icon height
            ),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppOpenScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background circles
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
              // Space after AppBar
              SizedBox(height: kToolbarHeight + 65), // AppBar height + 65 pixels
              // Banner section
              Container(
                height: 200.0, // Banner height
                margin: const EdgeInsets.symmetric(horizontal: 10.0), // Horizontal margin
                child: PageView(
                  children: [
                    Image.asset('assets/banner1.png', fit: BoxFit.cover), // Banner images
                    Image.asset('assets/banner2.png', fit: BoxFit.cover),
                    Image.asset('assets/banner3.png', fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Space below banners
              // Product list
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildProductItem(
                      context,
                      'assets/taking_food.png', // Product logo path
                      'Taking Food',
                      'Şirket Yemek Belirtmedi',
                      '22.00-22.30',
                      Colors.green,
                      Color(0xFFFFCDD2), // Ana yazı rengi
                      () {
                        // Define the action when the card is tapped
                        print('Taking Food tapped');
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/bonfire.png', // Product logo path
                      'Bonfire',
                      'Domates Çorbası',
                      '23.00-23.30',
                      Colors.green,
                      Color(0xFFFFCDD2), // Ana yazı rengi
                      () {
                        // Define the action when the card is tapped
                        print('Bonfire tapped');
                      },
                    ),
                    _buildProductItem(
                      context,
                      'assets/grill.png', // Product logo path
                      'Grill',
                      'Şirket Çeşit Belirtmedi',
                      '23.45-23.59',
                      Colors.green,
                      Color(0xFFFFCDD2), // Ana yazı rengi
                      () {
                        // Define the action when the card is tapped
                        print('Grill tapped');
                      },
                    ),
                    // Add other products here
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255), // Transparent background
        elevation: 0, // No shadow
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png', width: 90.0, height: 90.0), // Increased size
              onPressed: () {
                // Home button function
              },
            ),
            SizedBox(width: 90.0), // Space for the floating action button
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0), // Increased size
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
                      builder: (context) => const ResAddScreen(),
                      ),
                    );
                },
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        child: Image.asset('assets/plus.png', width: 130.0, height: 130.0), // Increased size of the add button
      ),
    );
  }

  // Product card creation function
  Widget _buildProductItem(BuildContext context, String logoPath, String title, String subtitle, String time, Color logoBgColor, Color cardBgColor, VoidCallback onTap) {
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
              child: Image.asset(logoPath, width: 60.0, height: 60.0), // Increased size of logo
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)), // Increased font size and bold
                  Text(subtitle, style: TextStyle(fontSize: 14.0, color: Colors.grey[700])), // Increased font size
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)), // Increased font size and bold
                const Icon(Icons.access_time, size: 20.0), // Adjusted icon size
              ],
            ),
          ],
        ),
      ),
    );
  }
}
