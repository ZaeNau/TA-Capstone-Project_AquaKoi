import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/app_bar/appbar_title_searchview.dart';
import '../widgets/app_bar/appbar_title_circleimage.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onError,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 8.h,
            vertical: 2.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 13.v),
              Text(
                "Smart Monitoring & Controlling",
                style: CustomTextStyles.titleMediumGray800,
              ),
              SizedBox(height: 14.v),
              _buildFortyFour(context),
              SizedBox(height: 8.v),
              _buildTwo(context),
              SizedBox(height: 8.v),
              _buildThirtyFive(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 17.h,
              right: 18.h,
            ),
            child: Row(
              children: [
                AppbarTitleSearchview(
                  hintText: "Find Parameter",
                  controller: searchController,
                ),
                AppbarTitleCircleimage(
                  imagePath: ImageConstant.imgEllipse2,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    top: 1.v,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.v),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildFortyFour(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 4.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 12.v,
              ),
              decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSettings,
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(bottom: 3.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 3.h),
                            child: Text(
                              "pH level",
                              style: CustomTextStyles.bodySmallPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.v),
                  SizedBox(
                    height: 28.v,
                    width: 72.h,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 28.v,
                            width: 72.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                6.h,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment(0.03, 0.13),
                                end: Alignment(1, 1),
                                colors: [
                                  appTheme.gray200,
                                  appTheme.gray100,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 22.h),
                            child: Text(
                              "7.1",
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.v),
                  SizedBox(
                    height: 55.v,
                    width: 147.h,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: _buildFortyEight(
                                    context,
                                    bad: "bad",
                                    good: "good",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Container(
                                    height: 16.v,
                                    width: 132.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.blueGray100,
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: 0.77,
                                        backgroundColor: appTheme.blueGray100,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          appTheme.greenA700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "Level accuracy",
                                    style: CustomTextStyles
                                        .googleSansPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 24.h),
                          child: _buildFifteen(
                            context,
                            twentyFive: "75%",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.v),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 8.v,
              ),
              decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.v),
                  Padding(
                    padding: EdgeInsets.only(left: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgVector,
                          height: 7.v,
                          margin: EdgeInsets.only(
                            top: 2.v,
                            bottom: 4.v,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h),
                          child: Text(
                            "Ammonia level",
                            style: CustomTextStyles.bodySmallPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.v),
                  Container(
                    height: 29.v,
                    width: 72.h,
                    margin: EdgeInsets.only(left: 35.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 28.v,
                            width: 72.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                6.h,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment(0.03, 0.13),
                                end: Alignment(1, 1),
                                colors: [
                                  appTheme.gray200,
                                  appTheme.gray100,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "0.2 mg",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.v),
                  SizedBox(
                    height: 55.v,
                    width: 147.h,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: _buildFortyEight(
                                    context,
                                    bad: "bad",
                                    good: "good",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Container(
                                    height: 16.v,
                                    width: 132.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.blueGray100,
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: 0.3,
                                        backgroundColor: appTheme.blueGray100,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          theme.colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "Level accuracy",
                                    style: CustomTextStyles
                                        .googleSansPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 38.h),
                          child: _buildFifteen(
                            context,
                            twentyFive: "25%",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 11.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 19.h),
                      child: Text(
                        "Filtering",
                        style: CustomTextStyles.bodySmallPrimaryContainer_1,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 41.h,
                      margin: EdgeInsets.only(
                        left: 99.h,
                        right: 7.h,
                      ),
                      padding: EdgeInsets.all(1.h),
                      decoration: AppDecoration.gradientGrayToBlueGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: Container(
                        width: 14.adaptSize,
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.h,
                          vertical: 3.v,
                        ),
                        decoration:
                            AppDecoration.fillOnSecondaryContainer.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Text(
                          "OFF",
                          style: CustomTextStyles.montserratGray300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTwo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 13.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgThumbsUp,
            height: 10.v,
            margin: EdgeInsets.only(bottom: 79.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              bottom: 76.v,
            ),
            child: Text(
              "Temperature",
              style: CustomTextStyles.bodySmallPrimaryContainer,
            ),
          ),
          Container(
            height: 55.v,
            width: 147.h,
            margin: EdgeInsets.only(
              left: 5.h,
              top: 15.v,
              bottom: 19.v,
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.h,
                      vertical: 1.v,
                    ),
                    decoration: AppDecoration.outlineBlueGray.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder15,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: _buildFortyEight(
                            context,
                            bad: "bad",
                            good: "good",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Container(
                            height: 16.v,
                            width: 132.h,
                            decoration: BoxDecoration(
                              color: appTheme.blueGray100,
                              borderRadius: BorderRadius.circular(
                                8.h,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                8.h,
                              ),
                              child: LinearProgressIndicator(
                                value: 0.3,
                                backgroundColor: appTheme.blueGray100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Level accuracy",
                            style: CustomTextStyles.googleSansPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 38.h),
                  child: _buildFifteen(
                    context,
                    twentyFive: "25%",
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 12.v,
              right: 4.h,
              bottom: 12.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Heater",
                  style: CustomTextStyles.bodySmallPrimaryContainer_1,
                ),
                SizedBox(height: 3.v),
                Container(
                  width: 41.h,
                  padding: EdgeInsets.all(1.h),
                  decoration: AppDecoration.gradientLightBlueToBlueA.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Container(
                    width: 14.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                      vertical: 3.v,
                    ),
                    decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    ),
                    child: Text(
                      "ON",
                      style: CustomTextStyles.montserratBlueA400,
                    ),
                  ),
                ),
                SizedBox(height: 3.v),
                Text(
                  "Cooler",
                  style: CustomTextStyles.bodySmallPrimaryContainer_1,
                ),
                SizedBox(height: 3.v),
                Container(
                  width: 41.h,
                  padding: EdgeInsets.all(1.h),
                  decoration: AppDecoration.gradientGrayToBlueGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Container(
                    width: 14.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.h,
                      vertical: 3.v,
                    ),
                    decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    ),
                    child: Text(
                      "OFF",
                      style: CustomTextStyles.montserratGray300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyFive(BuildContext context) {
    return SizedBox(
      height: 167.v,
      width: 342.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(right: 175.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 7.v,
              ),
              decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.h,
                      right: 23.h,
                    ),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgFavoritePrimarycontainer,
                          width: 11.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.h),
                          child: Text(
                            "Total dissolved solids",
                            style: CustomTextStyles.bodySmallPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.v),
                  Container(
                    height: 28.v,
                    width: 97.h,
                    margin: EdgeInsets.only(left: 22.h),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 28.v,
                            width: 97.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                6.h,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment(0.03, 0.13),
                                end: Alignment(1, 1),
                                colors: [
                                  appTheme.gray200,
                                  appTheme.gray100,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "147 ppm",
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.v),
                  SizedBox(
                    height: 55.v,
                    width: 147.h,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.h,
                              vertical: 1.v,
                            ),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: _buildFortyEight(
                                    context,
                                    bad: "bad",
                                    good: "good",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Container(
                                    height: 16.v,
                                    width: 132.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.blueGray100,
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        8.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: 0.77,
                                        backgroundColor: appTheme.blueGray100,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          appTheme.greenA700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "Level accuracy",
                                    style: CustomTextStyles
                                        .googleSansPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 25.h),
                          child: _buildFifteen(
                            context,
                            twentyFive: "75%",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 11.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 3.h),
                      child: Text(
                        "Water pump",
                        style: CustomTextStyles.bodySmallPrimaryContainer_1,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 142.v,
                    bottom: 8.v,
                  ),
                  padding: EdgeInsets.all(1.h),
                  decoration: AppDecoration.gradientGrayToBlueGray.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Container(
                    width: 14.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.h,
                      vertical: 3.v,
                    ),
                    decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    ),
                    child: Text(
                      "OFF",
                      style: CustomTextStyles.montserratGray300,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 6.v,
                  ),
                  decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.h),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgBrightness,
                              width: 13.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.h,
                                top: 2.v,
                              ),
                              child: Text(
                                "Dissolved oxygen",
                                style:
                                    CustomTextStyles.bodySmallPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 9.v),
                      Container(
                        height: 28.v,
                        width: 97.h,
                        margin: EdgeInsets.only(left: 22.h),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 28.v,
                                width: 97.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    6.h,
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment(0.03, 0.13),
                                    end: Alignment(1, 1),
                                    colors: [
                                      appTheme.gray200,
                                      appTheme.gray100,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "2.5 mg/L",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.v),
                      SizedBox(
                        height: 55.v,
                        width: 147.h,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.h,
                                  vertical: 1.v,
                                ),
                                decoration:
                                    AppDecoration.outlineBlueGray.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder15,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 6.v),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: _buildFortyEight(
                                        context,
                                        bad: "bad",
                                        good: "good",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Container(
                                        height: 16.v,
                                        width: 132.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.blueGray100,
                                          borderRadius: BorderRadius.circular(
                                            8.h,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8.h,
                                          ),
                                          child: LinearProgressIndicator(
                                            value: 0.55,
                                            backgroundColor:
                                                appTheme.blueGray100,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              appTheme.amber700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.v),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text(
                                        "Level accuracy",
                                        style: CustomTextStyles
                                            .googleSansPrimaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 52.h),
                              child: _buildFifteen(
                                context,
                                twentyFive: "50%",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 3.h),
                          child: Text(
                            "Water pump",
                            style: CustomTextStyles.bodySmallPrimaryContainer_1,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 41.h,
                          margin: EdgeInsets.only(
                            left: 99.h,
                            right: 7.h,
                          ),
                          padding: EdgeInsets.all(1.h),
                          decoration:
                              AppDecoration.gradientLightBlueToBlueA.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Container(
                            width: 14.adaptSize,
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.h,
                              vertical: 3.v,
                            ),
                            decoration:
                                AppDecoration.fillOnSecondaryContainer.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder8,
                            ),
                            child: Text(
                              "ON",
                              style: CustomTextStyles.montserratBlueA400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.v),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 26.h,
        right: 30.h,
      ),
      child: SizedBox(
        height: 45.v,
        width: 304.h,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 45.v,
                width: 304.h,
                decoration: BoxDecoration(
                  color: appTheme.blueA400,
                  borderRadius: BorderRadius.circular(
                    15.h,
                  ),
                ),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgGroup36708,
              height: 23.v,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 34.h),
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildFortyEight(
    BuildContext context, {
    required String bad,
    required String good,
  }) {
    return SizedBox(
      width: 131.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bad,
            style: CustomTextStyles.googleSansSecondaryContainer.copyWith(
              color: theme.colorScheme.secondaryContainer,
            ),
          ),
          Text(
            good,
            style: CustomTextStyles.googleSansGreenA700.copyWith(
              color: appTheme.greenA700,
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildFifteen(
    BuildContext context, {
    required String twentyFive,
  }) {
    return SizedBox(
      height: 22.v,
      width: 23.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFavorite,
            height: 22.v,
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 3.v,
                right: 3.h,
              ),
              child: Text(
                twentyFive,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
