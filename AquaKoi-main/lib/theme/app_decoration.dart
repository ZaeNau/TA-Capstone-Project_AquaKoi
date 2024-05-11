import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueA => BoxDecoration(
        color: appTheme.blueA400,
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
  static BoxDecoration get fillOnSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
      );

  // Gradient decoration examples
  static BoxDecoration get gradientGrayToBlueGray => BoxDecoration(
       borderRadius: BorderRadius.circular(20),  // Rounded edges for the button
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.grey[600]!, // Start of gradient
        Colors.grey[900]!, // End of gradient
      ],
    ),
  );

  static BoxDecoration get gradientLightBlueToBlueA => BoxDecoration(
    borderRadius: BorderRadius.circular(20),  // Rounded edges for the button
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.blue[700]!, // Start of gradient
        Colors.lightBlue[400]!, // End of gradient
      ],
    ),
  );



  // Outline decorations
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder43 => BorderRadius.circular(
        43.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder11 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder18 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder68 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        12.h,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
