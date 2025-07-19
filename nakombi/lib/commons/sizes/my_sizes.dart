import 'package:flutter/material.dart';
import 'package:nacombi/commons/theme/app_colors.dart';

class MySizes {
  static const double padding = 16.0;
  static const double borderRadius = 8.0;
  static const double inputFieldRadius = 12.0;
  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(MySizes.borderRadius)),
    borderSide: BorderSide.none,
  );
  static OutlineInputBorder focusedOutlineInputBorder = outlineInputBorder
      .copyWith(
        borderSide: const BorderSide(width: 2, color: AppColors.primary),
      );
}
