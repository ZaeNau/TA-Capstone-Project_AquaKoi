import 'dart:io';
import 'package:aquakoi/Presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_export.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    if (_image != null) {
      prefs.setString('profileImagePath', _image!.path);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
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
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: containerWidth,
                  child: Column(
                    children: [
                      _buildProfileImage(),
                      SizedBox(height: 22),
                      _buildTextFormField(
                        "Name",
                        nameController,
                        "Please enter your name",
                      ),
                      SizedBox(height: 14),
                      _buildTextFormField(
                        "Password",
                        passwordController,
                        "Please enter your password",
                        obscureText: true,
                      ),
                      SizedBox(height: 14),
                      _buildTextFormField(
                        "Confirm Password",
                        confirmpasswordController,
                        "Please confirm your password",
                        obscureText: true,
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
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
                            if (_formKey.currentState?.validate() ?? false) {
                              _saveProfileData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile saved')),
                              );
                              Navigator.pushNamed(context, AppRoutes.profileScreen);
                            }
                          },
                          child: Text(
                            "Save",
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
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text("Edit Profile"),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: _image != null ? FileImage(File(_image!.path)) : null,
        child: _image == null
            ? Icon(Icons.add_a_photo, size: 50)
            : null,
      ),
    );
  }

  Widget _buildTextFormField(
    String label,
    TextEditingController controller,
    String? validationMessage, {
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 6),
          CustomTextFormField(
            controller: controller,
            hintText: label,
            textStyle: TextStyle(color: Colors.black),
            obscureText: obscureText,
            validator: validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return validationMessage;
                  }
                  return null;
                },
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
        currentIndex: 1,
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
