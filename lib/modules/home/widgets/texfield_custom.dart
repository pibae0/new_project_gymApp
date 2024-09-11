import 'package:flutter/material.dart';
import 'package:gym_app_project/utils/const_colors.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: cardBackgroundColor,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: "Busque pelo seu aluno",
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 21),
        ),
      ),
    );
  }
}
