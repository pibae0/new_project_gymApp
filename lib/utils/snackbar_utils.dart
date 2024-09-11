import 'package:flutter/material.dart';
import 'package:gym_app_project/utils/const_colors.dart';

class SnackBarUtils {
  static void showSnackbar(
      BuildContext context, IconData icon, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.accent,
            ),
            const SizedBox(width: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.accent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
