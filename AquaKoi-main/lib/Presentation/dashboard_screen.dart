// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:koiaqua/Presentation/edit_profile_screen.dart';

import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/app_bar/appbar_title_searchview.dart';

import 'package:flutter/material.dart';
import '../core/app_export.dart';



class ToggleButton extends StatefulWidget {
  final bool initialState;
  final Function(bool) onToggle;

  ToggleButton({required this.initialState, required this.onToggle});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialState;
  }

  void _toggle() {
    setState(() {
      isOn = !isOn;
    });
    widget.onToggle(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        width: 50,  // Outer container width
        height: 25, // Outer container height
        decoration: isOn
            ? AppDecoration.gradientLightBlueToBlueA // Assuming this is a BoxDecoration
            : AppDecoration.gradientGrayToBlueGray,  // Assuming this is also a BoxDecoration
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isOn ? 25 : 0,  // Moves the toggle button to the right or left
              right: isOn ? 0 : 25,  // Adjusts position based on the state
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: isOn ? Color.fromARGB(255, 0, 0, 0) : Color.fromARGB(255, 0, 0, 0), // Toggle button color
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isOn ? Colors.blue : Colors.grey, // Border color
                    width: 1, // Border width
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  isOn ? 'ON' : 'OFF',  // Displays ON or OFF
                  style: TextStyle(
                    color: isOn ? Colors.blue[700] : Colors.grey[900],  // Text color changes based on the state
                    fontSize: 8,  // Adjusted for smaller inner container
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ParameterCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final double accuracy;
  final bool hasToggle;
  final bool toggleState;
  final String imagePath;
  final VoidCallback? onToggle;

  const ParameterCard({
    Key? key,
    required this.title,
    required this.value,
    required this.unit,
    required this.accuracy,
    this.hasToggle = false,
    this.toggleState = false,
    required this.imagePath,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(imagePath, width: 24, height: 24),
              SizedBox(width: 8),
              Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
            ],
          ),
          Text('$value $unit', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
          LinearProgressIndicator(
            value: accuracy,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          Text('Accuracy: ${(accuracy * 100).toStringAsFixed(0)}%', style: TextStyle(color: Colors.grey[600])),
          if (hasToggle)
            Align(
              alignment: Alignment.centerRight,
              child: Switch(
                value: toggleState,
                onChanged: (_) => onToggle?.call(),
              ),
            ),
        ],
      ),
    );
  }
}




class DashboardScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  


@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: theme.colorScheme.onError,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, // Menyesuaikan lebar container dengan lebar layar
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 1.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.v),
              Text(
                "Smart Monitoring & Controlling",
                style: CustomTextStyles.titleMediumGray800,
                overflow: TextOverflow.ellipsis, // Menambahkan overflow handling pada teks
              ),
              SizedBox(height: 14.v),
              _buildFortyFour(context),
              SizedBox(height: 10.v),
              _buildTwo(context),
              SizedBox(height: 10.v),
              _buildThirtyFive(context),
            ],
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 17.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,  // Centers everything horizontally within the row
            children: [
              AppbarTitleSearchview(
                hintText: "Find Parameter",
                controller: searchController,
              ),
            ],
          ),
        ),
        SizedBox(height: 1), // Space between the search bar and the divider
        Divider(), // A dividing line
        SizedBox(height: 1), // Space after the divider
      ],
    ),
    styleType: Style.bgFill,
  );
}


  /// Section Widget
  Widget _buildFortyFour(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(

            child: Container(
              margin: EdgeInsets.only(right: 4.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 15.v,
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
                                begin: const Alignment(0.03, 0.13),
                                end: const Alignment(1, 1),
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
                  SizedBox(height: 15.v),
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
                
                ],
              ),
            )

          ),


////Ammonia
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 15.v,
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
                      padding: EdgeInsets.only(left: 5.h),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgVector,
                          height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(bottom: 3.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.h),
                          child: Text(
                            "Ammonia level",
                            style: CustomTextStyles.bodySmallPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  
                  SizedBox(height: 24.v),
                  Container(
                    height: 28.v,
                    width: 72.h,
                    
                    child: Stack(
                      alignment:  Alignment.topLeft,
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
                                begin: const Alignment(0.03, 0.13),
                                end: const Alignment(1, 1),
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
                          child: Padding(padding: EdgeInsets.only(left: 12.5.h),
                            child: Text(
                            "0.2 mg",
                            style: theme.textTheme.titleLarge,
                          ),
                          )
                          
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.v),
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
                                        value: 0.25,
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
  return Padding(padding: EdgeInsets.symmetric(horizontal: 5.0),
  child: Container(
  
    padding: EdgeInsets.symmetric(
      horizontal: 10.h,
      vertical: 15.v,
    ),
    decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
      borderRadius: BorderRadiusStyle.roundedBorder18,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      
      children: [
        Align( 
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 4.h),
          child: Row(children: [  CustomImageView(
          imagePath: ImageConstant.imgThumbsUp,
          height: 12.adaptSize,
          width: 12.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
            Padding(
              padding: EdgeInsets.only(
                left: 3.h
              ),
              child: Text(
                "Temperature",
                style: CustomTextStyles.bodySmallPrimaryContainer,
              ),
            ), 
          ],
          )
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
                            padding: EdgeInsets.only(left: 15.h),
                            child: Text(
                              "25 C",
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                        
                      ],
                      
        ), ),
        
        SizedBox(height: 15.v),
        Container(
          height: 60.v,
            width: 300.h,
          
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
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
                          height: 20.v,
                          width: 150.h,
                          decoration: BoxDecoration(
                            color: appTheme.blueGray100,
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.h),
                            child: LinearProgressIndicator(
                              value: 0.25,
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
                  padding: EdgeInsets.only(left: 75.h),
                  child: _buildFifteen(
                    context,
                    twentyFive: "25%",
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 24.v),
        Padding(
  padding: EdgeInsets.only(right: 4.h), // Apply right padding
  child: Align(
    alignment: Alignment.centerRight, // Align contents to the center-right
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text and buttons to start of the column
      children: [
        Text(
          "Heater",
          style: CustomTextStyles.bodySmallPrimaryContainer_1,
        ),
        SizedBox(height: 3.v),
        ToggleButton(
          initialState: true, // You may want to control this state based on actual data
          onToggle: (bool value) {
            print("Heater is now: $value");
          },
        ),
        SizedBox(height: 10.v),
        Text(
          "Cooler",
          style: CustomTextStyles.bodySmallPrimaryContainer_1,
        ),
        SizedBox(height: 3.v),
        ToggleButton(
          initialState: false, // You may want to control this state based on actual data
          onToggle: (bool value) {
            print("Cooler is now: $value");
          },
        ),
      ],
    ),
  ),
)

        
      ],
    ),
  )
  );
  
}


  /// Section Widget
  Widget _buildThirtyFive(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container (
               margin: EdgeInsets.only(right: 4.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 15.v,
              ),
              decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                   alignment: Alignment.centerLeft,
                   child: Padding(padding: EdgeInsets.only(left: 4.h),
                   child: Row(
                     children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgFavoritePrimarycontainer,
                          height: 12.adaptSize, 
                          width: 12.adaptSize,
                          margin: EdgeInsets.only(bottom: 3.v),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.h),
                          child: Text(
                            "Total dissolved water",
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
                                begin: const Alignment(0.03, 0.13),
                                end: const Alignment(1, 1),
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
                          child: Padding(padding: EdgeInsets.only(left: 22.h),
                          child: Text(
                            "147 ppm",
                            style: theme.textTheme.titleLarge,
                          ),
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.v),
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
                  SizedBox(height: 24.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: Text(
                        "Water pump",
                        style: CustomTextStyles.bodySmallPrimaryContainer_1,
                      ),
                    ),
                   
                  ),
                   SizedBox(height: 3.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ToggleButton(
                          initialState: true,
                          onToggle: (bool value) {
                            print("ToggleButton is now: $value");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
          
          /////dissolved oxygen
          Expanded(    
                child: Container(
                  margin: EdgeInsets.only(left: 4.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 15.v,
                  ),
                  decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(padding: 
                           EdgeInsets.only(left: 5.h),
                      
                        
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgBrightness,
                              height: 12.adaptSize,
                              width: 12.adaptSize,
                              margin: EdgeInsets.only(bottom: 3.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.h,
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
                                    begin: const Alignment(0.03, 0.13),
                                    end: const Alignment(1, 1),
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
                              child: Text(
                                "2.5 mg/L",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.v),
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
                      SizedBox(height: 24.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.h),
                          child: Text(
                            "Water pump",
                            style: CustomTextStyles.bodySmallPrimaryContainer_1,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Align(
                        alignment: Alignment.centerRight,
                        
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ToggleButton(
                                  initialState: true,
                                  onToggle: (bool value) {
                                    print("ToggleButton is now: $value");
                                  },
                                ),
                              ],
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
        currentIndex: 0, // Set currentIndex to 0 for "Beranda"
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
