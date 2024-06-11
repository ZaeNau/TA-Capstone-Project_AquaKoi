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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Panduan Image with text below
              _buildPanduanImageWithText(
                "assets/images/image_not_found.png",
                "Panduan 1 \n •	Login \n 1.	Jika sudah memiliki akun, masukkan username dan password pada halaman login, lalu klik tombol “Log in” atau dapat langsung menekan tombol “Sign in with Google” sebagai opsi lainnya. \n2.	Jika belum memiliki akun, klik tombol Sign up",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/image_not_found.png",
                "Panduan 2",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/image_not_found.png",
                "Panduan 3",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/image_not_found.png",
                "Panduan 4",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/image_not_found.png",
                "Panduan 5",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanduanImageWithText(String imagePath, String text) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
            SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
