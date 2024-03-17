import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // monitoringcontrollingWST (81:2085)
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // autogroupimrfRJX (LUqQqNf7tGpfwFUaTZiMRF)
              padding: EdgeInsets.fromLTRB(8*fem, 10*fem, 8*fem, 22.57*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // group36722ja7 (81:2154)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 9*fem),
                    width: double.infinity,
                    height: 16*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // ewy (81:2146)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 257*fem, 0*fem),
                          child: Text(
                            '11:07',
                            style: SafeGoogleFont (
                              'Roboto',
                              fontSize: 12*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.1725*ffem/fem,
                              color: Color(0xff333333),
                            ),
                          ),
                        ),
                        Container(
                          // iconsAfR (81:2147)
                          padding: EdgeInsets.fromLTRB(0*fem, 1*fem, 4.33*fem, 1.67*fem),
                          height: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // wifi6oy (81:2148)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                                width: 16*fem,
                                height: 11.33*fem,
                                child: Image.asset(
                                  'assets/page-1/images/wi-fi-6uD.png',
                                  width: 16*fem,
                                  height: 11.33*fem,
                                ),
                              ),
                              Container(
                                // receptionDtb (81:2150)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10.67*fem, 0*fem),
                                width: 13.33*fem,
                                height: 13.33*fem,
                                child: Image.asset(
                                  'assets/page-1/images/reception-LvB.png',
                                  width: 13.33*fem,
                                  height: 13.33*fem,
                                ),
                              ),
                              Container(
                                // batteryYAB (81:2152)
                                width: 6.67*fem,
                                height: 13.33*fem,
                                child: Image.asset(
                                  'assets/page-1/images/battery.png',
                                  width: 6.67*fem,
                                  height: 13.33*fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // editprofilergf (81:2145)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 9*fem, 24*fem),
                    child: Text(
                      'Edit Profile',
                      style: SafeGoogleFont (
                        'Google Sans',
                        fontSize: 20*ffem,
                        fontWeight: FontWeight.w700,
                        height: 0.875227356*ffem/fem,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    // group2MtK (81:2140)
                    margin: EdgeInsets.fromLTRB(129*fem, 0*fem, 127.86*fem, 0*fem),
                    width: double.infinity,
                    height: 89.43*fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // ellipse2tdM (81:2141)
                          left: 1.6865234375*fem,
                          top: 1.1539306641*fem,
                          child: Align(
                            child: SizedBox(
                              width: 84.33*fem,
                              height: 86.54*fem,
                              child: Image.asset(
                                'assets/page-1/images/ellipse-2-yMq.png',
                                width: 84.33*fem,
                                height: 86.54*fem,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // ellipse3CP9 (81:2142)
                          left: 0*fem,
                          top: 0*fem,
                          child: Align(
                            child: SizedBox(
                              width: 87.14*fem,
                              height: 89.43*fem,
                              child: Image.asset(
                                'assets/page-1/images/ellipse-3-UYw.png',
                                width: 87.14*fem,
                                height: 89.43*fem,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // solarcameraminimalisticbolduoM (81:2143)
                          left: 66.4046630859*fem,
                          top: 73.6887359619*fem,
                          child: Align(
                            child: SizedBox(
                              width: 13.55*fem,
                              height: 12.2*fem,
                              child: Image.asset(
                                'assets/page-1/images/solar-camera-minimalistic-bold.png',
                                width: 13.55*fem,
                                height: 12.2*fem,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // autogroupgqqyQEK (LUqQ3yo6EBXdaFJGL2GqQy)
              width: 407*fem,
              height: 451*fem,
              child: Stack(
                children: [
                  Positioned(
                    // group366959hh (81:2155)
                    left: 70*fem,
                    top: 0*fem,
                    child: Container(
                      width: 337*fem,
                      height: 399*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // inputH3D (81:2156)
                            left: 0*fem,
                            top: 148*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
                              width: 337*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // emailbJo (81:2157)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                    child: Text(
                                      'Email',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldJU7 (81:2158)
                                    padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 16*fem, 12*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xffd8dadc)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Text(
                                      'example@gmail.com',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0x7f000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // inputmMh (81:2162)
                            left: 0*fem,
                            top: 0*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
                              width: 337*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // nameGZM (81:2163)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                    child: Text(
                                      'Name',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldaa3 (81:2164)
                                    padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 16*fem, 12*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xffd8dadc)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Text(
                                      'Pembudidaya Ikan',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0x7f000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // inputGBy (81:2188)
                            left: 0*fem,
                            top: 74*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
                              width: 337*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // locationaTZ (81:2189)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                    child: Text(
                                      'Location',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldtj9 (81:2190)
                                    padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 16*fem, 12*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xffd8dadc)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Text(
                                      'Lembang, Jawa Barat',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0x7f000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // inputBTM (81:2168)
                            left: 0*fem,
                            top: 222*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 44*fem),
                              width: 220*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // changepassword5Yj (81:2169)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                    child: Text(
                                      'Change password',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0xff333333),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldAq5 (81:2170)
                                    padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 17.2*fem, 10*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xffd8dadc)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // mustbe8characterssjV (81:2171)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 45.6*fem, 0*fem),
                                          child: Text(
                                            'must be 8 characters',
                                            style: SafeGoogleFont (
                                              'Inter',
                                              fontSize: 13*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.25*ffem/fem,
                                              color: Color(0x7f000000),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // iconyGj (81:2172)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0.4*fem, 0*fem, 0*fem),
                                          width: 10.2*fem,
                                          height: 7.8*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/icon.png',
                                            width: 10.2*fem,
                                            height: 7.8*fem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // inputHHR (81:2174)
                            left: 0*fem,
                            top: 296*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 44*fem),
                              width: 220*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // confirmpasswordzxX (81:2175)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                    child: Text(
                                      'Confirm password',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 13*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.25*ffem/fem,
                                        color: Color(0xff534c4c),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // inputfieldvbH (81:2176)
                                    padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 17.2*fem, 10*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      border: Border.all(color: Color(0xffd8dadc)),
                                      color: Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // repeatpasswordeXH (81:2177)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 72.6*fem, 0*fem),
                                          child: Text(
                                            'repeat password',
                                            style: SafeGoogleFont (
                                              'Inter',
                                              fontSize: 13*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.25*ffem/fem,
                                              color: Color(0x7f000000),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // iconkaK (81:2178)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0.4*fem, 0*fem, 0*fem),
                                          width: 10.2*fem,
                                          height: 7.8*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/icon-Q6K.png',
                                            width: 10.2*fem,
                                            height: 7.8*fem,
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
                    ),
                  ),
                  Positioned(
                    // group8de7 (81:2200)
                    left: 118*fem,
                    top: 379*fem,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom (
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        width: 124*fem,
                        height: 35*fem,
                        decoration: BoxDecoration (
                          color: Color(0xff3873f9),
                          borderRadius: BorderRadius.circular(11*fem),
                        ),
                        child: Center(
                          child: Text(
                            'Save edit',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Google Sans',
                              fontSize: 15*ffem,
                              fontWeight: FontWeight.w700,
                              height: 0.875227356*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // group36712Gh5 (81:2121)
                    left: 0*fem,
                    top: 400*fem,
                    child: Align(
                      child: SizedBox(
                        width: 360*fem,
                        height: 51*fem,
                        child: Image.asset(
                          'assets/page-1/images/group-36712-ayd.png',
                          width: 360*fem,
                          height: 51*fem,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          );
  }
}