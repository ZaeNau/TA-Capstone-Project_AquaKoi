import 'package:flutter/material.dart';

class PanduanScreen extends StatefulWidget {
  const PanduanScreen({super.key});

  @override
  _PanduanScreenState createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          "Panduan",
          style: TextStyle(
            color: Colors.black, // Set title text color to black
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10), // Add some spacing at the top
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Card with blue background and image
                  Card(
                    elevation: 4, // Add elevation to make the card pop out
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue,
                    child: Container(
                      height: 150,
                      child: Center(
                        child: Image.asset(
                          "assets/images/image_not_found.png", // Replace with your actual image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  // Panduan Image with text overlay
                  _buildPanduanImage(
                    "assets/images/image_not_found.png",
                    "Panduan 1", // Text to display
                    "assets/images/image_not_found.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/images/image_not_found.png",
                    "Panduan 2", // Text to display
                    "assets/images/image_not_found.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/images/image_not_found.png",
                    "Panduan 3", // Text to display
                    "assets/images/image_not_found.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/images/image_not_found.png",
                    "Panduan 4", // Text to display
                    "assets/images/image_not_found.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/images/image_not_found.png",
                    "Panduan 5", // Text to display
                    "assets/images/image_not_found.png", // Image to display within the rectangle
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanduanImage(String rectangleImagePath, String text,
      String imageImagePath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          rectangleImagePath, // Image of the rectangle
          width: double.infinity, // Full width of the screen
          fit: BoxFit.fitWidth, // Fit the image to the width of the screen
        ),
        Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold, // Make the text bold
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10), // Add some spacing
            Image.asset(
              imageImagePath, // Image to display within the rectangle
              height: 60, // Adjust the height of the image as needed
            ),
          ],
        ),
      ],
    );
  }
}