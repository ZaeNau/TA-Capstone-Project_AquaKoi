import 'package:flutter/material.dart';
import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMediumBluegray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray900,
      );
  static get bodyMediumGray80002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray80002,
      );
  static get bodyMediumInter => theme.textTheme.bodyMedium!.inter;
  static get bodyMediumInterOnSecondaryContainer =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      );
  static get bodyMediumInterPrimary =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.5),
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.5),
      );
  static get bodyMediumff000000 => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFF000000),
      );
  static get bodyMediumffffffff => theme.textTheme.bodyMedium!.copyWith(
        color: const Color(0XFFFFFFFF),
      );
  static get bodySmallGray80003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray80003,
        fontSize: 10.fSize,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(0.54),
        fontSize: 11.fSize,
      );
  static get bodySmallPrimaryContainer_1 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(0.54),
      );
  // Google text style
  static get googleSansGreenA700 => TextStyle(
        color: appTheme.greenA700,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w700,
      ).googleSans;
  static get googleSansPrimaryContainer => TextStyle(
        color: theme.colorScheme.primaryContainer,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      ).googleSans;
  static get googleSansSecondaryContainer => TextStyle(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w700,
      ).googleSans;
  // Headline text style
  static get headlineMediumPurpleA200 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.purpleA200,
      );
  // Label text style
  static get labelLargeff000000 => theme.textTheme.labelLarge!.copyWith(
        color: const Color(0XFF000000),
        fontWeight: FontWeight.w700,
      );
  static get labelLargeffffffff => theme.textTheme.labelLarge!.copyWith(
        color: const Color(0XFFFFFFFF),
        fontWeight: FontWeight.w700,
      );
  // Montserrat text style
  static get montserratBlueA400 => TextStyle(
        color: appTheme.blueA400,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w700,
      ).montserrat;
  static get montserratGray300 => TextStyle(
        color: appTheme.gray300,
        fontSize: 5.fSize,
        fontWeight: FontWeight.w700,
      ).montserrat;
  // Title text style
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 20.fSize,
      );
  static get titleLargePrimary22 => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 22.fSize,
      );
  static get titleMediumGray800 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray800,
        fontSize: 18.fSize,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.fSize,
      );
}

extension on TextStyle {
  TextStyle get googleSans {
    return copyWith(
      fontFamily: 'Google Sans',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }
}
