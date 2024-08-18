import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Display the Lottie animation
        Opacity(
          opacity: 0.8,
          child: Lottie.asset(
            'assets/error.json',
            width: 400,
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 15),
        // Display the error message
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 237, 150, 150),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
