import 'package:koiaqua/Presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text('Pembudidaya Ikan', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('example@gmail.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, '/edit_profile_screen');
              },
              child: Text("Edit Profile", style: TextStyle(color: Colors.white)),
              
            ),
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                // Logic to log out
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

Widget _buildBottomBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 0, blurRadius: 1, offset: Offset(0, -1))],
      border: Border(top: BorderSide(color: Colors.white, width: 1.5)),
    ),
    child: BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFFDFEAF5),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
        } else if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
    ),
  );
}


}
