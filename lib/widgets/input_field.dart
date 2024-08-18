import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const InputField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'City Name',
        labelStyle: TextStyle(
          color: Colors.white70,
          fontSize: 14, // Smaller label text size
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(255, 71, 146, 221)), // Light blue border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(255, 19, 118, 218)), // Light blue border
        ),
        floatingLabelBehavior:
            FloatingLabelBehavior.never, // Hide label when typing
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onSubmitted: (value) => onSubmitted(),
    );
  }
}
