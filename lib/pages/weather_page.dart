import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/input_row.dart';
import 'package:weather_app/widgets/current_weather/main_weather_info.dart';
import 'package:weather_app/widgets/current_weather/weather_info.dart';
import 'package:weather_app/widgets/custom_loading_widget.dart';
import 'package:weather_app/widgets/custom_error_widget.dart';
import 'package:weather_app/state/weather_state.dart';
import 'package:weather_app/widgets/weather_forecast/forecast_list.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ---------- Accessing WeatherState from Provider ----------
    final weatherState = Provider.of<WeatherState>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // ---------- Background Gradient ----------
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 9, 86, 145),
                Color.fromARGB(255, 12, 35, 54),
              ]),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // ---------- Input Row ----------
                  const InputRow(),

                  // ---------- Loading State ----------
                  if (weatherState.isLoading) ...[
                    const Expanded(child: CustomLoadingWidget()),
                  ]

                  // ---------- Error State ----------
                  else if (weatherState.error != null) ...[
                    const SizedBox(height: 20),
                    CustomErrorWidget(
                      errorMessage: weatherState.error!,
                    ),
                  ]

                  // ---------- Display Weather Information ----------
                  else if (weatherState.weather != null) ...[
                    Expanded(
                      child: Column(
                        children: [
                          // ---------- Main Weather Information ----------
                          MainWeatherInfo(
                            weather: weatherState.weather!,
                            units: weatherState.units,
                          ),

                          const SizedBox(height: 20),

                          // ---------- Additional Weather Details ----------
                          WeatherInfo(
                            weather: weatherState.weather!,
                            units: weatherState.units,
                          ),

                          // ---------- 5-Day Weather Forecast ----------
                          Expanded(
                            child: ForecastList(
                                dailyForecast:
                                    weatherState.weather!.dailyForecast),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
