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
        // monitoringcontrollingvej (81:566)
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffdee9f4),
          borderRadius: BorderRadius.circular(20*fem),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // statusbareqd (81:569)
              padding: EdgeInsets.fromLTRB(8*fem, 8*fem, 8*fem, 8*fem),
              width: double.infinity,
              height: 32*fem,
              decoration: BoxDecoration (
                color: Color(0xffdee9f4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // mvF (81:570)
                    margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 257*fem, 0*fem),
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
                    // iconstjy (81:571)
                    padding: EdgeInsets.fromLTRB(0*fem, 1*fem, 4.33*fem, 1.67*fem),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // wifidBm (81:572)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                          width: 16*fem,
                          height: 11.33*fem,
                          child: Image.asset(
                            'assets/page-1/images/wi-fi-JsR.png',
                            width: 16*fem,
                            height: 11.33*fem,
                          ),
                        ),
                        Container(
                          // receptionkGP (81:574)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 10.67*fem, 0*fem),
                          width: 13.33*fem,
                          height: 13.33*fem,
                          child: Image.asset(
                            'assets/page-1/images/reception-cVD.png',
                            width: 13.33*fem,
                            height: 13.33*fem,
                          ),
                        ),
                        Container(
                          // batteryTAo (81:576)
                          width: 6.67*fem,
                          height: 13.33*fem,
                          child: Image.asset(
                            'assets/page-1/images/battery-7wM.png',
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
              // autogroup5qvdPKM (LUqXVmPdK2pTNTdc4i5qvd)
              padding: EdgeInsets.fromLTRB(0*fem, 2*fem, 0*fem, 0*fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // group36711JSK (81:682)
                    margin: EdgeInsets.fromLTRB(17*fem, 0*fem, 18*fem, 10*fem),
                    width: double.infinity,
                    height: 32*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // group36706XZy (81:684)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(10.43*fem, 10*fem, 181.55*fem, 10*fem),
                          height: double.infinity,
                          decoration: BoxDecoration (
                            border: Border.all(color: Color(0xffb3b3b3)),
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(23*fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // iconmagnifyingglassp3H (81:687)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13.33*fem, 2*fem),
                                width: 8.69*fem,
                                height: 10*fem,
                                child: Image.asset(
                                  'assets/page-1/images/icon-magnifying-glass.png',
                                  width: 8.69*fem,
                                  height: 10*fem,
                                ),
                              ),
                              Text(
                                // findparameteruaX (I81:686;76:75)
                                'Find Parameter',
                                style: SafeGoogleFont (
                                  'Google Sans',
                                  fontSize: 10*ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.1350000381*ffem/fem,
                                  color: Color(0xff3c4348),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // ellipse2qyy (81:683)
                          width: 31*fem,
                          height: 31*fem,
                          decoration: BoxDecoration (
                            borderRadius: BorderRadius.circular(15.5*fem),
                            image: DecorationImage (
                              image: AssetImage (
                                'assets/page-1/images/ellipse-2-bg.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // monitoringupbarZ9H (81:567)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 18*fem),
                    width: 360*fem,
                    height: 1*fem,
                    child: Image.asset(
                      'assets/page-1/images/monitoring-upbar.png',
                      width: 360*fem,
                      height: 1*fem,
                    ),
                  ),
                  Container(
                    // smartmonitoringcontrolling57d (81:690)
                    margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 0*fem, 16*fem),
                    child: Text(
                      'Smart Monitoring & Controlling',
                      style: SafeGoogleFont (
                        'Google Sans',
                        fontSize: 18*ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.135000017*ffem/fem,
                        color: Color(0xff444749),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup4ynzNsR (LUqTmhvyCgwgHXaHMH4YNZ)
                    margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 10*fem, 8*fem),
                    width: double.infinity,
                    height: 167*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group3huh (81:595)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(10*fem, 12*fem, 10*fem, 18*fem),
                          width: 167*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(18*fem),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur (
                                sigmaX: 25*fem,
                                sigmaY: 25*fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupvkjxZBD (LUqU5HG25WkiUe2d95vkjX)
                                    margin: EdgeInsets.fromLTRB(4*fem, 0*fem, 89*fem, 26*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // vector6B9 (81:598)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 0*fem),
                                          width: 12*fem,
                                          height: 12*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/vector.png',
                                            width: 12*fem,
                                            height: 12*fem,
                                          ),
                                        ),
                                        Text(
                                          // phlevelDWf (81:597)
                                          'pH level',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0x8908083d),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // group36720kmV (81:800)
                                    margin: EdgeInsets.fromLTRB(37*fem, 0*fem, 38*fem, 14*fem),
                                    padding: EdgeInsets.fromLTRB(19.5*fem, 0*fem, 23.5*fem, 0*fem),
                                    width: double.infinity,
                                    height: 28*fem,
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(6*fem),
                                      gradient: LinearGradient (
                                        begin: Alignment(-0.944, -0.75),
                                        end: Alignment(1, 1),
                                        colors: <Color>[Color(0xfff0f0f0), Color(0xfff6f6f6)],
                                        stops: <double>[0, 1],
                                      ),
                                    ),
                                    child: Text(
                                      '7.1',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 21*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // group36719A4X (81:788)
                                    width: double.infinity,
                                    height: 55*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // rectangle31gYf (81:789)
                                          left: 0*fem,
                                          top: 9*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 147*fem,
                                              height: 46*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(14*fem),
                                                  border: Border.all(color: Color(0xffd8dadc)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // unionbQj (81:790)
                                          left: 99*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 23.16*fem,
                                              height: 22*fem,
                                              child: Image.asset(
                                                'assets/page-1/images/union.png',
                                                width: 23.16*fem,
                                                height: 22*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // Jpw (81:793)
                                          left: 103.4663085938*fem,
                                          top: 4*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 15*fem,
                                              height: 11*fem,
                                              child: Text(
                                                '75%',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 8*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // levelaccuracyDh1 (81:794)
                                          left: 10.4580078125*fem,
                                          top: 44*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 37*fem,
                                              height: 8*fem,
                                              child: Text(
                                                'Level accuracy',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 6*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0x8908083d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // baduJw (81:795)
                                          left: 10.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'bad',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xffff0d0d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // good175 (81:796)
                                          left: 130.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 11*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'good',
                                                textAlign: TextAlign.right,
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff00ba07),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // group1VY3 (81:797)
                                          left: 10*fem,
                                          top: 26*fem,
                                          child: Container(
                                            width: 132*fem,
                                            height: 16*fem,
                                            decoration: BoxDecoration (
                                              color: Color(0xffd8dadc),
                                              borderRadius: BorderRadius.circular(31*fem),
                                            ),
                                            child: Align(
                                              // rectangle51mH (81:799)
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 101*fem,
                                                height: 16*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(31*fem),
                                                    color: Color(0xff00ba07),
                                                  ),
                                                ),
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
                          ),
                        ),
                        Container(
                          // group10M4T (81:612)
                          padding: EdgeInsets.fromLTRB(10*fem, 11*fem, 10*fem, 8*fem),
                          width: 167*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(18*fem),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur (
                                sigmaX: 25*fem,
                                sigmaY: 25*fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupc8ehox3 (LUqUSrUQaN6X9ZrdF1c8EH)
                                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 56*fem, 6*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // vectorkMV (81:781)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 4*fem, 1*fem),
                                          width: 13*fem,
                                          height: 7*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/vector-1yZ.png',
                                            width: 13*fem,
                                            height: 7*fem,
                                          ),
                                        ),
                                        Text(
                                          // ammonialevelUYP (81:614)
                                          'Ammonia level',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0x8908083d),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // autogroup859xpMM (LUqUXrL5bu1UkLaCdf859X)
                                    margin: EdgeInsets.fromLTRB(35*fem, 0*fem, 40*fem, 3*fem),
                                    padding: EdgeInsets.fromLTRB(4.5*fem, 1*fem, 5.5*fem, 0*fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(6*fem),
                                      gradient: LinearGradient (
                                        begin: Alignment(-0.944, -0.75),
                                        end: Alignment(1, 1),
                                        colors: <Color>[Color(0xfff0f0f0), Color(0xfff6f6f6)],
                                        stops: <double>[0, 1],
                                      ),
                                    ),
                                    child: Text(
                                      '0.2 mg',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 21*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // group36719FxT (81:770)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                                    width: double.infinity,
                                    height: 55*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // rectangle31z9M (81:785)
                                          left: 0*fem,
                                          top: 9*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 147*fem,
                                              height: 46*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(14*fem),
                                                  border: Border.all(color: Color(0xffd8dadc)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // unionuGK (81:771)
                                          left: 38*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 23.16*fem,
                                              height: 22*fem,
                                              child: Image.asset(
                                                'assets/page-1/images/union-ES3.png',
                                                width: 23.16*fem,
                                                height: 22*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // 263 (81:774)
                                          left: 42.4664306641*fem,
                                          top: 4*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 15*fem,
                                              height: 11*fem,
                                              child: Text(
                                                '25%',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 8*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // levelaccuracyjFM (81:775)
                                          left: 10.4580078125*fem,
                                          top: 44*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 37*fem,
                                              height: 8*fem,
                                              child: Text(
                                                'Level accuracy',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 6*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0x8908083d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // bad2ET (81:776)
                                          left: 10.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'bad',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xffff0d0d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // goodj8s (81:777)
                                          left: 130.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 11*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'good',
                                                textAlign: TextAlign.right,
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff00ba07),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // group1EbR (81:778)
                                          left: 10*fem,
                                          top: 26*fem,
                                          child: Container(
                                            width: 132*fem,
                                            height: 16*fem,
                                            decoration: BoxDecoration (
                                              color: Color(0xffd8dadc),
                                              borderRadius: BorderRadius.circular(31*fem),
                                            ),
                                            child: Align(
                                              // rectangle5xGX (81:780)
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 40*fem,
                                                height: 16*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(31*fem),
                                                    color: Color(0xffe64646),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // filteringgiK (81:783)
                                    margin: EdgeInsets.fromLTRB(80*fem, 0*fem, 0*fem, 3*fem),
                                    child: Text(
                                      'Filtering',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 8*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0x8908083d),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // offbutton1oY3 (81:732)
                                    margin: EdgeInsets.fromLTRB(92*fem, 0*fem, 0*fem, 0*fem),
                                    width: 41*fem,
                                    height: 17*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/off-button-1.png',
                                      fit: BoxFit.cover,
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
                  Container(
                    // autogrouppuay7od (LUqVB5m3T21cxt7YHspUay)
                    margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 10*fem, 8*fem),
                    padding: EdgeInsets.fromLTRB(13*fem, 6*fem, 17*fem, 6*fem),
                    width: double.infinity,
                    height: 105*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(18*fem),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur (
                          sigmaX: 25*fem,
                          sigmaY: 25*fem,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // autogroupfxzfNjZ (LUqVR5Mj87NJeEvMPHfXZF)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 7*fem, 29*fem),
                              width: 77*fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // autogrouphqpqgkF (LUqVZ58QNARqbsfg1XHqpq)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 22*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // vector23R (81:583)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5*fem, 0*fem),
                                          width: 12*fem,
                                          height: 10*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/vector-FpT.png',
                                            width: 12*fem,
                                            height: 10*fem,
                                          ),
                                        ),
                                        Text(
                                          // temperatureLZu (81:582)
                                          'Temperature',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0x8908083d),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // frame36721gNs (81:815)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 0*fem),
                                    padding: EdgeInsets.fromLTRB(7.52*fem, 1*fem, 7.48*fem, 0*fem),
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(6*fem),
                                      gradient: LinearGradient (
                                        begin: Alignment(-0.944, -0.75),
                                        end: Alignment(1, 1),
                                        colors: <Color>[Color(0xfff0f0f0), Color(0xfff6f6f6)],
                                        stops: <double>[0, 1],
                                      ),
                                    ),
                                    child: Text(
                                      '19°C',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 21*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // frame36719h35 (81:801)
                              margin: EdgeInsets.fromLTRB(0*fem, 17*fem, 40*fem, 21*fem),
                              width: 147*fem,
                              height: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // rectangle31D1R (81:802)
                                    left: 0*fem,
                                    top: 9*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 147*fem,
                                        height: 46*fem,
                                        child: Container(
                                          decoration: BoxDecoration (
                                            borderRadius: BorderRadius.circular(14*fem),
                                            border: Border.all(color: Color(0xffd8dadc)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // unionuew (81:803)
                                    left: 38*fem,
                                    top: 0*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 23.16*fem,
                                        height: 22*fem,
                                        child: Image.asset(
                                          'assets/page-1/images/union-8Ab.png',
                                          width: 23.16*fem,
                                          height: 22*fem,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // 1xs (81:806)
                                    left: 42.4663085938*fem,
                                    top: 4*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 15*fem,
                                        height: 11*fem,
                                        child: Text(
                                          '25%',
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 8*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // levelaccuracyKyZ (81:807)
                                    left: 10.4580078125*fem,
                                    top: 44*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 37*fem,
                                        height: 8*fem,
                                        child: Text(
                                          'Level accuracy',
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 6*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0x8908083d),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // badS2b (81:808)
                                    left: 10.4580078125*fem,
                                    top: 18*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 9*fem,
                                        height: 7*fem,
                                        child: Text(
                                          'bad',
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 5*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0xffff0d0d),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // goodwk3 (81:809)
                                    left: 130.4580078125*fem,
                                    top: 18*fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 11*fem,
                                        height: 7*fem,
                                        child: Text(
                                          'good',
                                          textAlign: TextAlign.right,
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 5*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0xff00ba07),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // group1eeT (81:810)
                                    left: 10*fem,
                                    top: 26*fem,
                                    child: Container(
                                      width: 132*fem,
                                      height: 16*fem,
                                      decoration: BoxDecoration (
                                        color: Color(0xffd8dadc),
                                        borderRadius: BorderRadius.circular(31*fem),
                                      ),
                                      child: Align(
                                        // rectangle5ZWX (81:812)
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 40*fem,
                                          height: 16*fem,
                                          child: Container(
                                            decoration: BoxDecoration (
                                              borderRadius: BorderRadius.circular(31*fem),
                                              color: Color(0xffe64646),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // autogroupcwn5toh (LUqViuBMrK2PcbDAwjCwN5)
                              margin: EdgeInsets.fromLTRB(0*fem, 14*fem, 0*fem, 13*fem),
                              width: 41*fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // heaterD5H (81:817)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 3*fem),
                                    width: double.infinity,
                                    child: Text(
                                      'Heater',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 8*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0x8908083d),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // offbutton1vkP (81:816)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                    width: 41*fem,
                                    height: 17*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/off-button-1-pH5.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    // coolerTEX (81:819)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 2*fem),
                                    width: double.infinity,
                                    child: Text(
                                      'Cooler',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 8*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0x8908083d),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // offbutton2Aud (81:818)
                                    width: 41*fem,
                                    height: 17*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/off-button-2.png',
                                      fit: BoxFit.cover,
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
                    // autogrouphtzdXEP (LUqWAUH5yBtxmLQqMmhTzd)
                    margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 10*fem, 2*fem),
                    width: double.infinity,
                    height: 167*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group34EK (81:629)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                          padding: EdgeInsets.fromLTRB(10*fem, 7*fem, 10*fem, 8*fem),
                          width: 167*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(18*fem),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur (
                                sigmaX: 25*fem,
                                sigmaY: 25*fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupcz25Ws1 (LUqWM8dzHveLiBQbXRCZ25)
                                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 26*fem, 9.3*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // iconraindropsrAB (81:632)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 6.67*fem, 0*fem),
                                          width: 11.33*fem,
                                          height: 15.7*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/icon-raindrops.png',
                                            width: 11.33*fem,
                                            height: 15.7*fem,
                                          ),
                                        ),
                                        Text(
                                          // totaldissolvedsolidsMMq (81:631)
                                          'Total dissolved solids',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Google Sans',
                                            fontSize: 11*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2575*ffem/fem,
                                            color: Color(0x8908083d),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // autogroupivwkg9D (LUqWS8VfKTZJJx8Av4iVwK)
                                    margin: EdgeInsets.fromLTRB(22*fem, 0*fem, 28*fem, 2*fem),
                                    padding: EdgeInsets.fromLTRB(8.5*fem, 0*fem, 8.5*fem, 0*fem),
                                    width: double.infinity,
                                    height: 28*fem,
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(6*fem),
                                      gradient: LinearGradient (
                                        begin: Alignment(-0.944, -0.75),
                                        end: Alignment(1, 1),
                                        colors: <Color>[Color(0xfff0f0f0), Color(0xfff6f6f6)],
                                        stops: <double>[0, 1],
                                      ),
                                    ),
                                    child: Text(
                                      '147 ppm',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 21*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // group36719goR (81:821)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                                    width: double.infinity,
                                    height: 55*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // rectangle31ot3 (81:822)
                                          left: 0*fem,
                                          top: 9*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 147*fem,
                                              height: 46*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(14*fem),
                                                  border: Border.all(color: Color(0xffd8dadc)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // unionik7 (81:823)
                                          left: 98*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 23.16*fem,
                                              height: 22*fem,
                                              child: Image.asset(
                                                'assets/page-1/images/union-koR.png',
                                                width: 23.16*fem,
                                                height: 22*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // q43 (81:826)
                                          left: 102.4663085938*fem,
                                          top: 4*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 15*fem,
                                              height: 11*fem,
                                              child: Text(
                                                '75%',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 8*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // levelaccuracyjQK (81:827)
                                          left: 10.4580078125*fem,
                                          top: 44*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 37*fem,
                                              height: 8*fem,
                                              child: Text(
                                                'Level accuracy',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 6*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0x8908083d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // badEby (81:828)
                                          left: 10.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'bad',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xffff0d0d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // goodMAo (81:829)
                                          left: 130.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 11*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'good',
                                                textAlign: TextAlign.right,
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff00ba07),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // group1s99 (81:830)
                                          left: 10*fem,
                                          top: 26*fem,
                                          child: Container(
                                            width: 132*fem,
                                            height: 16*fem,
                                            decoration: BoxDecoration (
                                              color: Color(0xffd8dadc),
                                              borderRadius: BorderRadius.circular(31*fem),
                                            ),
                                            child: Align(
                                              // rectangle5PtB (81:832)
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 101*fem,
                                                height: 16*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(31*fem),
                                                    color: Color(0xff00ba07),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // waterpumpXUb (81:834)
                                    margin: EdgeInsets.fromLTRB(96*fem, 0*fem, 0*fem, 3*fem),
                                    child: Text(
                                      'Water pump',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 8*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0x8908083d),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // offbutton1F9h (81:833)
                                    margin: EdgeInsets.fromLTRB(92*fem, 0*fem, 0*fem, 0*fem),
                                    width: 41*fem,
                                    height: 17*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/off-button-1-bM1.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // group10P11 (81:647)
                          padding: EdgeInsets.fromLTRB(10*fem, 6*fem, 10*fem, 8*fem),
                          width: 167*fem,
                          height: double.infinity,
                          decoration: BoxDecoration (
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(18*fem),
                          ),
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur (
                                sigmaX: 25*fem,
                                sigmaY: 25*fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroup76arSjy (LUqWmsRmaDN5vo9zi276AR)
                                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 41*fem, 9*fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // vectorBSf (81:649)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 9*fem, 0*fem),
                                          width: 13*fem,
                                          height: 17*fem,
                                          child: Image.asset(
                                            'assets/page-1/images/vector-zpF.png',
                                            width: 13*fem,
                                            height: 17*fem,
                                          ),
                                        ),
                                        Container(
                                          // dissolvedoxygen6pX (81:650)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                          child: Text(
                                            'Dissolved oxygen',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'Google Sans',
                                              fontSize: 11*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575*ffem/fem,
                                              color: Color(0x8908083d),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // autogroup4dw3R67 (LUqWrnTFKHfMw9vkB84dw3)
                                    margin: EdgeInsets.fromLTRB(22*fem, 0*fem, 28*fem, 2*fem),
                                    padding: EdgeInsets.fromLTRB(8*fem, 0*fem, 8*fem, 0*fem),
                                    width: double.infinity,
                                    height: 28*fem,
                                    decoration: BoxDecoration (
                                      borderRadius: BorderRadius.circular(6*fem),
                                      gradient: LinearGradient (
                                        begin: Alignment(-0.944, -0.75),
                                        end: Alignment(1, 1),
                                        colors: <Color>[Color(0xfff0f0f0), Color(0xfff6f6f6)],
                                        stops: <double>[0, 1],
                                      ),
                                    ),
                                    child: Text(
                                      '2.5 mg/L',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 21*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0xff444444),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // group3671937V (81:837)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                                    width: double.infinity,
                                    height: 55*fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // rectangle31Mdy (81:838)
                                          left: 0*fem,
                                          top: 9*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 147*fem,
                                              height: 46*fem,
                                              child: Container(
                                                decoration: BoxDecoration (
                                                  borderRadius: BorderRadius.circular(14*fem),
                                                  border: Border.all(color: Color(0xffd8dadc)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // union4YP (81:839)
                                          left: 71*fem,
                                          top: 0*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 23.16*fem,
                                              height: 22*fem,
                                              child: Image.asset(
                                                'assets/page-1/images/union-PhR.png',
                                                width: 23.16*fem,
                                                height: 22*fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // yfM (81:842)
                                          left: 75*fem,
                                          top: 4*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 15*fem,
                                              height: 11*fem,
                                              child: Text(
                                                '50%',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 8*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // levelaccuracygpf (81:843)
                                          left: 10.4580078125*fem,
                                          top: 44*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 37*fem,
                                              height: 8*fem,
                                              child: Text(
                                                'Level accuracy',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 6*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.2575*ffem/fem,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0x8908083d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // badPDH (81:844)
                                          left: 10.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 9*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'bad',
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xffff0d0d),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // goodVXD (81:845)
                                          left: 130.4580078125*fem,
                                          top: 18*fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 11*fem,
                                              height: 7*fem,
                                              child: Text(
                                                'good',
                                                textAlign: TextAlign.right,
                                                style: SafeGoogleFont (
                                                  'Google Sans',
                                                  fontSize: 5*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.2575*ffem/fem,
                                                  color: Color(0xff00ba07),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // group1bKM (81:846)
                                          left: 10*fem,
                                          top: 26*fem,
                                          child: Container(
                                            width: 132*fem,
                                            height: 16*fem,
                                            decoration: BoxDecoration (
                                              color: Color(0xffd8dadc),
                                              borderRadius: BorderRadius.circular(31*fem),
                                            ),
                                            child: Align(
                                              // rectangle5KWF (81:848)
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 73*fem,
                                                height: 16*fem,
                                                child: Container(
                                                  decoration: BoxDecoration (
                                                    borderRadius: BorderRadius.circular(31*fem),
                                                    color: Color(0xfffaa300),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // waterpumpeoR (81:850)
                                    margin: EdgeInsets.fromLTRB(96*fem, 0*fem, 0*fem, 3*fem),
                                    child: Text(
                                      'Water pump',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Google Sans',
                                        fontSize: 8*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2575*ffem/fem,
                                        color: Color(0x8908083d),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // offbutton1NDd (81:849)
                                    margin: EdgeInsets.fromLTRB(92*fem, 0*fem, 0*fem, 0*fem),
                                    width: 41*fem,
                                    height: 17*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/off-button-1-8y5.png',
                                      fit: BoxFit.cover,
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
                  TextButton(
                    // group36712Vp3 (81:665)
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: 360*fem,
                      height: 51*fem,
                      child: Image.asset(
                        'assets/page-1/images/group-36712-2pF.png',
                        width: 360*fem,
                        height: 51*fem,
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