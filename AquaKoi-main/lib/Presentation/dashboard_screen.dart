import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:koiaqua/Presentation/profil_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/app_bar/appbar_title_searchview.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';

class ToggleButton extends StatefulWidget {
  final bool initialState;
  final Function(bool) onToggle;

  const ToggleButton({super.key, required this.initialState, required this.onToggle});

  @override
  // ignore: library_private_types_in_public_api
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
        width: 50,
        height: 25,
        decoration: isOn
            ? AppDecoration.gradientLightBlueToBlueA
            : AppDecoration.gradientGrayToBlueGray,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isOn ? 25 : 0,
              right: isOn ? 0 : 25,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isOn ? Colors.blue : Colors.grey,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  isOn ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: isOn ? Colors.blue[700] : Colors.grey[900],
                    fontSize: 8,
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

class DashboardScreen extends StatefulWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('UsersData').child('cSFGHidGb4gzLBalujMaowdFDGG2').child('Sensors');
  Map<String, dynamic> sensorData = {};

  @override
  void initState() {
  super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      _databaseReference.onValue.listen((event) {
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
    } else {
      // Redirect to login if not authenticated
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onError,
        appBar: _buildAppBar(context),
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 17.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppbarTitleSearchview(
                  hintText: "Find Parameter",
                  controller: widget.searchController,
                ),
              ],
            ),
          ),
          SizedBox(height: 1),
          Divider(),
          SizedBox(height: 1),
        ],
      ),
      styleType: Style.bgFill,
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
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.h),
                      child: Text(
                        "${sensorData['Suhu']+' C' ?? 'youre not authenticated'}", // Ubah teks untuk menampilkan nilai suhu
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
                              padding: EdgeInsets.only(left: 8.h),
                              child: _buildFortyEight(
                                context,
                                bad: "bad",
                                good: "good",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              child: Container(
                                height: 15.v,
                                child: LinearPercentIndicator(
                                  width: 330,
                                  lineHeight: 30,
                                  backgroundColor: appTheme.blueGray100,
                                  progressColor: appTheme.Red1,
                                  percent: 0.25, // Persentase bisa diubah sesuai data aktual
                                  center: Text(
                                    "25%",
                                    style: CustomTextStyles.googleSansPrimaryContainer,
                                  ),
                                  animation: true,
                                  animationDuration: 1000,
                                  barRadius: Radius.circular(20),
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
                      style: CustomTextStyles.bodySmallPrimaryContainer_1,
                    ),
                    SizedBox(height: 3.v),
                    ToggleButton(
                      initialState: true, // Kontrol ini bisa diatur berdasarkan data aktual
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
                      initialState: false, // Kontrol ini bisa diatur berdasarkan data aktual
                      onToggle: (bool value) {
                        print("Cooler is now: $value");
                      },
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
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.h),
                    child: Text(
                      "${sensorData['ph'] ?? 'youre not authenticated'}",
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
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 15.v,
                            child: LinearPercentIndicator(
                              width: 177,
                              lineHeight: 30,
                              backgroundColor: appTheme.blueGray100,
                              progressColor: appTheme.greenA700,
                              percent: 0.7,
                              center: Text(
                                "70%",
                                style: CustomTextStyles.googleSansPrimaryContainer,
                              ),
                              animation: true,
                              animationDuration: 1000,
                              barRadius: Radius.circular(20),
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
                      "${sensorData['Amonia']+'PPM' ?? 'youre not authenticated'}",
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
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 15.v,
                            child: LinearPercentIndicator(
                              width: 177,
                              lineHeight: 30,
                              backgroundColor: appTheme.blueGray100,
                              progressColor: appTheme.Red1,
                              percent: 0.25,
                              center: Text(
                                "25%",
                                style: CustomTextStyles.googleSansPrimaryContainer,
                              ),
                              animation: true,
                              animationDuration: 1000,
                              barRadius: Radius.circular(20),
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
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 22.h),
                    child: Text(
                      "${sensorData['Tds']+'PPM' ?? 'youre not authenticated'}",
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
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 15.v,
                            child: LinearPercentIndicator(
                              width: 177,
                              lineHeight: 30,
                              backgroundColor: appTheme.blueGray100,
                              progressColor: appTheme.greenA700,
                              percent: 0.75,
                              center: Text(
                                "75%",
                                style: CustomTextStyles.googleSansPrimaryContainer,
                              ),
                              animation: true,
                              animationDuration: 1000,
                              barRadius: Radius.circular(20),
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
    );
  }

  Widget _buildTurbidity(BuildContext context) {
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
                    "${sensorData['turbidity']+'NTU' ?? 'youre not authenticated'}",
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
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                          child: Container(
                            height: 15.v,
                            child: LinearPercentIndicator(
                              width: 177,
                              lineHeight: 30,
                              backgroundColor: appTheme.blueGray100,
                              progressColor: appTheme.amber700,
                              percent: 0.50,
                              center: Text(
                                "50%",
                                style: CustomTextStyles.googleSansPrimaryContainer,
                              ),
                              animation: true,
                              animationDuration: 1000,
                              barRadius: Radius.circular(20),
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
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
        selectedItemColor: Colors.blue,
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
