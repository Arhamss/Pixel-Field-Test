import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixelfield_test/constants/app_colors.dart';

extension AppTextStyle on BuildContext {
  // Headline Styles (EB Garamond)
  // Headline/Large - Based on Figma
  TextStyle get headlineLarge => GoogleFonts.ebGaramond(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25, // lineHeight: 1.25em
    color: AppColors.greyscaleGrey1,
  );

  // Headers (keeping for backward compatibility, using EB Garamond)
  TextStyle get h1 => GoogleFonts.ebGaramond(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get h2 => GoogleFonts.ebGaramond(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get h3 => GoogleFonts.ebGaramond(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  // Title Styles (EB Garamond)
  TextStyle get t1 => GoogleFonts.ebGaramond(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get t2 => GoogleFonts.ebGaramond(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get t3 => GoogleFonts.ebGaramond(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.greyscaleGrey1,
  );

  // Body Styles (Lato)
  // Body/Large - Based on Figma
  TextStyle get bodyLarge => GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5, // lineHeight: 1.5em
    letterSpacing: 0.08, // 0.5% of 16px
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get b1 => GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.07, // 0.5% of 14px
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get b2 => GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.07,
    color: AppColors.greyscaleGrey1,
  );

  TextStyle get b3 => GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.06, // 0.5% of 12px
    color: AppColors.greyscaleGrey1,
  );

  // Button Styles (EB Garamond)
  // Button/Large - Based on Figma
  TextStyle get buttonLarge => GoogleFonts.ebGaramond(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5, // lineHeight: 1.5em
    letterSpacing: 0.016, // 0.1% of 16px
    color: AppColors.greyscaleBlack3,
  );

  // Label Styles (Lato)
  TextStyle get l1 => GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.0, // lineHeight: 1em
    color: AppColors.greyscaleGrey2,
  );

  TextStyle get l2 => GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.greyscaleGrey2,
  );

  TextStyle get l3 => GoogleFonts.lato(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.greyscaleGrey2,
  );
}

extension TextStyleSecondary on TextStyle {
  TextStyle get secondary => copyWith(color: AppColors.white);

  TextStyle get tertiary => copyWith(color: AppColors.textTertiary);

  // Figma color variants
  TextStyle get greyscaleGrey1 => copyWith(color: AppColors.greyscaleGrey1);
  TextStyle get greyscaleGrey2 => copyWith(color: AppColors.greyscaleGrey2);
  TextStyle get greyscaleBlack1 => copyWith(color: AppColors.greyscaleBlack1);
  TextStyle get greyscaleBlack3 => copyWith(color: AppColors.greyscaleBlack3);
  TextStyle get primaryColor => copyWith(color: AppColors.primary);
  TextStyle get secondaryColor => copyWith(color: AppColors.secondary);
}
