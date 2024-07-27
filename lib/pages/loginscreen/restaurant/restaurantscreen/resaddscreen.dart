import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resprofile.dart';

class ResAddScreen extends StatelessWidget {
  const ResAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100.0, // AppBar height
        title: Row(
          children: [
            // Location selection section
            Padding(
              padding: const EdgeInsets.only(right: 16.0), // Add space between logo and location selection
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İstanbul',
                        style: TextStyle(
                          fontSize: 14.0, // Smaller font size
                          color: Colors.green,
                        ),
                      ),
                      DropdownButton<String>(
                        value: 'Kadıköy', // Default value
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        onChanged: (String? newValue) {
                          // Handle the location change
                        },
                        items: <String>['Kadıköy', 'Beşiktaş', 'Şişli']
                            .map<DropdownMenuItem<String>>((String value) {
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
            ),
            // Logo section
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft, // Resmi sola hizalar
                child: Container(
                  margin: const EdgeInsets.only(right: 60.0), // Resmi sola kaydırmak için margin ekleyin
                  child: Image.asset(
                    'assets/reshome.png',
                    height: 120.0, // Resmin boyutunu ayarlayın
                    width: 120.0, // Genişlik ayarı
                    fit: BoxFit.contain, // Resmin orantılı şekilde görünmesini sağlar
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/zerogoal.png',
              width: 50.0, // Increased cart icon width
              height: 50.0, // Increased cart icon height
            ),
            onPressed: () {
              // Cart button function
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Upper green circle
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
          // Lower green circle
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
          // Removed the banner and product list
          Column(
            children: [
              SizedBox(height: kToolbarHeight + 65), // Space after AppBar
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
}
