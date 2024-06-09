import 'package:flutter/material.dart';

class GuideFragment extends StatefulWidget {
  @override
  _GuideFragmentState createState() => _GuideFragmentState();
}

class _GuideFragmentState extends State<GuideFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                          "assets/judul_panduan_2.png", // Replace with your actual image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),
                  // Panduan Image with text overlay
                  _buildPanduanImage(
                    "assets/rectangle_panduan.png",
                    "Panduan 1", // Text to display
                    "assets/panduan_1.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/rectangle_panduan.png",
                    "Panduan 2", // Text to display
                    "assets/switch_svg.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/rectangle_panduan.png",
                    "Panduan 3", // Text to display
                    "assets/panduan_3.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/rectangle_panduan.png",
                    "Panduan 4", // Text to display
                    "assets/panduan_4.png", // Image to display within the rectangle
                  ),
                  SizedBox(height: 12),
                  _buildPanduanImage(
                    "assets/rectangle_panduan.png",
                    "Panduan 5", // Text to display
                    "assets/panduan_5.png", // Image to display within the rectangle
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