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
        // monitoringcontrollingmhy (81:853)
        width: double.infinity,
        height: 640*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Container(
          // iphone141Ezs (81:1997)
          width: 390*fem,
          height: 844*fem,
          decoration: BoxDecoration (
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // autogroupftqbL2K (LUqNz1aM6mok961XVCftqB)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 21*fem),
                width: double.infinity,
                height: 303*fem,
                child: Stack(
                  children: [
                    Positioned(
                      // rectangle2qUs (81:1998)
                      left: 0*fem,
                      top: 0*fem,
                      child: Align(
                        child: SizedBox(
                          width: 390*fem,
                          height: 227*fem,
                          child: Image.asset(
                            'assets/page-1/images/rectangle-2.png',
                            width: 390*fem,
                            height: 227*fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // bcT (81:2077)
                      left: 10*fem,
                      top: 9*fem,
                      child: Align(
                        child: SizedBox(
                          width: 31*fem,
                          height: 15*fem,
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
                      ),
                    ),
                    Positioned(
                      // icons3zF (81:2078)
                      left: 298*fem,
                      top: 8*fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0*fem, 1*fem, 4.33*fem, 1.67*fem),
                        width: 56*fem,
                        height: 16*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // wifi91h (81:2079)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                              width: 16*fem,
                              height: 11.33*fem,
                              child: Image.asset(
                                'assets/page-1/images/wi-fi.png',
                                width: 16*fem,
                                height: 11.33*fem,
                              ),
                            ),
                            Container(
                              // receptioneUF (81:2081)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10.67*fem, 0*fem),
                              width: 13.33*fem,
                              height: 13.33*fem,
                              child: Image.asset(
                                'assets/page-1/images/reception.png',
                                width: 13.33*fem,
                                height: 13.33*fem,
                              ),
                            ),
                            Container(
                              // batterywy9 (81:2083)
                              width: 6.67*fem,
                              height: 13.33*fem,
                              child: Image.asset(
                                'assets/page-1/images/battery-VFd.png',
                                width: 6.67*fem,
                                height: 13.33*fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // group2H1R (81:1767)
                      left: 110.2047119141*fem,
                      top: 158.4947509766*fem,
                      child: Container(
                        width: 138.86*fem,
                        height: 142.51*fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // ellipse2bXu (81:1768)
                              left: 2.6875*fem,
                              top: 1.8387756348*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 134.38*fem,
                                  height: 137.91*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/ellipse-2.png',
                                    width: 134.38*fem,
                                    height: 137.91*fem,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse3VtB (81:1769)
                              left: 0*fem,
                              top: 0*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 138.86*fem,
                                  height: 142.51*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/ellipse-3.png',
                                    width: 138.86*fem,
                                    height: 142.51*fem,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // solarcameraminimalisticboldcxo (81:1770)
                              left: 105.8150634766*fem,
                              top: 117.4222717285*fem,
                              child: Align(
                                child: SizedBox(
                                  width: 21.59*fem,
                                  height: 19.44*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/solar-camera-minimalistic-bold-Tmq.png',
                                    width: 21.59*fem,
                                    height: 19.44*fem,
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
              Container(
                // pembudidayaikanrMM (81:1999)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10*fem, 7*fem),
                child: Text(
                  'Pembudidaya Ikan',
                  style: SafeGoogleFont (
                    'Google Sans',
                    fontSize: 18*ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.2575*ffem/fem,
                    color: Color(0xff24265f),
                  ),
                ),
              ),
              Container(
                // examplegmailcomjg3 (81:2000)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 0*fem),
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
              Container(
                // autogrouptdghSaT (LUqPQahjp9J8AssGpiTdgH)
                padding: EdgeInsets.fromLTRB(0*fem, 3*fem, 0*fem, 0*fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // group36721Z9H (81:2053)
                      margin: EdgeInsets.fromLTRB(115*fem, 0*fem, 128*fem, 8*fem),
                      padding: EdgeInsets.fromLTRB(4.5*fem, 2.25*fem, 0*fem, 2.25*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // materialsymbolslocationon4Lw (81:2002)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7.5*fem, 0*fem),
                            width: 18*fem,
                            height: 22.5*fem,
                            child: Image.asset(
                              'assets/page-1/images/material-symbols-location-on.png',
                              width: 18*fem,
                              height: 22.5*fem,
                            ),
                          ),
                          Container(
                            // lembangjawabaratMaw (81:2004)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                            child: Text(
                              'Lembang, Jawa Barat',
                              style: SafeGoogleFont (
                                'Google Sans',
                                fontSize: 13*ffem,
                                fontWeight: FontWeight.w500,
                                height: 0.8752273413*ffem/fem,
                                color: Color(0xff534c4c),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group8T8B (81:2054)
                      margin: EdgeInsets.fromLTRB(133*fem, 0*fem, 133*fem, 147*fem),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom (
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 35*fem,
                          decoration: BoxDecoration (
                            color: Color(0xff3873f9),
                            borderRadius: BorderRadius.circular(11*fem),
                          ),
                          child: Center(
                            child: Text(
                              'Edit profile',
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
                    Container(
                      // group36712rw1 (81:964)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 114*fem),
                      width: 360*fem,
                      height: 51*fem,
                      child: Image.asset(
                        'assets/page-1/images/group-36712.png',
                        width: 360*fem,
                        height: 51*fem,
                      ),
                    ),
                    Container(
                      // group20a6K (81:2006)
                      width: 390*fem,
                      height: 88*fem,
                      child: Image.asset(
                        'assets/page-1/images/group-20.png',
                        width: 390*fem,
                        height: 88*fem,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
          );
  }
}