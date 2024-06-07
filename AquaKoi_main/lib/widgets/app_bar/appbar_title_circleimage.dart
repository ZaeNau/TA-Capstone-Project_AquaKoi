import 'package:flutter/material.dart';
import '/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleCircleimage extends StatelessWidget {
  AppbarTitleCircleimage({
    super.key,
    this.imagePath,
    this.margin,
    this.onTap,
  });

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadiusStyle.roundedBorder15,
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: imagePath,
          height: 31.adaptSize,
          width: 31.adaptSize,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            15.h,
          ),
        ),
      ),
    );
  }
}
