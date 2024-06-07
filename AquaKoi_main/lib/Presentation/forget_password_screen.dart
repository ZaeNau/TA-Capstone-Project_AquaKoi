import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_outlined_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your email to reset password",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              CustomTextFormField(
                controller: emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                }, onFieldSubmitted: (_) {  },
              ),
              SizedBox(height: 20.0),
              CustomOutlinedButton(
                text: "Reset Password",
                onPressed: () {
                  resetPassword(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Password reset email sent. Check your email inbox."),
        ));
        // Optionally navigate back to login screen or another screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error sending password reset email. Please try again."),
        ));
      }
    }
  }
}
