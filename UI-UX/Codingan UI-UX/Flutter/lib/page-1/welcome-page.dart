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
        // welcomepageZ4B (15:7)
        padding: EdgeInsets.fromLTRB(74*fem, 286*fem, 74*fem, 75*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(27*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // group36723sKm (91:32)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 197*fem),
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom (
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 0*fem),
                  width: double.infinity,
                  height: 68*fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // aquakoi1wqR (91:31)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                        width: 60*fem,
                        height: 60*fem,
                        child: Image.asset(
                          'assets/page-1/images/aquakoi-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        // group2G71 (25:14)
                        width: 138*fem,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              // welcomeosd (25:2)
                              left: 6.5*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 112*fem,
                                  height: 36*fem,
                                  child: Text(
                                    'Welcome',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Google Sans',
                                      fontSize: 28*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2575*ffem/fem,
                                      color: Color(0xff3873f9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // group1hTD (25:8)
                              left: 0*fem,
                              top: 32*fem,
                              child: Container(
                                width: 138*fem,
                                height: 36*fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // tod5y (25:3)
                                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6*fem, 0*fem),
                                      child: Text(
                                        'To',
                                        style: SafeGoogleFont (
                                          'Google Sans',
                                          fontSize: 28*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2575*ffem/fem,
                                          color: Color(0xff3873f9),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // aquakoikRV (25:4)
                                      'AquaKoi',
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 28*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              // foryourbetterkoipondcompanionJ (25:12)
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 1*fem, 0*fem),
              child: Text(
                'For your better Koi pond companion.',
                textAlign: TextAlign.center,
                style: SafeGoogleFont (
                  'Google Sans',
                  fontSize: 11*ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2575*ffem/fem,
                  color: Color(0xff3873f9),
                ),
              ),
            ),
          ],
        ),
      ),
          );
  }
}