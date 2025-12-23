import 'dart:ui';

import 'package:buyoil/common/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static final tsStart = TextStyle(
    color: AppColors.PRIMARY,
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  static TextStyle tsTextField = TextStyle(
    color: AppColors.TEXT_20,
    fontSize: 28,
    fontWeight: FontWeight.w400,
  );

  static TextStyle enterPhoneNumberTextStyle = TextStyle(
    color: AppColors.TEXT_11,
    fontSize: 28,
    fontWeight: FontWeight.w400,
  );

  static TextStyle tsStepNavText = TextStyle(
    color: Colors.white,
    fontSize: 29,
    fontWeight: FontWeight.w400,
  );

  static TextStyle tsStep1Toast = TextStyle(
    color: AppColors.TEXT_33,
    fontSize: 40,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );

  static TextStyle tsOpenBtn = TextStyle(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static TextStyle tsDoorOpeningText = TextStyle(
    color: Colors.black,
    fontSize: 40,
    fontWeight: FontWeight.w400
  );

  static TextStyle tsStep4 = TextStyle(
    color: AppColors.FF5E5C5C,
    fontSize: 48,
    fontWeight: FontWeight.w400
  );

  static TextStyle tsSetting = TextStyle(
      color: Colors.white,
      fontSize: 48,
      fontWeight: FontWeight.w700
  );

  static TextStyle tsSettingBox = TextStyle(
      color: Colors.white,
      fontSize: 44,
      height: 1.2,
      fontWeight: FontWeight.w400
  );
}