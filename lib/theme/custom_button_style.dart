import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
      backgroundColor: appTheme.gray300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.h),
      ),
      disabledBackgroundColor: Colors.transparent,
      shadowColor: Colors.transparent);

  static ButtonStyle get fillOnPrimaryContainer => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      );

  // Outline button style
  static ButtonStyle get outlinePrimaryTL8 => OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side: BorderSide(
        color: theme.colorScheme.primary,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.h),
      ),
      shadowColor: Colors.transparent);

  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
