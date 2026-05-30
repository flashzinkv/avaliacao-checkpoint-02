import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/theme/app_colors.dart';

enum AppSnackbarType { success, error }

abstract final class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    required AppSnackbarType type,
  }) {
    final isSuccess = type == AppSnackbarType.success;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: isSuccess ? AppColors.limeGreen : AppColors.pink,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
          content: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: AppColors.darkNavy,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              Icon(
                isSuccess ? Icons.check : Icons.close,
                color: AppColors.darkNavy,
              ),
            ],
          ),
        ),
      );
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, type: AppSnackbarType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: AppSnackbarType.error);
  }
}
