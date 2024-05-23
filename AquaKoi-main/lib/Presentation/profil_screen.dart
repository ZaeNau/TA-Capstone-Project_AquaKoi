import 'package:flutter/material.dart';
import 'package:koiaqua/Presentation/dashboard_screen.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: appTheme.blueA400,
                          width: 1.h,
                        ),
                        borderRadius: BorderRadiusStyle.roundedBorder44,
                      ),
                      child: Container(
                        height: 89.v,
                        width: 87.h,
                        padding: EdgeInsets.all(1.h),
                        decoration: AppDecoration.outlineBlueA.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder44,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgEllipse2,
                              height: 86.v,
                              width: 84.h,
                              radius: BorderRadius.circular(
                                42.h,
                              ),
                              alignment: Alignment.center,
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgSolarCameraMi,
                              height: 16.adaptSize,
                              width: 16.adaptSize,
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(right: 4.h),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22.v),
                    _buildInputName(context),
                    SizedBox(height: 14.v),
                    _buildInputEmail(context),
                    SizedBox(height: 87.v),
                    CustomElevatedButton(
                      width: 124.h,
                      text: "Edit profile",
                    ),
                    SizedBox(height: 9.v),
                    CustomElevatedButton(
                      width: 124.h,
                      text: "Log Out",
                      buttonStyle: CustomButtonStyles.fillGray,
                    ),
                    SizedBox(height: 5.v)
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile",
      ),
    );
  }

  /// Section Widget
  Widget _buildInputName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 6.v),
          CustomTextFormField(
            width: 220.h,
            controller: nameController,
            hintText: "Pembudidaya Ikan",
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInputEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 6.v),
          CustomTextFormField(
            width: 220.h,
            controller: emailController,
            hintText: "example@gmail.com",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          )
        ],
      ),
    );
  }
}
