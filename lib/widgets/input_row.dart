import 'package:flutter/material.dart';
import 'package:weather_app/widgets/input_field.dart';
import 'package:weather_app/widgets/toggle_button.dart';

class InputRow extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String units;
  final ValueChanged<String> onToggle;

  const InputRow({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.units,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              controller: controller,
              onSubmitted: onSearch,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: onSearch,
          ),
          const SizedBox(width: 10),
          UnitToggleButton(
            units: units,
            onToggle: onToggle,
          ),
        ],
      ),
    );
  }
}
