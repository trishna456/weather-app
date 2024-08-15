class DailyWeather {
  final int date;
  final double minTemp;
  final double maxTemp;
  final String mainCondition;
  final String description;

  DailyWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.mainCondition,
    required this.description,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      date: json['dt'],
      minTemp: json['temp']['min'].toDouble(),
      maxTemp: json['temp']['max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
