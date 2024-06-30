import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:getwidget/getwidget.dart';
import 'package:aquakoi/Presentation/profil_screen.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

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
              Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ],
          ),
          Text('$value $unit',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          LinearProgressIndicator(
            value: accuracy,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          Text('Accuracy: ${(accuracy * 100).toStringAsFixed(0)}%',
              style: TextStyle(color: Colors.grey[600])),
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

class DashboardScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DatabaseReference _sensorsReference = FirebaseDatabase.instance
      .ref()
      .child('UsersData')
      .child('cSFGHidGb4gzLBalujMaowdFDGG2')
      .child('Sensors');
  final DatabaseReference _relayStateReference = FirebaseDatabase.instance
      .ref()
      .child('UsersData')
      .child('cSFGHidGb4gzLBalujMaowdFDGG2')
      .child('relayState');

  Map<String, dynamic> sensorData = {};
  bool _heaterState = false;
  bool _coolerState = false;
  bool _waterpState = false;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      //Fetch Sensors data
      _sensorsReference.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          setState(() {
            sensorData = Map<String, dynamic>.from(data);
          });
        } else {
          setState(() {
            sensorData = {};
          });
        }
      });
      //Fetch Relay Data
      _relayStateReference.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          setState(() {
            _heaterState = data['heater'] == '1';
            _coolerState = data['chiller'] == '1';
            _waterpState = data['waterpump'] == '1';
          });
        }
      });
    } else {
      // Redirect to login if not authenticated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      });
    }

    // Listen for changes in the 'Heater', 'chiller', and 'WaterPump' nodes
    _relayStateReference.child('heater').onValue.listen((event) {
      var value = event.snapshot.value;
      setState(() {
        _heaterState = (value == '1');
      });
    });

    _relayStateReference.child('chiller').onValue.listen((event) {
      var value = event.snapshot.value;
      setState(() {
        _coolerState = (value == '1');
      });
    });

    _relayStateReference.child('waterpump').onValue.listen((event) {
      var value = event.snapshot.value;
      setState(() {
        _waterpState = (value == '1');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onError,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 1.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.v),
                Text(
                  "Smart Monitoring & Controlling",
                  style: CustomTextStyles.titleMediumGray800,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 14.v),
                _buildRowWithPHAndAmmonia(context),
                SizedBox(height: 10.v),
                _buildTemperature(context),
                SizedBox(height: 10.v),
                _buildRowWithTDSAndTurbidity(context),
                SizedBox(height: 10.v),
                _buildParameterRangeInfo(context),
                SizedBox(height: 10.v)
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildRowWithPHAndAmmonia(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildPH(context)),
          Expanded(child: _buildAmmonia(context)),
        ],
      ),
    );
  }

  Widget _buildTemperature(BuildContext context) {
    double tempPercentage = sensorData['SuhuPercentage'] != null
        ? double.tryParse(sensorData['SuhuPercentage'])! / 100
        : 0.0;

    // Display the correct percentage, even if it exceeds 100%
    String tempPercentageDisplay =
        (tempPercentage * 100).toStringAsFixed(0) + "%";

    // Clamp the percentage for the GFProgressBar display
    double tempPercentageClamped = tempPercentage.clamp(0.0, 1.0);

    // Determine progress bar color based on the percentage
    Color barColor;
    if (tempPercentageClamped > 0.9333 || tempPercentageClamped < 0.6667) {
      barColor = Colors.red;
    } else {
      barColor = Colors.green;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
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
              child: Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgThumbsUp,
                      height: 12.adaptSize,
                      width: 12.adaptSize,
                      margin: EdgeInsets.only(bottom: 3.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.h),
                      child: Text(
                        "Temperature",
                        style: CustomTextStyles.bodySmallPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.v),
            SizedBox(
              height: 37.v,
              width: 147.h,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 37.v,
                      width: 147.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.h),
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
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        "${sensorData['Suhu'] ?? 'N/A'} C",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.v),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 60.v,
                width: 250.h,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.h, vertical: 1.v),
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
                              child: SizedBox(
                                width: 223.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bad",
                                      style: CustomTextStyles
                                          .googleSansSecondaryContainer
                                          .copyWith(
                                        color: theme
                                            .colorScheme.secondaryContainer,
                                        fontSize:
                                            11.0, // Adjust the font size here
                                      ),
                                    ),
                                    Text(
                                      "Good",
                                      style: CustomTextStyles
                                          .googleSansGreenA700
                                          .copyWith(
                                        color: appTheme.greenA700,
                                        fontSize:
                                            11.0, // Adjust the font size here
                                      ),
                                    ),
                                    Text(
                                      "Bad",
                                      style: CustomTextStyles
                                          .googleSansSecondaryContainer
                                          .copyWith(
                                        color: theme
                                            .colorScheme.secondaryContainer,
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Container(
                                height: 20.v,
                                child: GFProgressBar(
                                  percentage: tempPercentageClamped,
                                  lineHeight: 25,
                                  backgroundColor: appTheme.blueGray100,
                                  progressBarColor: barColor,
                                  animation: true,
                                  animationDuration: 1000,
                                  radius: 20,
                                  child: Center(
                                    child: Text(
                                      tempPercentageDisplay,
                                      style: CustomTextStyles
                                          .googleSansPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.v),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.v),
            Padding(
              padding: EdgeInsets.only(right: 4.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Heater",
                      style: CustomTextStyles.bodySmallPrimaryContainer_1
                          .copyWith(fontSize: 11.0), // Adjust font size here
                    ),
                    SizedBox(height: 3.v),
                    Container(
                      height: 20, // Adjust the height as needed
                      width: 60, // Adjust the width as needed
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // Rounded corners
                        color: _heaterState ? Colors.blue : Colors.grey,
                        // Use different colors for on and off states
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _heaterState ? 'On' : 'Off', // Display On or Off text
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Text(
                      "Cooler",
                      style: CustomTextStyles.bodySmallPrimaryContainer_1
                          .copyWith(fontSize: 11.0), // Adjust font size here
                    ),
                    SizedBox(height: 3.v),
                    Container(
                      height: 20, // Adjust the height as needed
                      width: 60, // Adjust the width as needed
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // Rounded corners
                        color: _coolerState ? Colors.blue : Colors.grey,
                        // Use different colors for on and off states
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _coolerState ? 'On' : 'Off', // Display On or Off text
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildRowWithTDSAndTurbidity(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildTDS(context)),
          Expanded(child: _buildTurbidity(context)),
        ],
      ),
    );
  }

  Widget _buildPH(BuildContext context) {
    double phPercentage = sensorData['phPercentage'] != null
        ? double.tryParse(sensorData['phPercentage'])! / 100
        : 0.0;

    // Display the correct percentage, even if it exceeds 100%
    String phPercentageDisplay = (phPercentage * 100).toStringAsFixed(0) + "%";

    // Clamp the percentage for the GFProgressBar display
    double phPercentageClamped = phPercentage.clamp(0.0, 1.0);

    // Determine progress bar color based on the percentage
    Color barColor;
    if (phPercentageClamped > 0.5714 || phPercentageClamped < 0.4643) {
      barColor = Colors.red;
    } else {
      barColor = Colors.green;
    }
    return Container(
      margin: EdgeInsets.only(right: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
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
            height: 37.v,
            width: 147.h,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 37.v,
                    width: 147.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.h),
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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "${sensorData['ph'] ?? 'N/A'}",
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
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
                          child: SizedBox(
                            width: 223.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Good",
                                  style: CustomTextStyles.googleSansGreenA700
                                      .copyWith(
                                    color: appTheme.greenA700,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 20.v,
                            child: GFProgressBar(
                              percentage: phPercentageClamped,
                              lineHeight: 25,
                              backgroundColor: appTheme.blueGray100,
                              progressBarColor: barColor,
                              animation: true,
                              animationDuration: 1000,
                              radius: 20,
                              // Use double for radius
                              child: Center(
                                child: Text(
                                  phPercentageDisplay,
                                  style: CustomTextStyles
                                      .googleSansPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.v),
                      ],
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

  Widget _buildAmmonia(BuildContext context) {
    double ammoniaPercentage = sensorData['AmoniaPercentage'] != null
        ? double.tryParse(sensorData['AmoniaPercentage'])! / 100.0
        : 0.0;

    // Display the correct percentage, even if it exceeds 100%
    String ammoniaPercentageDisplay =
        (ammoniaPercentage * 100).toStringAsFixed(0) + "%";

    // Clamp the percentage for the GFProgressBar display
    double ammoniaPercentageClamped = ammoniaPercentage.clamp(0.0, 1.0);

    // Determine progress bar color based on the percentage
    Color barColor;
    if (ammoniaPercentageClamped > 0.2 || ammoniaPercentageClamped < 0) {
      barColor = Colors.red;
    } else {
      barColor = Colors.green;
    }
    return Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
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
            height: 37.v,
            width: 147.h,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 37.v,
                    width: 147.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.h),
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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "${sensorData['Amonia'] ?? 'N/A'}",
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
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
                          child: SizedBox(
                            width: 223.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(
                                  "Good",
                                  style: CustomTextStyles.googleSansGreenA700
                                      .copyWith(
                                    color: appTheme.greenA700,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 20.v,
                            child: GFProgressBar(
                              percentage: ammoniaPercentageClamped,
                              lineHeight: 25,
                              backgroundColor: appTheme.blueGray100,
                              progressBarColor: barColor,
                              animation: true,
                              animationDuration: 1000,
                              radius: 20,
                              // Use double for radius
                              child: Center(
                                child: Text(
                                  ammoniaPercentageDisplay,
                                  style: CustomTextStyles
                                      .googleSansPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.v),
                      ],
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

  Widget _buildTDS(BuildContext context) {
    double tdsPercentage = sensorData['TdsPercentage'] != null
        ? double.tryParse(sensorData['TdsPercentage'])! / 100.0
        : 0.0;

    // Convert tdsPercentage to display as percentage
    String tdsPercentageDisplay =
        (tdsPercentage * 100).toStringAsFixed(0) + "%";

    // Clamp the percentage for the GFProgressBar display
    double tdsPercentageClamped = tdsPercentage.clamp(0.0, 1.0);

    // Determine progress bar color based on the percentage
    Color barColor;
    if (tdsPercentageClamped > 0.8333 || tdsPercentageClamped < 0.1667) {
      barColor = Colors.red;
    } else {
      barColor = Colors.green;
    }
    return Container(
      margin: EdgeInsets.only(right: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
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
          Container(
            height: 37.v,
            width: 147.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 37.v,
                    width: 147.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.h),
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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "${sensorData['Tds'] ?? 'N/A'} PPM",
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
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
                          child: SizedBox(
                            width: 223.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Good",
                                  style: CustomTextStyles.googleSansGreenA700
                                      .copyWith(
                                    color: appTheme.greenA700,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 20.v,
                            child: GFProgressBar(
                              percentage: tdsPercentageClamped,
                              lineHeight: 25,
                              backgroundColor: appTheme.blueGray100,
                              progressBarColor: barColor,
                              animation: true,
                              animationDuration: 1000,
                              radius: 20,
                              // Use double for radius
                              child: Center(
                                child: Text(
                                  tdsPercentageDisplay,
                                  style: CustomTextStyles
                                      .googleSansPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.v),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.v),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "WaterPump",
                style: CustomTextStyles.bodySmallPrimaryContainer_1
                    .copyWith(fontSize: 11.0),
              ),
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            height: 20, // Adjust the height as needed
            width: 60, // Adjust the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Rounded corners
              color: _waterpState ? Colors.blue : Colors.grey,
              // Use different colors for on and off states
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                _waterpState ? 'ON' : 'OFF', // Display On or Off text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTurbidity(BuildContext context) {
    double turbidityPercentage = sensorData['turbidityPercentage'] != null
        ? double.tryParse(sensorData['turbidityPercentage'])! / 100.0
        : 0.0;

    // Convert turbidityPercentage to display as percentage
    String turbidityPercentageDisplay =
        (turbidityPercentage * 100).toStringAsFixed(0) + "%";

    // Clamp the percentage for the GFProgressBar display
    double turbidityPercentageClamped = turbidityPercentage.clamp(0.0, 1.0);

    // Determine progress bar color based on the percentage
    Color barColor;
    if (turbidityPercentageClamped > 0.925 ||
        turbidityPercentageClamped < 0.125) {
      barColor = Colors.red;
    } else {
      barColor = Colors.green;
    }

    return Container(
      margin: EdgeInsets.only(left: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
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
                    imagePath: ImageConstant.imgBrightness,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    margin: EdgeInsets.only(bottom: 3.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.h),
                    child: Text(
                      "Turbidity",
                      style: CustomTextStyles.bodySmallPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.v),
          SizedBox(
            height: 37.v,
            width: 147.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 37.v,
                    width: 147.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.h),
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
                  alignment: Alignment.center,
                  child: Text(
                    "${sensorData['turbidity'] ?? 'N/A'} NTU",
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.v),
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
                          child: SizedBox(
                            width: 223.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Good",
                                  style: CustomTextStyles.googleSansGreenA700
                                      .copyWith(
                                    color: appTheme.greenA700,
                                    fontSize: 11.0, // Adjust the font size here
                                  ),
                                ),
                                Text(
                                  "Bad",
                                  style: CustomTextStyles
                                      .googleSansSecondaryContainer
                                      .copyWith(
                                    color: theme.colorScheme.secondaryContainer,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 20.v,
                            child: GFProgressBar(
                              percentage: turbidityPercentageClamped,
                              lineHeight: 25,
                              backgroundColor: appTheme.blueGray100,
                              progressBarColor: barColor,
                              // Set color based on percentage
                              animation: true,
                              animationDuration: 1000,
                              radius: 20,
                              // Use double for radius
                              child: Center(
                                child: Text(
                                  turbidityPercentageDisplay,
                                  style: CustomTextStyles
                                      .googleSansPrimaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.v),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.v),
          Padding(
            padding: EdgeInsets.only(right: 4.h),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "WaterPump",
                style: CustomTextStyles.bodySmallPrimaryContainer_1
                    .copyWith(fontSize: 11.0),
              ),
            ),
          ),
          SizedBox(height: 3.v),
          Container(
            height: 20, // Adjust the height as needed
            width: 60, // Adjust the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // Rounded corners
              color: _waterpState ? Colors.blue : Colors.grey,
              // Use different colors for on and off states
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                _waterpState ? 'ON' : 'OFF', // Display On or Off text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppDecoration.fillBlueA.color,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFFDFEAF5),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildParameterRangeInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 15.v,
        ),
        decoration: AppDecoration.fillOnSecondaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parameter Range Information",
              style: CustomTextStyles.bodySmallPrimaryContainer.copyWith(
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.v),
            _buildParameterInfoRow("Temperature:", "20°C - 28°C"),
            _buildParameterInfoRow("TDS:", "100 - 500 ppm"),
            _buildParameterInfoRow("pH:", "6.5 - 8.0"),
            _buildParameterInfoRow("Ammonia:", "No more than 0.2 mg/L"),
            _buildParameterInfoRow("Turbidity:", "5 - 37 NTU"),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterInfoRow(String parameter, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            parameter,
            style: CustomTextStyles.bodySmallPrimaryContainer.copyWith(
              fontSize: 12.h,
            ),
          ),
          Text(
            value,
            style: CustomTextStyles.bodySmallPrimaryContainer.copyWith(
              fontSize: 12.h,
            ),
          ),
        ],
      ),
    );
  }
}
