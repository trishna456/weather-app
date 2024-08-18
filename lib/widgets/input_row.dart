import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/UI/input_field.dart';
import 'package:weather_app/widgets/UI/toggle_button.dart';
import 'package:weather_app/state/weather_state.dart';

class InputRow extends StatelessWidget {
  const InputRow({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherState = Provider.of<WeatherState>(context);
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // ---------- Input Field and Search Button aligned to left ----------
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: controller,
                    onSubmitted: () {
                      weatherState.fetchWeather(cityName: controller.text);
                      controller.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white70),
                  onPressed: () {
                    weatherState.fetchWeather(cityName: controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),

          // ---------- Spacer to push the toggle button to the right ----------
          const Spacer(),

          // ---------- Unit Toggle Switch ----------
          UnitToggleButton(
            units: weatherState.units,
            onToggle: (selectedUnit) {
              weatherState.setUnits(selectedUnit);
              weatherState.fetchWeather();
            },
          ),
        ],
      ),
    );
  }
}
