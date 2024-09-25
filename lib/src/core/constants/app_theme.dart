import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

import '../utility/color_tools.dart';

mixin AppTheme {
  ThemeColor get clr => ThemeColor.instance;
  ThemeSize get size => ThemeSize.instance;
}

class ThemeColor {
  ThemeColor._();
  static ThemeColor? _instance;
  static ThemeColor get instance => _instance ?? (_instance = ThemeColor._());

  Color get appPrimaryColorBlue => HexColor("0072BC");
  Color get grad1 => HexColor("97ABFF");
  Color get grad2 => HexColor("123597");
  Color get grad3 => HexColor("748BDD");

  Color get appSecondaryColorPink => HexColor("BB009C");
  Color get scaffoldBackgroundColor => HexColor("F9FEFD");
  Color get scaffoldBackgroundColor2 => HexColor("ECFBF7");
  Color get secondaryBackgroundColor => HexColor("FFFEFE");
  Color get cardColor1 => HexColor("34495E");
  Color get cardColorBorder1 => HexColor("71808F");
  Color get cardColor2 => HexColor("16A085");
  Color get cardColorBorder2 => HexColor("5CBDAA");
  Color get cardColor3 => HexColor("B16376");
  Color get cardColorBorder3 => HexColor("C8919E");
  Color get ratingBgColor => HexColor("CDD4F8");
  Color get enterTrainingButtonColor => HexColor("16C995");
  Color get progressBgColor => HexColor("F2F5FA");
  Color get progressBgColor2 => HexColor("D4EDDA");
  Color get textGrey => HexColor("4a4b65");
  Color get playButtonBG => HexColor("D8D8ED");
  Color get headerColor => HexColor("7A6FF4");
  Color get addCommentButtonColor => HexColor("4075C5");

  Color get whiteColor => HexColor("FFFFFF");
  Color get shadeWhiteColor => HexColor("FDFDFD");
  Color get shadeWhiteColor2 => HexColor("FEFFFF");
  Color get blackColor => HexColor("000000");
  Color get whiteShade => HexColor("FAFAFA");
  Color get greyColor => HexColor("B6B6B6");
  Color get dropdownHintColorGrey => HexColor("959596");
  Color get strokeToggleColor => HexColor("CBE1A9");
  Color get iconColorHint => HexColor("797979");
  Color get iconColorWhiteIce => HexColor("D1ECE4");
  Color get iconColorRed => HexColor("F27785");
  Color get iconColorBlack => HexColor("1C1B1F");
  Color get iconColorSweetRed => HexColor("FF4A5F");
  Color get iconColorDimGrey => HexColor("6B6A6A");
  Color get iconColorDarkGrey => HexColor("656565");
  Color get noteBoxColor => HexColor("F4FFFD");
  Color get iconColorBlue => HexColor("1D78FF");
  Color get iconColorRedShade => HexColor("FFBFC7");

  Color get textColorAppleBlack => HexColor("1D1D1F");
  Color get textColorBlack => HexColor("525252");
  Color get textColorGray => HexColor("A8A8A8");
  Color get textColorGray2 => HexColor("7A7A7A");
  Color get placeHolderTextColorGray => HexColor("9F9F9F");
  Color get blackText => HexColor("222222");

  Color get boxStrokeColor => HexColor("DFDFDF");
  Color get boxStrokeColorSilver => HexColor("C0C0C0");
  Color get cardStrokeColor => HexColor("B6DED4");
  Color get cardStrokeColorOrange => HexColor("E4AF81");
  Color get cardStrokeColorGreen => HexColor("B7D37A");
  Color get cardStrokeColorPurple => HexColor("CCBDE2");
  Color get cardStrokeColorBlue => HexColor("ABCEE3");
  Color get cardStrokeColorGrey => HexColor("EAEAEA");
  Color get cardStrokeColorGrey2 => HexColor("D0D0D0");
  Color get dividerStrokeColorGrey => HexColor("B0B0B0");
  Color get gapStrokeGrey => HexColor("646464");
  Color get cardStrokeColorLeafGreen => HexColor("B6D7A8");

  Color get fromBoxFillColor => HexColor("FCFFFE");
  Color get cardFillColorWhite => HexColor("FFFEFF");
  Color get cardFillColorOrange => HexColor("FFE7D2");
  Color get cardFillColorGreen => HexColor("ECFFC2");
  Color get cardFillColorPurple => HexColor("F1E8FF");
  Color get cardFillColorBlue => HexColor("D7EEFC");
  Color get cardFillColorCruise => HexColor("B3E0DD");
  Color get cardFillColorAliceBlue => HexColor("F0FCF9");
  Color get cardFillColorMintCream => HexColor("F9FFFD");
  Color get cardFillColorOlive => HexColor("DEEEC6");
  Color get drawerFillColor => HexColor("E6F8F4");

  Color get clickableLinkColor => HexColor("4A88FF");
  Color get progressBGColor => HexColor("D9D9D9");
  Color get progressColorOrange => HexColor("FA916B");
  Color get progressColorBlue => HexColor("0875CF");

  Color get graphData => HexColor("B5D4BD");
  Color get cardStrokeColorHint => HexColor("D1D1D1");

  Color get toastSuccessColor => HexColor("87CA8A");
  Color get toastSuccessBackgroundColor => HexColor("E7F4E8");
  Color get toastWarningColor => HexColor("FFBB52");
  Color get toastWarningBackgroundColor => HexColor("FFE9D6");
  Color get toastErrorColor => HexColor("FF8E6A");
  Color get toastErrorBackgroundColor => HexColor("FFE6E9");
  Color get toastAskColor => HexColor("68B1EF");
  Color get backgroundColorMintCream => HexColor("F2FCFA");
  Color get backgroundColorGreenCyan => HexColor("E7FDF8");
  Color get placeHolderDeselectGray => HexColor("959596");
}

// final localStorage = Get.find<LocalStorageServiceWithGetX>();
//
// double sizeValue = localStorage.getBooleanValue(StringData.textSizeKey) != null
//     ? localStorage.getBooleanValue(StringData.textSizeKey) == true
//         ? 6.0
//         : 0.0
//     : 0.0;

class ThemeSize {
  ThemeSize._();
  static ThemeSize? _instance;
  static ThemeSize get instance => _instance ?? (_instance = ThemeSize._());
  // final localStorage = Get.find<LocalStorageServiceWithGetX>();
  //
  // accessibilityValueSet(double value, bool revert) {
  //   sizeValue = value;
  //   localStorage.storeBooleanValue(StringData.textSizeKey, revert);
  // }

  double get textXXXLarge => 44.sp;
  double get textXXLarge => 36.sp;
  double get textXLarge => 26.sp;
  double get textLarge => 22.sp;
  double get textXMedium => 20.sp;
  double get textMedium => 18.sp;
  double get textSmall => 16.sp;
  double get textXSmall => 14.sp;
  double get textXXSmall => 12.sp;
  double get textXXXSmall => 10.sp;

  double get r1 => 1.r;
  double get r4 => 4.r;
  double get r8 => 8.r;
  double get r10 => 10.r;
  double get r12 => 12.r;
  double get r16 => 16.r;
  double get r20 => 20.r;
  double get r24 => 24.r;
  double get r28 => 28.r;
  double get r50 => 50.r;

  double get w1 => 1.w;
  double get w2 => 2.w;
  double get w4 => 4.w;
  double get w6 => 6.w;
  double get w8 => 8.w;
  double get w10 => 10.w;
  double get w12 => 12.w;
  double get w16 => 16.w;
  double get w20 => 20.w;
  double get w22 => 22.w;
  double get w24 => 24.w;
  double get w28 => 28.w;
  double get w32 => 32.w;
  double get w40 => 40.w;
  double get w42 => 42.w;
  double get w44 => 44.w;
  double get w48 => 48.w;
  double get w56 => 56.w;
  double get w64 => 64.w;

  double get h1 => 1.h;
  double get h2 => 2.h;
  double get h4 => 4.h;
  double get h6 => 6.h;
  double get h8 => 8.h;
  double get h10 => 10.h;
  double get h12 => 12.h;
  double get h16 => 16.h;
  double get h20 => 20.h;
  double get h22 => 22.h;
  double get h24 => 24.h;
  double get h28 => 28.h;
  double get h32 => 32.h;
  double get h40 => 40.h;
  double get h42 => 42.h;
  double get h44 => 44.h;
  double get h48 => 48.h;
  double get h56 => 56.h;
  double get h64 => 64.h;
  double get h100 => 100.h;
}
