import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;

  const WeatherInfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 26),
        //const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 9),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: unit,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
