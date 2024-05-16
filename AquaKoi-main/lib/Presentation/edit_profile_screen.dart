

import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/app_bar/appbar_title.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

// ignore_for_file: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 70.h),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 25.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          height: 89.v,
                                          width: 87.h,
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                        height: 89.v,
                                                        width: 87.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        44.h),
                                                            border: Border.all(
                                                                color: appTheme
                                                                    .blueA400,
                                                                width: 1.h)))),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                        height: 86.v,
                                                        width: 84.h,
                                                        child: Stack(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            children: [
                                                              CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgEllipse286x84,
                                                                  width: 84.h,
                                                                  radius: BorderRadius
                                                                      .circular(
                                                                          43.h),
                                                                  alignment:
                                                                      Alignment
                                                                          .center),
                                                              CustomImageView(
                                                                  imagePath:
                                                                      ImageConstant
                                                                          .imgSolarCameraMi,
                                                                  height: 16
                                                                      .adaptSize,
                                                                  width: 16
                                                                      .adaptSize,
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4.h))
                                                            ])))
                                              ]))),
                                  SizedBox(height: 22.v),
                                  Text("Name",
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900),
                                  SizedBox(height: 6.v),
                                  _buildName(context),
                                  SizedBox(height: 14.v),
                                  Text("Location",
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900),
                                  SizedBox(height: 6.v),
                                  _buildLocation(context),
                                  SizedBox(height: 14.v),
                                  Text("Email",
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900),
                                  SizedBox(height: 6.v),
                                  _buildEmail(context),
                                  SizedBox(height: 16.v),
                                  Text("Change password",
                                      style: CustomTextStyles
                                          .bodyMediumBluegray900),
                                  SizedBox(height: 4.v),
                                  _buildPassword(context),
                                  SizedBox(height: 16.v),
                                  Text("Confirm password",
                                      style:
                                          CustomTextStyles.bodyMediumGray80002),
                                  SizedBox(height: 4.v),
                                  _buildConfirmpassword(context),
                                  
                                  Align(
  alignment: Alignment.center,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          onTapEight(context);
           // Assuming you just want to close the current screen
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.v),  // Adjusted for symmetry
          padding: EdgeInsets.symmetric(horizontal: 27.h, vertical: 6.v),
          decoration: AppDecoration.fillGreyA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder11,
          ),
          child: Text("Cancel",
            style: theme.textTheme.titleSmall,
            
          ),
        ),
      ),
      SizedBox(width: 20),  // Space between buttons
      GestureDetector(
        onTap: () {
          onTapEight(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.v),  // Adjusted for symmetry
          padding: EdgeInsets.symmetric(horizontal: 27.h, vertical: 6.v),
          decoration: AppDecoration.fillBlueA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder11,
          ),
          child: Text("Save edit",
            style: theme.textTheme.titleSmall,
          ),
        ),
      ),
    ],
  ),
)

                                                
                                ]))))),
            ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 45.v,
        centerTitle: true,
        title: AppbarTitle(text: "Edit Profile"));
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
        controller: nameController, hintText: "Pembudidaya Ikan");
  }

  /// Section Widget
  Widget _buildLocation(BuildContext context) {
    return CustomTextFormField(
        controller: locationController, hintText: "Lembang, Jawa Barat");
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "example@gmail.com",
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "must be 8 characters",
        hintStyle: CustomTextStyles.bodyMediumInterPrimary,
        textInputType: TextInputType.visiblePassword,
        obscureText: true);
  }

  /// Section Widget
  Widget _buildConfirmpassword(BuildContext context) {
    return CustomTextFormField(
        controller: confirmpasswordController,
        hintText: "repeat password",
        hintStyle: CustomTextStyles.bodyMediumInterPrimary,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true);
  }




  /// Navigates to the dashboardScreen when the action is triggered.
  onTapEight(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.profileScreen);
  }
}
