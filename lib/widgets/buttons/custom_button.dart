import 'package:flutter/material.dart';
import 'package:gym_app_project/utils/const_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final ElevatedButton? shape;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.padding,
      this.shape});

  @override
  //TODO: Colocar mais propriedades neste botoes para melhore design
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 30, horizontal: 130),
          backgroundColor: AppTheme.accent,
          foregroundColor: AppTheme.dark,
          shape: const LinearBorder()),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
