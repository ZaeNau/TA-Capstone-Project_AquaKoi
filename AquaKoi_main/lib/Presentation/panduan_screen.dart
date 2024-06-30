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
                "assets/images/panduan (1).png",
                """Panduan 1 
                \n •	Login 
                \n 1.	Jika sudah memiliki akun, masukkan username dan password pada halaman login, lalu klik tombol “Log in” atau dapat langsung menekan tombol “Sign in with Google” sebagai opsi lainnya. 
                \n2.	Jika belum memiliki akun, klik tombol “Sign up”. 
                \n3. Klik tombol Panduan untuk mendapat intruksi penggunaan aplikasi.""",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (2).png",
                """Panduan 2 
                \n •	Sign up 
                \n1.	Isi formulir pendaftaran dengan informasi yang diperlukan, lalu klik tombol submit untuk membuat akun baru. Sistem akan kembali ke halaman login. 
                \n2.	Jika sudah memiliki akun, klik tombol “Log in”.""",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (3).png",
                """Panduan 3 
                \n •	Dashboard 
                \n1.	Pada dashboard, data monitoring secara real-time akan ditampilkan. 
                \n2.	Controlling / tindakan penstabilan dapat dilakukan melalui halaman ini.
                \n3.  Terdapat informasi range nilai dari setiap parameter.
                \n4.	Klik icon profile jika ingin berpindah ke halaman profile.""",
               ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (4).png",
                """Panduan 4 
                \n •	Monitoring Kualitas Air pada halaman dashboard
                \n1.	Data ditampilkan secara real-time yang meliputi tingkat keasaman (pH), tingkat ammonia, temperature, total dissolved water (TDS), serta kekeruhan (turbidity).""",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (5).png",
                """Panduan 5 
                \n •	Controlling Kualitas Air pada halaman dashboard 
                \n1.  Kondisi menyala atau tidak “Heater” dan “Cooler” akan ter-display jika terjadi abnormal pada paramater.
                \n2.	Kondisi menyala atau tidak “Filter” akan ter-display jika terjadi abnormal pada Turbidity atau TDS.""",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (6).png",
                """Panduan 6 
                \n •	Profile 
                \n1. Informasi akun, yakni foto profil, nama, dan email dapat dilihat.
                \n2. Klik tombol “Edit Profile” untuk mengubah informasi profil.
                \n3. Klik tombol “Log out” untuk mengeluarkan akun dari aplikasi
                \n4. Klik icon dashboard jika ingin berpindah ke halaman dashboard.""",
              ),
              SizedBox(height: 12),
              _buildPanduanImageWithText(
                "assets/images/panduan (7).png",
                """Panduan 7 
                \n •	Edit Profile 
                \n1. Klik icon kembali jika tidak ingin melakukan perubahan.
                \n2. Klik ikon kamera di atas gambar avatar untuk mengganti foto profil.
                \n3. Isi informasi yang ingin diubah, yakni terdapat name, change password, dan confirm password.
                \n4. Klik tombol "Save" untuk menyimpan perubahan.""",
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
              height: 300,
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
