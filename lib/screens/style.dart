import 'package:flutter/material.dart';

const LargeTextSize = 28.0;
const MediumTextSize = 23.0;
const BodyTextSize = 18.0;

const String DefaultFontFamily = 'FreeSans';

const AppBarTextStyle = TextStyle(
  // fontFamily: DefaultFontFamily,
  fontWeight: FontWeight.w600,
  fontSize: MediumTextSize,
  color: Colors.white,
);

const DarkAccentColor = Color(0xff8B8C89);
const PrimaryAccentColor = Color(0xff274C77);
const SecondaryAccentColor = Color(0xff6096BA);
const TertiaryAccentColor = Color(0xffA3CEF1);
const LightAccentColor = Color(0xffE7ECEF);

const TitleTextStyle = TextStyle(
  // fontFamily: FontNameDefault,
  fontWeight: FontWeight.w500,
  fontSize: LargeTextSize,
  color: PrimaryAccentColor,
);

const Body1TextStyle = TextStyle(
  // fontFamily: FontNameDefault,
  fontWeight: FontWeight.w400,
  fontSize: BodyTextSize,
  color: DarkAccentColor,
);