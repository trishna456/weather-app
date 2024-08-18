import 'package:flutter/material.dart';

class UnitToggleButton extends StatelessWidget {
  final String units;
  final ValueChanged<String> onToggle;

  const UnitToggleButton({
    super.key,
    required this.units,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [units == 'metric', units == 'imperial'],
      onPressed: (index) {
        final selectedUnit = index == 0 ? 'metric' : 'imperial';
        onToggle(selectedUnit);
      },
      borderColor: const Color.fromARGB(255, 55, 154, 200).withOpacity(0.5),
      selectedBorderColor:
          const Color.fromARGB(255, 38, 146, 196).withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.white,
      color: Colors.white60,
      fillColor: const Color.fromARGB(
          255, 14, 115, 192), //Colors.blueAccent.withOpacity(0.7),
      constraints: const BoxConstraints(minHeight: 24, minWidth: 36),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            '°C',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            '°F',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
