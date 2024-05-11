import 'package:koiaqua/Presentation/dashboard_screen.dart';

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
                                  SizedBox(height: 15.v),
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
                                  SizedBox(height: 24.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                          onTap: () {
                                            onTapEight(context);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 48.h),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 27.h,
                                                  vertical: 6.v),
                                              decoration: AppDecoration
                                                  .fillBlueA
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadiusStyle
                                                              .roundedBorder11),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 1.v),
                                                    Text("Save edit",
                                                        style: theme.textTheme
                                                            .titleSmall)
                                                  ]))))
                                ]))))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 35.v,
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

  /// Section Widget
    Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Very light opacit 
            spreadRadius: 0,
            blurRadius: 1, // Adjust blur radius to control the shadow spread
            offset: Offset(0, -1), // Changes position of shadow
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.white, width: 1.5), // White line as a top border
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 1, // Set currentIndex to 1 for "edit profile"
        selectedItemColor: Colors.blue,  // Adjust as needed
        unselectedItemColor: Colors.grey,  // Adjust as needed
        backgroundColor: Color(0xFFDFEAF5),  // Use the hex color for the background
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
              // Navigate to DashboardScreen when "Beranda" is tapped
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
              break;
            case 1:
              // Navigate to EditProfileScreen when "Profil" is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }


  /// Navigates to the dashboardScreen when the action is triggered.
  onTapEight(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.dashboardScreen);
  }
}
