import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_checkbox_button.dart';
import '../widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 1.v),
                                  Text("Log in",
                                      style:
                                          CustomTextStyles.titleLargePrimary22),
                                  SizedBox(height: 60.v),
                                  Text("Email address",
                                      style: theme.textTheme.bodyMedium),
                                  SizedBox(height: 6.v),
                                  CustomTextFormField(
                                      width: 220.h,
                                      controller: emailController,
                                      hintText: "ikankoiku@gmail.com",
                                      hintStyle:
                                          CustomTextStyles.bodyMediumInter,
                                      textInputType:
                                          TextInputType.emailAddress),
                                  SizedBox(height: 16.v),
                                  Text("Password",
                                      style: theme.textTheme.bodyMedium),
                                  SizedBox(height: 6.v),
                                  CustomTextFormField(
                                      width: 220.h,
                                      controller: passwordController,
                                      textInputAction: TextInputAction.done,
                                      suffix: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              30.h, 12.v, 6.h, 12.v),
                                          child: CustomImageView(
                                              imagePath: ImageConstant.imgIcon,
                                              height: 12.adaptSize,
                                              width: 12.adaptSize)),
                                      suffixConstraints:
                                          BoxConstraints(maxHeight: 36.v),
                                      obscureText: true),
                                  SizedBox(height: 6.v),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildRememberme(context),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 79.h),
                                            child: Text("Forgot password?",
                                                style:
                                                    theme.textTheme.bodySmall))
                                      ]),
                                  SizedBox(height: 61.v),
                                  CustomOutlinedButton(
                                      width: 220.h,
                                      text: "Log in",
                                      onPressed: () {
                                        onTapLogIn(context);
                                      }),
                                  SizedBox(height: 63.v),
                                  GestureDetector(
                                      onTap: () {
                                        onTapTxtDonthaveanaccount(context);
                                      },
                                      child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "Don’t have an account? ",
                                                style: CustomTextStyles
                                                    .bodyMediumff000000),
                                            TextSpan(
                                                text: "Sign up",
                                                style: CustomTextStyles
                                                    .labelLargeff000000)
                                          ]),
                                          textAlign: TextAlign.left))
                                ])))))));
  }

  /// Section Widget
  Widget _buildRememberme(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 1.v),
        child: CustomCheckboxButton(
            text: "Remember me",
            value: rememberme,
            onChange: (value) {
              rememberme = value;
            }));
  }

  /// Navigates to the dashboardScreen when the action is triggered.
  onTapLogIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboardScreen);
  }

  /// Navigates to the registerScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerScreen);
  }
}
