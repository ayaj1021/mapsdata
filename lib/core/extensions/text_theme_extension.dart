import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension TextThem on TextTheme {
  //SIZE 700
  TextStyle get s30w700 =>
      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700);
  TextStyle get s16w700 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700);
  TextStyle get s24w700 =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700);
  TextStyle get s18w700 =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700);
  TextStyle get s14w700 =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
  TextStyle get s12w700 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700);

  //SIZE 600
  TextStyle get s50w600 =>
      TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w600);
  TextStyle get s40w600 =>
      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w600);
  TextStyle get s32w600 =>
      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600);
  TextStyle get s35w600 =>
      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w600);
  TextStyle get s30w600 =>
      TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600);
  TextStyle get s25w600 =>
      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600);
  TextStyle get s22w600 =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600);
  TextStyle get s24w600 =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600);
  TextStyle get s20w600 =>
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);
  TextStyle get s10w600 =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600);
  TextStyle get s12w600 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
  TextStyle get s14w600 =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
  TextStyle get s15w600 =>
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600);
  TextStyle get s16w600 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
  TextStyle get s18w600 =>
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600);

  //SIZE 500
  TextStyle get s18w500 =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);
  TextStyle get s16w500 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  TextStyle get s15w500 =>
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500);
  TextStyle get s14w500 =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  TextStyle get s12w500 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get s10w500 =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);

  //SIZE 400
  TextStyle get s10w400 =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);
  TextStyle get s8w400 =>
      TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400);
  TextStyle get s12w400 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
  TextStyle get s13w400 =>
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400);
  TextStyle get s14w400 =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
  TextStyle get s15w400 =>
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400);
  TextStyle get s16w400 =>
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

  //SIZE 300
  TextStyle get s12w300 =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w300);

  TextStyle get s10w300 =>
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300);
}
