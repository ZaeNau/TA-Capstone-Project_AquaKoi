import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koiaqua/Presentation/login_screen.dart';
import '../widgets/custom_outlined_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../core/app_export.dart';
import 'package:flutter/gestures.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onError,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  top: 36.v,
                  bottom: 40.v,
                ),
                child: Column(
                  children: [
                    Text(
                      "Sign up",
                      style: CustomTextStyles.titleLargePrimary22,
                    ),
                    SizedBox(height: 60.v),
                    Text(
                      "Name",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 6.v),
                    _buildName(context),
                    SizedBox(height: 16.v),
                    Text(
                      "Email",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 6.v),
                    _buildEmail(context),
                    SizedBox(height: 18.v),
                    Text(
                      "Create a password",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 4.v),
                    _buildPassword(context),
                    SizedBox(height: 18.v),
                    Text(
                      "Confirm password",
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: 4.v),
                    _buildConfirmpassword(context),
                    SizedBox(height: 63.v),
                    _buildSignUp(context),
                    SizedBox(height: 63.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: CustomTextStyles.bodyMediumffffffff,
                          ),
                          TextSpan(
                            text: "Log in",
                            style: CustomTextStyles.labelLargeffffffff,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
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

  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      width: 220.h,
      controller: nameController,
      hintText: "Ikan Koi",
      textInputType: TextInputType.name,
      onFieldSubmitted: (_) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name.';
        }
        return null;
      },
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      width: 220.h,
      controller: emailController,
      hintText: "example@gmail.com",
      textInputType: TextInputType.emailAddress,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      width: 220.h,
      controller: passwordController,
      hintText: "must be 8 characters",
      hintStyle: CustomTextStyles.bodyMediumInterPrimary,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildConfirmpassword(BuildContext context) {
    return CustomTextFormField(
      width: 220.h,
      controller: confirmpasswordController,
      hintText: "repeat password",
      hintStyle: CustomTextStyles.bodyMediumInterPrimary,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      onFieldSubmitted: (_) {},
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return CustomOutlinedButton(
      width: 220.h,
      text: "Sign up",
      onPressed: () {
        onTapSignUp(context);
      },
    );
  }

  void onTapSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmpasswordController.text) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } on FirebaseAuthException catch (e) {
          String message;
          if (e.code == 'weak-password') {
            message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            message = 'The account already exists for that email.';
          } else {
            message = 'An error occurred. Please try again.';
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match.')));
      }
    }
  }
}
