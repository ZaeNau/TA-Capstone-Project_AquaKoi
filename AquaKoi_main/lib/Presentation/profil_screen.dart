import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aquakoi/Presentation/dashboard_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? '';
    emailController.text = prefs.getString('email') ?? ''; // Get email from SharedPreferences
    setState(() {
      _profileImagePath = prefs.getString('profileImagePath'); // Get profile image path
    });
  }

  void _showImagePicker(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileImagePath', pickedFile.path); // Save profile image path to SharedPreferences
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = screenWidth * 0.7;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: containerWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileImage(context),
                    SizedBox(height: 22),
                    _buildDisplayField(context, "Name", nameController),
                    SizedBox(height: 14),
                    _buildDisplayField(context, "Email", emailController),
                    SizedBox(height: 87),
                    SizedBox(
                      height: 36,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppDecoration.fillBlueA.color, // Set the button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.editProfileScreen);
                        },
                        child: Text(
                          "Edit profile",
                          style: CustomTextStyles.labelLargeffffffff,
                        ),
                      ),
                    ),
                    SizedBox(height: 9),
                    SizedBox(
                      height: 36,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppDecoration.fillGray500.color, // Set the button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        },
                        child: Text(
                          "Log out",
                          style: CustomTextStyles.labelLargeffffffff,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("Profile"),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _profileImagePath != null
            ? FileImage(File(_profileImagePath!))
            : AssetImage(ImageConstant.imgEllipse286x84) as ImageProvider, // Default profile picture
      ),
    );
  }

  Widget _buildDisplayField(BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: controller,
            hintText: label, // Add hintText if needed
            textStyle: TextStyle(color: Colors.black), // Set text color to black
            readOnly: true, // Make the field read-only
            onFieldSubmitted: (_) {}, // Add this line
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 1, // Set to 1 because this is the profile screen
        selectedItemColor: AppDecoration.fillBlueA.color,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFFDFEAF5),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
              break;
            case 1:
              // Current screen is ProfileScreen
              break;
          }
        },
      ),
    );
  }
}
