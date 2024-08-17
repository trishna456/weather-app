import 'package:flutter/material.dart';
import 'package:weather_app/widgets/input_field.dart';
import 'package:weather_app/widgets/toggle_button.dart';

class InputRow extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback fetchWeather;
  final String units;
  final ValueChanged<String> onToggle;

  const InputRow({
    super.key,
    required this.controller,
    required this.fetchWeather,
    required this.units,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // Input field and search button aligned to the left
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: controller,
                    onSubmitted: fetchWeather,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: fetchWeather,
                ),
              ],
            ),
          ),
          // Spacer to push the toggle button to the right
          const Spacer(),
          // Unit toggle switch aligned to the right
          UnitToggleButton(
            units: units,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
