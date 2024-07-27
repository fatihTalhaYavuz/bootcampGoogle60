import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userhomescreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/user/userscreen/userreservescreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false;
  final TextEditingController emailController = TextEditingController(text: 'all.gotur@gmail.com');
  final TextEditingController nameController = TextEditingController(text: 'ALİ GÖTÜR');
  final TextEditingController phoneController = TextEditingController(text: '0 505 505 55 00');
  final TextEditingController addressController = TextEditingController(text: 'Kadıköy');

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
          alignment: Alignment(-0.2, 0), // Slightly left-aligned
          child: Image.asset(
            'assets/allgotur.png',
            height: 80.0, // Logo size
          ),
        ),
      ),
      body: Stack(
        children: [
          // Upper circle
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
          // Lower circle
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: kToolbarHeight + 20),
                Center(
                  child: Column(
                    children: [
                      // Removed the "taking_food.png" logo
                      const SizedBox(height: 20.0),
                      Text(
                        'KULLANICI HESABIM',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _buildInfoRow(Icons.email, emailController.text),
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.person, nameController.text),
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.phone, phoneController.text),
                      const SizedBox(height: 10.0),
                      _buildInfoRow(Icons.location_on, addressController.text),
                      const SizedBox(height: 30.0), // Increased space before buttons
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const AppOpenScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        child: Text('ÇIKIŞ YAP'),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Background color
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        child: Text(isEditing ? 'Kaydet' : 'Bilgilerimi Düzenle'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Floating action button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0), // Increased padding to move further down
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserReserve(), // Update with appropriate screen
                    ),
                  );
                },
                backgroundColor: Colors.transparent, // Transparent background
                elevation: 0, // No shadow
                child: Image.asset('assets/shopping.png', width: 130.0, height: 130.0), // Increased size of the add button
              ),
            ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserHomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 90.0), // Space for the floating action button
            IconButton(
              icon: Image.asset('assets/profile.png', width: 90.0, height: 90.0), // Increased size
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
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 30.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: TextEditingController(text: text),
            enabled: isEditing,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              filled: true,
              fillColor: Colors.green.withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }
}
