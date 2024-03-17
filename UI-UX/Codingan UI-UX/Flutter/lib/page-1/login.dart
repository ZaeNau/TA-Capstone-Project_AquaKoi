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
        // loginmXu (15:10)
        padding: EdgeInsets.fromLTRB(70*fem, 109*fem, 70*fem, 110*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffdee9f4),
          borderRadius: BorderRadius.circular(27*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // loginsqq (25:19)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 62*fem),
              child: Text(
                'Log in',
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
              // group36694Mm1 (28:310)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 37*fem),
              width: double.infinity,
              height: 179*fem,
              child: Stack(
                children: [
                  Positioned(
                    // inputtF9 (28:122)
                    left: 0*fem,
                    top: 0*fem,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 44*fem),
                      width: 220*fem,
                      height: 103*fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // emailaddressnrK (28:123)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                            child: Text(
                              'Email address',
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
                            // inputfieldWXR (28:124)
                            padding: EdgeInsets.fromLTRB(16*fem, 9*fem, 7*fem, 10*fem),
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
                                  // ikankoikugmailcomq3u (28:125)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 52*fem, 0*fem),
                                  child: Text(
                                    'ikankoiku@gmail.com',
                                    style: SafeGoogleFont (
                                      'Inter',
                                      fontSize: 13*ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.25*ffem/fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                Container(
                                  // iconwsd (28:126)
                                  margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 0*fem),
                                  width: 12*fem,
                                  height: 12*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/icon-fou.png',
                                    width: 12*fem,
                                    height: 12*fem,
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
                    // group36693Tqy (28:309)
                    left: 0*fem,
                    top: 76*fem,
                    child: Container(
                      width: 220*fem,
                      height: 103*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // forgotpasswordBmy (28:49)
                            left: 155*fem,
                            top: 67*fem,
                            child: Align(
                              child: SizedBox(
                                width: 59*fem,
                                height: 10*fem,
                                child: Text(
                                  'Forgot password?',
                                  style: SafeGoogleFont (
                                    'Google Sans',
                                    fontSize: 8*ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.25*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // inputH4K (28:147)
                            left: 0*fem,
                            top: 0*fem,
                            child: Container(
                              width: 220*fem,
                              height: 103*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // group36692DCs (28:188)
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(10*fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // passwordwuZ (28:148)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6*fem),
                                          child: Text(
                                            'Password',
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
                                          // inputfieldrFq (28:149)
                                          padding: EdgeInsets.fromLTRB(16*fem, 13.2*fem, 7.2*fem, 13.8*fem),
                                          width: double.infinity,
                                          height: 36*fem,
                                          decoration: BoxDecoration (
                                            border: Border.all(color: Color(0xffd8dadc)),
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(10*fem),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // group36691xJs (28:170)
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.8*fem, 110.6*fem, 1.2*fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // ellipse186sAw (28:171)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse187bMq (28:172)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse188jD9 (28:173)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse189Tew (28:174)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse190PoV (28:175)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse191LCw (28:176)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse192GsH (28:177)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4*fem,
                                                    ),
                                                    Container(
                                                      // ellipse193o6X (28:178)
                                                      width: 6*fem,
                                                      height: 6*fem,
                                                      decoration: BoxDecoration (
                                                        borderRadius: BorderRadius.circular(3*fem),
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // iconjks (28:169)
                                                width: 10.2*fem,
                                                height: 9*fem,
                                                child: Image.asset(
                                                  'assets/page-1/images/icon-adu.png',
                                                  width: 10.2*fem,
                                                  height: 9*fem,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // autogroupxdgrfuR (LUqSMq7jFcBe3hN4sQxDGR)
                                    padding: EdgeInsets.fromLTRB(3*fem, 7*fem, 3*fem, 7*fem),
                                    width: double.infinity,
                                    height: 44*fem,
                                    child: Container(
                                      // autogrouphsimpGX (LUqSFv7v72WAvPFQKnHsiM)
                                      width: 69*fem,
                                      height: 11*fem,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // rectangle12kR5 (28:235)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                                            width: 11*fem,
                                            height: 11*fem,
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(1*fem),
                                              color: Color(0xffc6c6c5),
                                            ),
                                          ),
                                          Text(
                                            // remembermeUby (28:236)
                                            'Remember me',
                                            style: SafeGoogleFont (
                                              'Google Sans',
                                              fontSize: 8*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575*ffem/fem,
                                              color: Color(0xff000000),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // buttonprimary1ro (28:54)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 62*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  width: double.infinity,
                  height: 36*fem,
                  decoration: BoxDecoration (
                    border: Border.all(color: Color(0x3f000000)),
                    color: Color(0xff3873f9),
                    borderRadius: BorderRadius.circular(10*fem),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        'Log in',
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
              // donthaveanaccountsignuprsR (28:50)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15*fem, 0*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: RichText(
                  text: TextSpan(
                    style: SafeGoogleFont (
                      'Inter',
                      fontSize: 13*ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.25*ffem/fem,
                      color: Color(0xff000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: SafeGoogleFont (
                          'Google Sans',
                          fontSize: 13*ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.25*ffem/fem,
                          color: Color(0xff000000),
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up',
                        style: SafeGoogleFont (
                          'Google Sans',
                          fontSize: 13*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.25*ffem/fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
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