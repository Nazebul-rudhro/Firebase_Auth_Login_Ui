import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login/core/constants/app_colors.dart';

class AppStyles {
  static TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle bodyStyle = TextStyle(fontSize: 16, color: Colors.grey);
  static final InputDecoration textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.topoPatternGrey.withOpacity(0.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
  );
}
