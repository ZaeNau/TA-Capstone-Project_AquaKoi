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
        // registercB1 (28:200)
        padding: EdgeInsets.fromLTRB(70*fem, 42*fem, 0*fem, 43*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffdee9f4),
          borderRadius: BorderRadius.circular(27*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // signupKLK (28:203)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70*fem, 62*fem),
              child: Text(
                'Sign up',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Google Sans',
                  fontSize: 22*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2575*ffem/fem,
                  color: Color(0xff000000),
                ),
              ),
            ),
            Container(
              // group36695d67 (28:313)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19*fem),
              width: 337*fem,
              height: 331*fem,
              child: Stack(
                children: [
                  Positioned(
                    // inputx8P (28:298)
                    left: 0*fem,
                    top: 76*fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 42*fem),
                      width: 337*fem,
                      height: 103*fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // emailU6j (28:299)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                            child: Text(
                              'Email',
                              style: SafeGoogleFont (
                                'Google Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.25*ffem/fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // inputfieldbBM (28:300)
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
                    // inputsuZ (76:100)
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
                            // nameBfM (76:101)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                            child: Text(
                              'Name',
                              style: SafeGoogleFont (
                                'Google Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.25*ffem/fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // inputfieldVvw (76:102)
                            padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 16*fem, 12*fem),
                            width: double.infinity,
                            decoration: BoxDecoration (
                              border: Border.all(color: Color(0xffd8dadc)),
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10*fem),
                            ),
                            child: Text(
                              'nailiik@gmail.com',
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
                    // inputPWX (28:284)
                    left: 0*fem,
                    top: 152*fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 44*fem),
                      width: 220*fem,
                      height: 103*fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // createapasswordVJf (28:285)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                            child: Text(
                              'Create a password',
                              style: SafeGoogleFont (
                                'Google Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.25*ffem/fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // inputfieldPew (28:286)
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
                                  // mustbe8charactershQj (28:287)
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
                                  // iconajR (28:288)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0.4*fem, 0*fem, 0*fem),
                                  width: 10.2*fem,
                                  height: 7.8*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/icon-MyZ.png',
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
                    // inputHtj (28:274)
                    left: 0*fem,
                    top: 228*fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 44*fem),
                      width: 220*fem,
                      height: 103*fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // confirmpasswordoMH (28:275)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                            child: Text(
                              'Confirm password',
                              style: SafeGoogleFont (
                                'Google Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.25*ffem/fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Container(
                            // inputfieldKqR (28:276)
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
                                  // repeatpassword42K (28:277)
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
                                  // iconaFZ (28:278)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0.4*fem, 0*fem, 0*fem),
                                  width: 10.2*fem,
                                  height: 7.8*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/icon-neB.png',
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
            Container(
              // buttonprimarytX9 (28:311)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 70*fem, 62*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: 220*fem,
                  height: 36*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0x3f000000)),
                    color: Color(0xff3873f9),
                    borderRadius: BorderRadius.circular(10*fem),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Sign up',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Google Sans',
                          fontSize: 16*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.25*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // alreadyhaveanaccountloginXKD (28:227)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 87*fem, 0*fem),
              child: RichText(
                text: TextSpan(
                  style: SafeGoogleFont (
                    'Inter',
                    fontSize: 13*ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.25*ffem/fem,
                    color: Color(0xffffffff),
                  ),
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: SafeGoogleFont (
                        'Google Sans',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.25*ffem/fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                    TextSpan(
                      text: 'Log in',
                      style: SafeGoogleFont (
                        'Google Sans',
                        fontSize: 13*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25*ffem/fem,
                        color: Color(0xffffffff),
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
}