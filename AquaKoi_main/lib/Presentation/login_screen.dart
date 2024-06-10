import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aquakoi/widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_checkbox_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aquakoi/common/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../core/app_export.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  bool rememberme = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 

  @override
Widget build(BuildContext context) {
   final screenWidth = MediaQuery.of(context).size.width;
  final containerWidth = screenWidth * 0.7; 
  

  return SafeArea(
    child: Scaffold(
      backgroundColor: theme.colorScheme.onError,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 1.v),
                  Text("Log in", style: CustomTextStyles.titleLargePrimary22),
                  SizedBox(height: 60.v),
                  Text("Email address", style: theme.textTheme.bodyMedium),
                  SizedBox(height: 6.v),
                  Container(
                    width: containerWidth, // Set the width to your desired value
                    child: CustomTextFormField(
                      controller: emailController,
                      hintText: "ikankoiku@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      textStyle:  CustomTextStyles.bodyMediumInter.copyWith(
                                        color: Color(0XFF000000),
                                      ),
                      onFieldSubmitted: (_) => _focusNextField(context, passwordFocusNode),
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Text("Password", style: theme.textTheme.bodyMedium),
                  SizedBox(height: 6.v),
                  Container(
                    width: containerWidth, // Set the width to your desired value
                    child: CustomTextFormField(
                      controller: passwordController,
                      hintText: "password",
                      textInputAction: TextInputAction.done,
                      textStyle:  CustomTextStyles.bodyMediumInter.copyWith(
                                        color: Color(0XFF000000),
                                      ),
                      focusNode: passwordFocusNode,
                      onFieldSubmitted: (_) => onTapLogIn(context),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10.v),
                   Container(
                width: containerWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRememberme(context),
                    GestureDetector(
                      onTap: () {
                        onTapForgetPassword(context);
                      },
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
                  SizedBox(height: 61.v),
                  CustomElevatedButton(
                    width: containerWidth,
                    text: "Log in",
                    buttonTextStyle: CustomTextStyles.labelLargeff000000,
                    onPressed: () {
                      onTapLogIn(context);
                    },
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      _signInWithGoogle();
                    },
                  child: Container(
                  width: containerWidth,
                  height: 45,
                  decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  ),                    
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  SizedBox(height: 63.v),
                  GestureDetector(
                    onTap: () {
                      onTapTxtDonthaveanaccount(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style: CustomTextStyles.bodyMediumff000000,
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: CustomTextStyles.labelLargeff000000,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


  /// Section Widget
  Widget _buildRememberme(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.v),
      child: CustomCheckboxButton(
        text: "Remember me",
        textStyle: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
        value: rememberme,
        onChange: (value) {
          setState(() {
            rememberme = value;
            // Simpan status rememberme ke penyimpanan lokal di sini
          });
        },
      ),
    );
  }



  /// Handles login action with Firebase Authentication.
void onTapLogIn(BuildContext context) async {
  if (_formKey.currentState!.validate()) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Use userCredential here
      User? user = userCredential.user;
      if (user != null) {
        ('User ID: ${user.uid}');
        ('User Email: ${user.email}');
      }

      // Save login state to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      // Check if the widget is still mounted before using the context
      if (!mounted) return;

      // Navigate to dashboard if login is successful
      Navigator.pushNamed(context, AppRoutes.dashboardScreen);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'You are not registered.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Your password is incorrect.';
      } else {
        errorMessage = 'You account not registered. \n Please try again.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


/// Handles login action with Google Authentication.

_signInWithGoogle() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Save login state to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      Navigator.pushNamed(context, AppRoutes.dashboardScreen);
    }
  } catch (e) {
    showToast(message: "Some error occurred $e");
  }
}
}

  /// Navigates to the registerScreen when the action is triggered.
  void onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerScreen);
  }

  /// Navigates to the forgetPasswordScreen when the action is triggered.
  void onTapForgetPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen); // Menggunakan rute yang sudah didefinisikan
  }

  /// Fungsi untuk mengatur fokus ke field berikutnya
  void _focusNextField(BuildContext context, FocusNode nextFocus) {
    FocusScope.of(context).requestFocus(nextFocus);
  }