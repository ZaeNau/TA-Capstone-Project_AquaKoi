import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_checkbox_button.dart';
import '../widgets/custom_outlined_button.dart';
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
                    width: 450, // Set the width to your desired value
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
                    width: 450, // Set the width to your desired value
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRememberme(context),
                      SizedBox(width: 230), // Margin antara remember me dan forgot password
                      GestureDetector(
                        onTap: () {
                          onTapForgetPassword(context);
                        },
                        child: Text(
                          "Forgot password?",
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11), // Specify the desired font size here
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 61.v),
                  CustomOutlinedButton(
                    width: 270.h,
                    text: "Log in",
                    onPressed: () {
                      onTapLogIn(context);
                    },
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

      // Check if the widget is still mounted before using the context
      if (!mounted) return;

      // Navigate to dashboard if login is successful
      Navigator.pushNamed(context, AppRoutes.dashboardScreen);
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      // Check if the widget is still mounted before using the context
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
