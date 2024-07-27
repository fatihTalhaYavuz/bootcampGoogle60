import 'package:flutter/material.dart';
import 'package:google_bootcamp_60/app_open_screen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/resaddscreen.dart';
import 'package:google_bootcamp_60/pages/loginscreen/restaurant/restaurantscreen/reshomescreen.dart';

class ResProfile extends StatefulWidget {
  const ResProfile({super.key});

  @override
  _ResProfileState createState() => _ResProfileState();
}

class _ResProfileState extends State<ResProfile> {
  bool isEditing = false;
  final TextEditingController emailController =
      TextEditingController(text: 'taking.food@gmail.com');
  final TextEditingController nameController =
      TextEditingController(text: 'TAKING FOOD');
  final TextEditingController phoneController =
      TextEditingController(text: '0 850 505 55 00');
  final TextEditingController addressController =
      TextEditingController(text: 'Kadıköy');

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
                      Image.asset(
                        'assets/taking_food.png',
                        height: 100.0,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'İŞLETME HESABIM',
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
                      const SizedBox(
                          height: 20.0), // Reduced space before buttons
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AppOpenScreen()),
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
                        child:
                            Text(isEditing ? 'Kaydet' : 'Bilgilerimi Düzenle'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Color.fromARGB(255, 255, 255, 255), // Background color
        elevation: 0, // No shadow
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Image.asset('assets/home.png',
                  width: 80.0, height: 80.0), // Adjusted size
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResHomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(width: 40.0), // Space between home and profile
            FloatingActionButton(
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
              child: Image.asset('assets/plus.png',
                  width: 100.0, height: 100.0), // Adjusted size
            ),
            SizedBox(width: 40.0), // Space between profile and floating button
            IconButton(
              icon: Image.asset('assets/profile.png',
                  width: 80.0, height: 80.0), // Adjusted size
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
